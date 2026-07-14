import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/domain/usecases/generate_qr_usecase.dart';
import 'package:vcardsmart/features/qr_code/domain/usecases/scan_qr_usecase.dart';
import 'package:vcardsmart/features/qr_code/domain/repositories/qr_repository.dart';
import 'package:vcardsmart/features/qr_code/domain/entities/qr_data.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  late _FakeQRRepository repository;

  setUp(() {
    repository = _FakeQRRepository();
  });

  group('GenerateQRUseCase', () {
    test('should generate QR data from profile', () async {
      final useCase = GenerateQRUseCase(repository);
      final profile = Profile(
        id: '1',
        name: 'Test User',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final result = await useCase(profile);

      expect(result, isNotEmpty);
      expect(result, contains('BEGIN:VCARD'));
    });
  });

  group('ScanQRUseCase', () {
    test('should decode QR data to profile', () async {
      final useCase = ScanQRUseCase(repository);
      const vCard = 'BEGIN:VCARD\nFN:Scanned User\nEND:VCARD';

      final result = await useCase(vCard);

      expect(result.name, 'Scanned User');
    });
  });
}

class _FakeQRRepository implements QRRepository {
  @override
  Future<String> generateQR(Profile profile) async {
    return 'BEGIN:VCARD\nFN:${profile.name}\nEND:VCARD';
  }

  @override
  Future<Profile> decodeQR(String data) async {
    final name = RegExp(r'FN:(.+)').firstMatch(data)?.group(1) ?? 'Unknown';
    final now = DateTime.now();
    return Profile(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  QRData encodeProfile(Profile profile) {
    return QRData(
      type: 'vcard',
      payload: 'BEGIN:VCARD\nFN:${profile.name}\nEND:VCARD',
      timestamp: DateTime.now(),
    );
  }
}
