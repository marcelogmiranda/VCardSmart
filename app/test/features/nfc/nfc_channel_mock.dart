import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _nfcChannelName = 'plugins.flutter.io/nfc_manager';

/// Convenience helpers for building NDEF record maps like the ones the
/// `nfc_manager` platform channel returns on iOS.
class NfcRecordMock {
  static Map<String, dynamic> mime(String type, String payload) {
    return {
      'typeNameFormat': 2, // media
      'type': Uint8List.fromList(utf8.encode(type)),
      'identifier': Uint8List.fromList([]),
      'payload': Uint8List.fromList(utf8.encode(payload)),
    };
  }

  /// A well-known URI record (the 'U' record type written by NFC Tools).
  static Map<String, dynamic> uri(String prefix, String rest) {
    const prefixes = [
      '',
      'http://www.',
      'https://www.',
      'http://',
      'https://',
      'tel:',
      'mailto:',
    ];
    final index = prefixes.indexOf(prefix);
    if (index < 0) {
      throw ArgumentError('Unsupported URI prefix: $prefix');
    }
    final bytes = <int>[index, ...utf8.encode(rest)];
    return {
      'typeNameFormat': 1, // nfcWellknown
      'type': Uint8List.fromList(utf8.encode('U')),
      'identifier': Uint8List.fromList([]),
      'payload': Uint8List.fromList(bytes),
    };
  }

  /// A well-known Text record (the 'T' record type). The first byte holds the
  /// status (bit 7: UTF-8) plus the language code length.
  static Map<String, dynamic> text(String text, {String languageCode = 'en'}) {
    final langBytes = utf8.encode(languageCode);
    final bytes = <int>[
      0 | langBytes.length,
      ...langBytes,
      ...utf8.encode(text),
    ];
    return {
      'typeNameFormat': 1, // nfcWellknown
      'type': Uint8List.fromList(utf8.encode('T')),
      'identifier': Uint8List.fromList([]),
      'payload': Uint8List.fromList(bytes),
    };
  }
}

/// Mock for the `nfc_manager` platform channel so NFC code can be tested
/// without a real NFC-capable device.
class NfcChannelMock {
  final List<String> writtenPayloads = [];
  bool available = true;
  int sessionStarts = 0;

  /// Tag characteristics reported when a tag is "discovered".
  bool tagIsWritable = true;
  int tagMaxSize = 500;

  /// Pre-set tag content (records). When null, the tag is empty and the
  /// mock rebuilds the NDEF message from the last written payload.
  List<Map<String, dynamic>>? cachedRecords;

  /// When true, `startSession` dispatches `onError` instead of `onDiscovered`.
  bool failSession = false;
  String? failSessionType = 'sessionTimeout';
  String failSessionMessage = 'Session timed out';

  void install() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel(_nfcChannelName),
      (call) async {
        switch (call.method) {
          case 'Nfc#isAvailable':
            return available;
          case 'Nfc#startSession':
            sessionStarts++;
            if (failSession) {
              Future<void>.delayed(Duration.zero, dispatchSessionError);
            } else {
              Future<void>.delayed(Duration.zero, dispatchOnDiscovered);
            }
            return null;
          case 'Nfc#stopSession':
            return null;
          case 'Nfc#disposeTag':
            return null;
          case 'Ndef#write':
            final message = (call.arguments as Map)['message'] as Map;
            final records = (message['records'] as List).cast<Map>();
            final payloadBytes =
                records.isEmpty ? null : records.first['payload'] as Uint8List;
            if (payloadBytes != null) {
              writtenPayloads.add(utf8.decode(payloadBytes));
            }
            return null;
          case 'Ndef#read':
            final records = cachedRecords ??
                (writtenPayloads.isEmpty
                    ? []
                    : [_mimeRecord(writtenPayloads.last)]);
            return {'records': records};
          default:
            return null;
        }
      },
    );
  }

  String? lastPayload() =>
      writtenPayloads.isEmpty ? null : writtenPayloads.last;

  Future<void> dispatchOnDiscovered() async {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    final records = cachedRecords ??
        (writtenPayloads.isEmpty ? [] : [_mimeRecord(writtenPayloads.last)]);
    final tag = <String, dynamic>{
      'handle': 'test-tag',
      'ndef': {
        'isWritable': tagIsWritable,
        'maxSize': tagMaxSize,
        'cachedMessage': {
          'records': records,
        },
      },
    };
    await messenger.handlePlatformMessage(
      _nfcChannelName,
      const StandardMethodCodec()
          .encodeMethodCall(MethodCall('onDiscovered', tag)),
      (_) {},
    );
  }

  Future<void> dispatchSessionError() async {
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    final error = <String, dynamic>{
      'type': failSessionType,
      'message': failSessionMessage,
    };
    await messenger.handlePlatformMessage(
      _nfcChannelName,
      const StandardMethodCodec()
          .encodeMethodCall(MethodCall('onError', error)),
      (_) {},
    );
  }

  Map<String, dynamic> _mimeRecord(String payload) => {
        'typeNameFormat': 2,
        'type': Uint8List.fromList(
          utf8.encode('application/vcardsmart/profile'),
        ),
        'identifier': Uint8List.fromList([]),
        'payload': Uint8List.fromList(utf8.encode(payload)),
      };
}
