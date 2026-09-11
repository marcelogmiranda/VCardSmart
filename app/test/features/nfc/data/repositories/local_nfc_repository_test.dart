import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:vcardsmart/features/nfc/data/datasources/nfc_datasource.dart';
import 'package:vcardsmart/features/nfc/data/models/profile_vcard_converter.dart';
import 'package:vcardsmart/features/nfc/data/repositories/local_nfc_repository.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

import '../../nfc_channel_mock.dart';

void main() {
  late LocalNFCDataSource dataSource;
  late LocalNFCRepository repository;
  late NfcChannelMock nfcMock;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    dataSource = LocalNFCDataSource();
    repository = LocalNFCRepository(dataSource);
    nfcMock = NfcChannelMock()..install();
  });

  group('isAvailable', () {
    test('should return true when NFC is available', () async {
      final result = await repository.isAvailable();
      expect(result, true);
    });

    test('should return false when NFC is not available', () async {
      nfcMock.available = false;
      final result = await repository.isAvailable();
      expect(result, false);
    });
  });

  group('send', () {
    test('should store profile as NFC data', () async {
      final profile = Profile(
        id: '1',
        name: 'Test User',
        email: 'test@test.com',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await repository.send(profile);

      final received = await repository.receive();
      expect(received.name, 'Test User');
      expect(received.email, 'test@test.com');
    });

    test('should handle profile with all fields', () async {
      final profile = Profile(
        id: '2',
        name: 'Full Profile',
        email: 'full@test.com',
        phone: '123456',
        website: 'https://full.com',
        linkedin: 'linkedin.com/in/full',
        bio: 'Full bio',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await repository.send(profile);
      final received = await repository.receive();

      expect(received.name, 'Full Profile');
      expect(received.email, 'full@test.com');
      expect(received.phone, '123456');
      expect(received.website, 'https://full.com');
      expect(received.linkedin, 'linkedin.com/in/full');
      expect(received.bio, 'Full bio');
    });
    test('should forward the content selector to the datasource', () async {
      final profile = Profile(
        id: '4',
        name: 'Marcelo Miranda',
        phone: '+55 11 99999-0000',
        email: 'marcelo@vcardsmart.app',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final phoneMessage = NdefMessage([
        NdefRecord.createMime(
          ProfileVCardConverter.mimeType,
          utf8.encode(
            ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
          ),
        ),
      ]);
      // Full vCard does not fit, but several single fields do.
      nfcMock.tagMaxSize = phoneMessage.byteLength;
      var selectorCalled = false;

      await repository.send(
        profile,
        contentSelector: (options) async {
          selectorCalled = true;
          return options.first;
        },
      );

      expect(selectorCalled, true);
      expect(
        nfcMock.lastPayload(),
        ProfileVCardConverter.encodeFieldVCard(profile, ProfileField.phone),
      );
    });
  });

  group('receive', () {
    test('should throw when nothing was sent', () async {
      expect(
        repository.receive(),
        throwsException,
      );
    });

    test('should return profile after send', () async {
      final sent = Profile(
        id: '3',
        name: 'Receive Test',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await repository.send(sent);
      final received = await repository.receive();

      expect(received.name, 'Receive Test');
    });
  });

  group('cancel', () {
    test('should stop the session without error', () async {
      await repository.cancel();
    });
  });
}
