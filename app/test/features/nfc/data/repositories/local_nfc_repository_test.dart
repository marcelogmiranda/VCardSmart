import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/data/datasources/nfc_datasource.dart';
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
