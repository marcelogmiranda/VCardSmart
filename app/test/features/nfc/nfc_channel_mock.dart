import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _nfcChannelName = 'plugins.flutter.io/nfc_manager';

/// Mock for the `nfc_manager` platform channel so NFC code can be tested
/// without a real NFC-capable device.
class NfcChannelMock {
  final List<String> writtenPayloads = [];
  bool available = true;
  int sessionStarts = 0;

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
            Future<void>.delayed(Duration.zero, dispatchOnDiscovered);
            return null;
          case 'Nfc#stopSession':
            return null;
          case 'Nfc#disposeTag':
            return null;
          case 'Ndef#write':
            final message = (call.arguments as Map)['message'] as Map;
            final records = (message['records'] as List).cast<Map>();
            final payloadBytes = records.isEmpty
                ? null
                : records.first['payload'] as Uint8List;
            if (payloadBytes != null) {
              writtenPayloads.add(utf8.decode(payloadBytes));
            }
            return null;
          case 'Ndef#read':
            final payload = lastPayload();
            return payload == null ? {'records': []} : _messageMap(payload);
          default:
            return null;
        }
      },
    );
  }

  String? lastPayload() =>
      writtenPayloads.isEmpty ? null : writtenPayloads.last;

  Future<void> dispatchOnDiscovered() async {
    final messenger = TestDefaultBinaryMessengerBinding.instance
        .defaultBinaryMessenger;
    final payload = lastPayload();
    final tag = <String, dynamic>{
      'handle': 'test-tag',
      'ndef': {
        'isWritable': true,
        'maxSize': 500,
        if (payload != null) 'cachedMessage': _messageMap(payload),
      },
    };
    await messenger.handlePlatformMessage(
      _nfcChannelName,
      const StandardMethodCodec()
          .encodeMethodCall(MethodCall('onDiscovered', tag)),
      (_) {},
    );
  }

  Map<String, dynamic> _messageMap(String payload) => {
        'records': [
          {
            'typeNameFormat': 2,
            'type': Uint8List.fromList(
              utf8.encode('application/vcardsmart/profile'),
            ),
            'identifier': Uint8List.fromList([]),
            'payload': Uint8List.fromList(utf8.encode(payload)),
          },
        ],
      };
}
