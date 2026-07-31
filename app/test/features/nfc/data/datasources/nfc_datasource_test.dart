import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/data/datasources/nfc_datasource.dart';
import 'package:vcardsmart/features/nfc/domain/entities/nfc_data.dart';

import '../../nfc_channel_mock.dart';

void main() {
  late LocalNFCDataSource dataSource;
  late NfcChannelMock nfcMock;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    dataSource = LocalNFCDataSource();
    nfcMock = NfcChannelMock()..install();
  });

  group('checkAvailability', () {
    test('should return true when NFC is available', () async {
      nfcMock.available = true;
      final result = await dataSource.checkAvailability();
      expect(result, true);
    });

    test('should return false when NFC is not available', () async {
      nfcMock.available = false;
      final result = await dataSource.checkAvailability();
      expect(result, false);
    });
  });

  group('sendData', () {
    test('should write the profile payload to the NFC tag', () async {
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"Test"}',
        timestamp: DateTime(2024),
      );

      await dataSource.sendData(data);

      expect(nfcMock.writtenPayloads, ['{"name":"Test"}']);
    });
  });

  group('receiveData', () {
    test('should read the payload written to the tag', () async {
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"Received"}',
        timestamp: DateTime(2024),
      );
      nfcMock.writtenPayloads.add(data.payload);

      final received = await dataSource.receiveData();

      expect(received.type, 'profile');
      expect(received.payload, '{"name":"Received"}');
    });

    test('should throw when the tag has no data', () async {
      expect(
        dataSource.receiveData(),
        throwsException,
      );
    });
  });

  group('stopSession', () {
    test('should complete without error', () async {
      await dataSource.stopSession();
    });
  });
}
