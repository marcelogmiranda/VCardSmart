import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:vcardsmart/features/nfc/data/datasources/nfc_datasource.dart';
import 'package:vcardsmart/features/nfc/data/models/nfc_write_option.dart';
import 'package:vcardsmart/features/nfc/data/models/profile_vcard_converter.dart';
import 'package:vcardsmart/features/nfc/domain/entities/nfc_data.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

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

    test('should write the full vCard directly without asking when it fits',
        () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final fullVCard = ProfileVCardConverter.encodeProfile(profile);
      nfcMock.tagMaxSize = _mimeMessage(fullVCard).byteLength;
      final data = NFCData(
        type: 'profile',
        payload: fullVCard,
        timestamp: DateTime(2024),
      );
      var selectorCalls = 0;

      await dataSource.sendData(
        data,
        profile: profile,
        contentSelector: (options) async {
          selectorCalls++;
          return options.first;
        },
      );

      expect(selectorCalls, 0);
      expect(nfcMock.writtenPayloads.single, fullVCard);
    });

    test('should write the only fitting field directly without asking',
        () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final emailMessage = _mimeMessage(
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.email),
      );
      nfcMock.tagMaxSize = emailMessage.byteLength;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );
      var selectorCalls = 0;

      await dataSource.sendData(
        data,
        profile: profile,
        contentSelector: (options) async {
          selectorCalls++;
          return options.first;
        },
      );

      expect(selectorCalls, 0);
      expect(
        nfcMock.writtenPayloads.single,
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.email),
      );
    });

    test('should ask the user through the selector when several fields fit',
        () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final phoneMessage = _mimeMessage(
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
      // The full vCard is too big, but the phone and e-mail both fit.
      nfcMock.tagMaxSize = phoneMessage.byteLength;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );
      List<String>? askedTitles;
      NfcWriteOption? chosen;

      await dataSource.sendData(
        data,
        profile: profile,
        contentSelector: (options) async {
          askedTitles = options.map((o) => o.title).toList();
          chosen = options.firstWhere((o) => o.field == ProfileField.email);
          return chosen;
        },
      );

      expect(askedTitles, isNotNull);
      expect(askedTitles, ['Telefone', 'E-mail']);
      expect(
        nfcMock.writtenPayloads.single,
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.email),
      );
      expect(chosen!.title, 'E-mail');
    });

    test('should write the first fitting field when no selector is provided',
        () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final phoneMessage = _mimeMessage(
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
      nfcMock.tagMaxSize = phoneMessage.byteLength;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );

      await dataSource.sendData(data, profile: profile);

      // Options: [Telefone, E-mail] — the first one is written automatically.
      expect(
        nfcMock.writtenPayloads.single,
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
    });

    test('should present only options that actually fit', () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        instagram: List.filled(200, 'x').join(),
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final phoneMessage = _mimeMessage(
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
      // Phone and e-mail fit; the bloated Instagram field does not.
      nfcMock.tagMaxSize = phoneMessage.byteLength;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );
      List<String>? askedTitles;

      await dataSource.sendData(
        data,
        profile: profile,
        contentSelector: (options) async {
          askedTitles = options.map((o) => o.title).toList();
          return options.first;
        },
      );

      expect(askedTitles, ['Telefone', 'E-mail']);
    });

    test('should cancel cleanly when the selector returns null', () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final phoneMessage = _mimeMessage(
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
      nfcMock.tagMaxSize = phoneMessage.byteLength;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );

      await expectLater(
        dataSource.sendData(
          data,
          profile: profile,
          contentSelector: (options) async => null,
        ),
        throwsA(
          isA<LocalNFCException>().having(
            (e) => e.message,
            'message',
            'Gravação cancelada.',
          ),
        ),
      );
      expect(nfcMock.writtenPayloads, isEmpty);
    });

    test('should throw when the tag is too small for every candidate',
        () async {
      final profile = Profile(
        id: 'p1',
        name: 'Marcelo Miranda',
        website: 'https://vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      nfcMock.tagMaxSize = 1;
      final data = NFCData(
        type: 'profile',
        payload: ProfileVCardConverter.encodeProfile(profile),
        timestamp: DateTime(2024),
      );

      await expectLater(
        dataSource.sendData(data, profile: profile),
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

NdefMessage _mimeMessage(String payload) => NdefMessage([
      NdefRecord.createMime(
        ProfileVCardConverter.mimeType,
        utf8.encode(payload),
      ),
    ]);
