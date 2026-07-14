import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/domain/usecases/send_nfc_usecase.dart';
import 'package:vcardsmart/features/nfc/domain/usecases/receive_nfc_usecase.dart';
import 'package:vcardsmart/features/nfc/domain/repositories/nfc_repository.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  late _FakeNFCRepository repository;

  setUp(() {
    repository = _FakeNFCRepository();
  });

  group('SendNFCUseCase', () {
    test('should send profile via NFC', () async {
      final useCase = SendNFCUseCase(repository);
      final profile = Profile(
        id: '1',
        name: 'Test User',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await useCase(profile);

      expect(repository.wasSent, true);
      expect(repository.sentProfile?.name, 'Test User');
    });
  });

  group('ReceiveNFCUseCase', () {
    test('should receive profile via NFC', () async {
      repository.receivedProfile = Profile(
        id: '2',
        name: 'Received User',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final useCase = ReceiveNFCUseCase(repository);

      final result = await useCase();

      expect(result.name, 'Received User');
      expect(repository.wasReceived, true);
    });
  });
}

class _FakeNFCRepository implements NFCRepository {
  bool wasSent = false;
  bool wasReceived = false;
  Profile? sentProfile;
  Profile? receivedProfile;

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> send(Profile profile) async {
    wasSent = true;
    sentProfile = profile;
  }

  @override
  Future<Profile> receive() async {
    wasReceived = true;
    return receivedProfile ?? Profile(
      id: '0',
      name: 'Default',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );
  }

  @override
  Future<void> cancel() async {}
}
