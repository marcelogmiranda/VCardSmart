import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/utils/qr_utils.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('QRUtils', () {
    late Profile testProfile;

    setUp(() {
      testProfile = Profile(
        id: '1',
        name: 'Test User',
        email: 'test@email.com',
        phone: '+5511999999999',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
    });

    test('generateVCardString should return vCard format', () {
      final result = QRUtils.generateVCardString(testProfile);

      expect(result, contains('BEGIN:VCARD'));
      expect(result, contains('FN:Test User'));
      expect(result, contains('END:VCARD'));
    });

    test('parseVCardString should return Profile', () {
      const vCard = 'BEGIN:VCARD\n'
          'VERSION:3.0\n'
          'FN:Parsed User\n'
          'EMAIL:parsed@email.com\n'
          'END:VCARD';

      final profile = QRUtils.parseVCardString(vCard);

      expect(profile.name, 'Parsed User');
      expect(profile.email, 'parsed@email.com');
    });

    test('encodeToBase64 should encode string', () {
      final encoded = QRUtils.encodeToBase64('hello');
      expect(encoded, isNotEmpty);
      expect(encoded, isNot('hello'));
    });

    test('decodeFromBase64 should decode string', () {
      final encoded = QRUtils.encodeToBase64('hello');
      final decoded = QRUtils.decodeFromBase64(encoded);
      expect(decoded, 'hello');
    });

    test('encode and decode should be reversible', () {
      const original = 'Test data 123';
      final encoded = QRUtils.encodeToBase64(original);
      final decoded = QRUtils.decodeFromBase64(encoded);
      expect(decoded, original);
    });
  });
}
