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

    test('should throw a friendly error when the tag is read-only', () async {
      nfcMock.tagIsWritable = false;
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"Test"}',
        timestamp: DateTime(2024),
      );

      await expectLater(
        dataSource.sendData(data),
        throwsA(
          isA<LocalNFCException>().having(
            (e) => e.message,
            'message',
            contains('é um NTAG gravável'),
          ),
        ),
      );
    });

    test('should throw when the payload exceeds the tag capacity', () async {
      nfcMock.tagMaxSize = 10;
      final data = NFCData(
        type: 'profile',
        payload: '{"name":"Este perfil é grande demais para caber"}',
        timestamp: DateTime(2024),
      );

      await expectLater(
        dataSource.sendData(data),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'toString',
            contains('precisa de'),
          ),
        ),
      );
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

    test('should read a URI record written by a tag writer app', () async {
      nfcMock.cachedRecords = [
        NfcRecordMock.uri('https://', 'instagram.com/marcelo'),
      ];

      final received = await dataSource.receiveData();

      expect(received.type, 'profile');
      expect(received.payload, 'https://instagram.com/marcelo');
    });

    test('should read a Text record written by a tag writer app', () async {
      nfcMock.cachedRecords = [
        NfcRecordMock.text('Olá, este é um cartão!'),
      ];

      final received = await dataSource.receiveData();

      expect(received.payload, 'Olá, este é um cartão!');
    });

    test('should throw a friendly error when the session times out', () async {
      nfcMock.failSession = true;
      nfcMock.failSessionType = 'userCanceled';

      await expectLater(
        dataSource.receiveData(),
        throwsA(
          isA<LocalNFCException>().having(
            (e) => e.message,
            'message',
            'Leitura cancelada.',
          ),
        ),
      );
    });

    test('should throw a friendly error on session timeout', () async {
      nfcMock.failSession = true;
      nfcMock.failSessionType = 'sessionTimeout';
      nfcMock.failSessionMessage = 'Session timed out';

      await expectLater(
        dataSource.receiveData(),
        throwsA(
          isA<LocalNFCException>().having(
            (e) => e.message,
            'message',
            contains('Nenhum cartão foi encontrado'),
          ),
        ),
      );
    });

    test('should throw a friendly error when the tag has no data', () async {
      expect(
        dataSource.receiveData(),
        throwsA(
          isA<LocalNFCException>().having(
            (e) => e.message,
            'message',
            contains('Nenhum conteúdo encontrado'),
          ),
        ),
      );
    });
  });

  group('stopSession', () {
    test('should complete without error', () async {
      await dataSource.stopSession();
    });
  });
}
