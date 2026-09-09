import 'dart:async';
import 'dart:convert';

import 'package:nfc_manager/nfc_manager.dart';

import '../../domain/entities/nfc_data.dart';
import '../models/profile_vcard_converter.dart';

abstract class NFCDataSource {
  Future<bool> checkAvailability();
  Future<void> sendData(NFCData data);
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
  Future<void> sendData(NFCData data) async {
    final completer = Completer<void>();
    // Write a standard vCard so the tag is readable by any phone's Contacts app.
    final record = NdefRecord.createMime(
      ProfileVCardConverter.mimeType,
      utf8.encode(data.payload),
    );
    final message = NdefMessage([record]);

    try {
      await NfcManager.instance.startSession(
        alertMessage: 'Aproxime o celular de um cartão NFC para gravar',
        onDiscovered: (tag) async {
          try {
            final ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              throw Exception('Tag NFC não suportada ou não gravável');
            }
            await ndef.write(message);
            if (!completer.isCompleted) completer.complete();
          } catch (e) {
            if (!completer.isCompleted) completer.completeError(e);
          }
          await NfcManager.instance.stopSession(
            alertMessage: 'Perfil gravado com sucesso!',
          );
        },
        onError: (error) async {
          if (!completer.isCompleted) {
            completer.completeError(
              Exception('Sessão NFC cancelada ou indisponível.'),
            );
          }
        },
      );
    } catch (e) {
      if (!completer.isCompleted) completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<NFCData> receiveData() async {
    final completer = Completer<NFCData>();

    try {
      await NfcManager.instance.startSession(
        alertMessage: 'Aproxime o celular de um cartão NFC para ler',
        onDiscovered: (tag) async {
          try {
            final ndef = Ndef.from(tag);
            if (ndef == null) {
              throw Exception('Tag NFC não suportada');
            }
            final message = ndef.cachedMessage ?? await ndef.read();
            if (message.records.isEmpty) {
              throw Exception('Nenhum dado encontrado na tag NFC');
            }
            final rawPayload = utf8.decode(message.records.first.payload);
            // Preserve the raw payload; the repository decodes it into a Profile.
            if (!completer.isCompleted) {
              completer.complete(
                NFCData(
                  type: 'profile',
                  payload: rawPayload,
                  timestamp: DateTime.now(),
                ),
              );
            }
          } catch (e) {
            if (!completer.isCompleted) completer.completeError(e);
          }
          await NfcManager.instance.stopSession();
        },
        onError: (error) async {
          if (!completer.isCompleted) {
            completer.completeError(
              Exception('Sessão NFC cancelada ou indisponível.'),
            );
          }
        },
      );
    } catch (e) {
      if (!completer.isCompleted) completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }
}
