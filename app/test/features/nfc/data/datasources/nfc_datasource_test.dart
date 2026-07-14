import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/data/datasources/nfc_datasource.dart';
import 'package:vcardsmart/features/nfc/domain/entities/nfc_data.dart';

void main() {
  late LocalNFCDataSource dataSource;

  setUp(() {
    dataSource = LocalNFCDataSource();
  });

  group('checkAvailability', () {
    test('should return true', () async {
      final result = await dataSource.checkAvailability();
      expect(result, true);
    });
  });

  group('sendData', () {
    test('should store pending data', () async {
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"Test"}',
        timestamp: DateTime(2024),
      );

      await dataSource.sendData(data);

      // After sending, receiving should return the stored data
      final received = await dataSource.receiveData();
      expect(received.payload, '{"name":"Test"}');
      expect(received.type, 'profile');
    });
  });

  group('receiveData', () {
    test('should return default data when no data pending', () async {
      final received = await dataSource.receiveData();
      expect(received.type, 'profile');
      expect(received.payload, '{}');
      expect(received.timestamp, isNotNull);
    });

    test('should return sent data after send', () async {
      final data = NFCData(
        type: 'vcard',
        payload: 'VCARD_DATA',
        timestamp: DateTime(2024, 6, 15),
      );
      await dataSource.sendData(data);

      final received = await dataSource.receiveData();
      expect(received.payload, 'VCARD_DATA');
      expect(received.type, 'vcard');
    });
  });

  group('stopSession', () {
    test('should clear pending data', () async {
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"To be cleared"}',
        timestamp: DateTime(2024),
      );
      await dataSource.sendData(data);
      await dataSource.stopSession();

      final received = await dataSource.receiveData();
      expect(received.payload, '{}');
    });
  });
}
