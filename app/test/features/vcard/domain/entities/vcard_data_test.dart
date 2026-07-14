import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';

void main() {
  group('VCardData', () {
    test('should create with default version', () {
      const data = VCardData(firstName: 'João');
      expect(data.version, '3.0');
      expect(data.firstName, 'João');
    });

    test('fullName should combine first and last name', () {
      const data = VCardData(firstName: 'João', lastName: 'Silva');
      expect(data.fullName, 'João Silva');
    });

    test('fullName should handle single name', () {
      const data = VCardData(firstName: 'João');
      expect(data.fullName, 'João');
    });

    test('fullName should handle null names', () {
      const data = VCardData();
      expect(data.fullName, '');
    });

    test('copyWith should create new instance', () {
      const original = VCardData(firstName: 'João', email: 'joao@test.com');
      final updated = original.copyWith(lastName: 'Silva');

      expect(updated.firstName, 'João');
      expect(updated.lastName, 'Silva');
      expect(updated.email, 'joao@test.com');
    });

    test('copyWith should override fields', () {
      const original = VCardData(firstName: 'João', email: 'old@test.com');
      final updated = original.copyWith(email: 'new@test.com');

      expect(updated.email, 'new@test.com');
    });
  });
}
