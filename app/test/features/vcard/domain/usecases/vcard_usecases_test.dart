import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/vcard/domain/usecases/encode_vcard_usecase.dart';
import 'package:vcardsmart/features/vcard/domain/usecases/decode_vcard_usecase.dart';
import 'package:vcardsmart/features/vcard/domain/repositories/vcard_repository.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';

void main() {
  late _FakeVCardRepository repository;

  setUp(() {
    repository = _FakeVCardRepository();
  });

  group('EncodeVCardUseCase', () {
    test('should encode VCardData to string', () async {
      final useCase = EncodeVCardUseCase(repository);
      const data = VCardData(firstName: 'Test', email: 'test@test.com');

      final result = await useCase(data);

      expect(result, contains('BEGIN:VCARD'));
      expect(result, contains('FN:Test'));
    });
  });

  group('DecodeVCardUseCase', () {
    test('should decode string to VCardData', () async {
      final useCase = DecodeVCardUseCase(repository);
      const vcard = 'BEGIN:VCARD\nFN:Decoded User\nEND:VCARD';

      final result = await useCase(vcard);

      expect(result.firstName, 'Decoded');
      expect(result.lastName, 'User');
    });
  });
}

class _FakeVCardRepository implements VCardRepository {
  @override
  Future<String> encode(VCardData data) async {
    return 'BEGIN:VCARD\nVERSION:${data.version}\nFN:${data.fullName}\nEND:VCARD';
  }

  @override
  Future<VCardData> decode(String vcard) async {
    final name = RegExp(r'FN:(.+)').firstMatch(vcard)?.group(1) ?? 'Unknown';
    final parts = name.split(' ');
    return VCardData(
      firstName: parts.first,
      lastName: parts.length > 1 ? parts.sublist(1).join(' ') : null,
    );
  }

  @override
  Future<void> exportToFile(VCardData data, String path) async {}

  @override
  Future<VCardData> importFromFile(String path) async {
    return const VCardData(firstName: 'Imported');
  }
}
