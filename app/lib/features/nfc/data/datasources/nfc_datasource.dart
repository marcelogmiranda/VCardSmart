import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../profile/domain/entities/profile.dart';
import '../../domain/entities/nfc_data.dart';
import '../models/profile_vcard_converter.dart';

abstract class NFCDataSource {
  Future<bool> checkAvailability();
  Future<void> sendData(NFCData data, {Profile? profile});
  Future<NFCData> receiveData();
  Future<void> stopSession();
}

class LocalNFCDataSource implements NFCDataSource {
  @override
  Future<bool> checkAvailability() async {
    try {
      return await NfcManager.instance.isAvailable();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> sendData(NFCData data, {Profile? profile}) async {
    final completer = Completer<void>();
    // Candidate NDEF messages in preference order. The full vCard is the most
    // useful but often exceeds small tags (an NTAG213 holds ~144 bytes), so we
    // progressively slim it down: full vCard -> minimal vCard -> a single URI
    // record linking to the profile. The actual tag's capacity decides.
    final candidates = <NdefMessage>[
      _vcardMessage(data.payload),
      if (profile != null) _vcardMessage(ProfileVCardConverter.encodeMinimalVCard(profile)),
      if (profile != null) ..._uriMessages(profile),
    ];

    try {
      await NfcManager.instance.startSession(
        alertMessage: 'Aproxime o iPhone de um cartão NFC para gravar',
        // Exclude iso18092 (FeliCa): on iOS it requires the
        // `felica.systemcodes` entitlement, otherwise the whole session
        // fails with "Missing required entitlement" (NFCError code 2) on
        // iOS 26.2+. NTAG (Type 2) and ISO15693 tags are covered by the
        // two options below.
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
        onDiscovered: (tag) async {
          Ndef? ndef;
          try {
            ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              completer.completeError(_nfcWriteUnsupported);
            } else {
              final maxSize = ndef.maxSize;
              NdefMessage? toWrite;
              for (final candidate in candidates) {
                if (candidate.byteLength <= maxSize) {
                  toWrite = candidate;
                  break;
                }
              }
              if (toWrite == null) {
                completer.completeError(
                  Exception(
                    'O perfil não cabe neste cartão NFC '
                    '(precisa de ${candidates.first.byteLength} bytes, '
                    'o cartão aceita $maxSize). '
                    'Use um cartão com mais capacidade (ex.: NTAG215/216).',
                  ),
                );
              } else {
                debugPrint(
                  '[NFC-send] writing ${toWrite.byteLength}/$maxSize bytes '
                  '(${toWrite == candidates.first ? 'full vCard' : toWrite == candidates[1] ? 'minimal vCard' : 'URI link'})',
                );
                await ndef.write(toWrite);
                completer.complete();
              }
            }
          } on Error catch (e) {
            debugPrint('[NFC-send] Error: $e');
            if (!completer.isCompleted) {
              completer.completeError(
                Exception('Falha ao gravar no cartão: ${e.runtimeType}.'),
              );
            }
          } on Exception catch (e) {
            debugPrint('[NFC-send] Exception: $e');
            // Writes to a locked/write-protected tag typically throw a
            // "Tag is read only" style error from the platform.
            final messageText = e.toString();
            final isReadOnly =
                messageText.toLowerCase().contains('read only') ||
                    messageText.toLowerCase().contains('read-only') ||
                    messageText.toLowerCase().contains('permission');
            if (!completer.isCompleted) {
              completer.completeError(
                isReadOnly
                    ? const LocalNFCException._(
                        'Este cartão está protegido contra '
                        'gravação. Use um cartão gravável (NTAG213/215/216).',
                      )
                    : e,
              );
            }
          }
          await NfcManager.instance.stopSession(
            alertMessage: 'Perfil gravado com sucesso!',
          );
        },
        onError: (error) async {
          debugPrint('[NFC-send] sessionOnError: ${error.type} / ${error.message}');
          if (!completer.isCompleted) {
            completer.completeError(_mapSessionError(error, 'gravar'));
          }
        },
      );
    } catch (e) {
      final messageText = e.toString();
      final alreadyStarted =
          messageText.toLowerCase().contains('already started') ||
              messageText.toLowerCase().contains('in progress') ||
              messageText.toLowerCase().contains('session');
      if (!completer.isCompleted) {
        completer.completeError(
          alreadyStarted
              ? const LocalNFCException._(
                  'Outra sessão NFC ainda está ativa. Espere um instante e tente de novo.')
              : e,
        );
      }
    }

    return completer.future;
  }

  @override
  Future<NFCData> receiveData() async {
    final completer = Completer<NFCData>();

    try {
      await NfcManager.instance.startSession(
        alertMessage: 'Aproxime o iPhone de um cartão NFC para ler',
        // Same rationale as sendData: polling iso18092 (FeliCa) fails with
        // "Missing required entitlement" on iOS without the FeliCa systemcodes
        // entitlement.
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
        onDiscovered: (tag) async {
          Ndef? ndef;
          try {
            ndef = Ndef.from(tag);
            if (ndef == null) {
              completer.completeError(
                const LocalNFCException._(
                  'Este cartão não suporta o formato NDEF usado pelo app.',
                ),
              );
            } else {
              final message = ndef.cachedMessage ?? await ndef.read();
              if (message.records.isEmpty) {
                completer.completeError(
                  const LocalNFCException._(
                    'Nenhum conteúdo encontrado neste cartão NFC.',
                  ),
                );
              } else {
                final payload = _extractPayload(message);
                if (payload == null || payload.isEmpty) {
                  completer.completeError(
                    const LocalNFCException._(
                      'Não foi possível ler o conteúdo deste cartão.',
                    ),
                  );
                } else {
                  completer.complete(
                    NFCData(
                      type: 'profile',
                      payload: payload,
                      timestamp: DateTime.now(),
                    ),
                  );
                }
              }
            }
          } on Error catch (e) {
            debugPrint('[NFC-read] Error: $e');
            if (!completer.isCompleted) {
              completer.completeError(
                const LocalNFCException._(
                  'Falha ao ler o cartão. Segure-o firme e tente de novo.',
                ),
              );
            }
          } on Exception catch (e) {
            debugPrint('[NFC-read] Exception: $e');
            if (!completer.isCompleted) {
              completer.completeError(e);
            }
          }
          await NfcManager.instance.stopSession();
        },
        onError: (error) async {
          debugPrint('[NFC-read] sessionOnError: ${error.type} / ${error.message}');
          if (!completer.isCompleted) {
            completer.completeError(_mapSessionError(error, 'ler'));
          }
        },
      );
    } catch (e) {
      debugPrint('[NFC-read] startSession threw: $e');
      if (!completer.isCompleted) completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }

  /// Decodes the first NDEF record into a plain string, handling the well-known
  /// URI and Text record types used by NFC tag writer apps (e.g. NFC Tools).
  String? _extractPayload(NdefMessage message) {
    final first = message.records.first;
    switch (first.typeNameFormat) {
      case NdefTypeNameFormat.nfcWellknown:
        final recordType = String.fromCharCodes(first.type);
        final payload = first.payload;
        if (recordType == 'U') {
          // URI record: first byte is the prefix index, the rest is the URI.
          if (payload.isEmpty) return null;
          final prefixIndex = payload.first;
          final base =
              prefixIndex < NdefRecord.URI_PREFIX_LIST.length
                  ? NdefRecord.URI_PREFIX_LIST[prefixIndex]
                  : '';
          final rest = utf8.decode(payload.sublist(1), allowMalformed: true);
          return '$base$rest';
        }
        if (recordType == 'T') {
          // Text record: first byte has the language code length.
          final languageLength = payload.first & 0x3F;
          final text = payload.length > languageLength
              ? utf8.decode(
                  payload.sublist(languageLength + 1),
                  allowMalformed: true,
                )
              : '';
          return text;
        }
        return utf8.decode(payload, allowMalformed: true);
      case NdefTypeNameFormat.media:
      case NdefTypeNameFormat.nfcExternal:
      case NdefTypeNameFormat.absoluteUri:
        return utf8.decode(first.payload, allowMalformed: true);
      case NdefTypeNameFormat.empty:
      case NdefTypeNameFormat.unknown:
      case NdefTypeNameFormat.unchanged:
        return null;
    }
  }

  Exception _mapSessionError(NfcError error, String operation) {
    switch (error.type) {
      case NfcErrorType.sessionTimeout:
        return const LocalNFCException._(
          'Nenhum cartão foi encontrado. Segure o cartão na parte de trás do '
          'iPhone, próximo à câmera, e tente de novo.',
        );
      case NfcErrorType.userCanceled:
        return const LocalNFCException._('Leitura cancelada.');
      case NfcErrorType.systemIsBusy:
        return const LocalNFCException._(
          'O sistema está ocupado. Aguarde um instante e tente de novo.',
        );
      case NfcErrorType.unknown:
        final detail = error.message;
        final lower = detail.toLowerCase();
        if (lower.contains('entitlement') ||
            lower.contains('required') ||
            lower.contains('unsupported') ||
            lower.contains('not compatible')) {
          return const LocalNFCException._(
            'Falha de segurança: este aparelho/sessão não autorizou a '
            'leitura/gravação NFC.',
          );
        }
        return LocalNFCException._(
          detail.isNotEmpty
              ? 'Falha de NFC ($operation): $detail'
              : 'Falha ao $operation via NFC. Tente de novo.',
        );
    }
  }

  static const Exception _nfcWriteUnsupported = LocalNFCException._(
    'Este cartão não aceita a gravação de contatos (não é um NTAG gravável '
    'ou está protegido). Use um NTAG213/215/216.',
  );

  static NdefMessage _vcardMessage(String payload) {
    return NdefMessage([
      NdefRecord.createMime(
        ProfileVCardConverter.mimeType,
        utf8.encode(payload),
      ),
    ]);
  }

  /// Builds a single URI-record message linking to the profile (fallback for
  /// tags too small for even a minimal vCard).
  List<NdefMessage> _uriMessages(Profile profile) {
    final url = ProfileVCardConverter.profileUrl(profile);
    if (url == null || url.isEmpty) return const [];
    return [
      NdefMessage([NdefRecord.createUri(Uri.parse(url))]),
    ];
  }
}

/// A user-facing NFC error with a message safe to show in the UI.
class LocalNFCException implements Exception {
  final String message;

  const LocalNFCException._(this.message);

  @override
  String toString() => message;
}