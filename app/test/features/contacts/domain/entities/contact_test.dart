import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

void main() {
  group('Contact', () {
    test('should create Contact with required fields', () {
      final now = DateTime(2024);
      final contact = Contact(
        id: '1',
        name: 'John Doe',
        source: 'qr',
        importedAt: now,
      );

      expect(contact.id, '1');
      expect(contact.name, 'John Doe');
      expect(contact.source, 'qr');
      expect(contact.importedAt, now);
      expect(contact.email, isNull);
      expect(contact.phone, isNull);
    });

    test('should create Contact with all fields', () {
      final now = DateTime(2024);
      final contact = Contact(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@test.com',
        phone: '123456',
        linkedin: 'linkedin.com/in/jane',
        website: 'https://jane.com',
        bio: 'Developer',
        source: 'vcard',
        importedAt: now,
      );

      expect(contact.name, 'Jane Smith');
      expect(contact.email, 'jane@test.com');
      expect(contact.phone, '123456');
      expect(contact.linkedin, 'linkedin.com/in/jane');
      expect(contact.website, 'https://jane.com');
      expect(contact.bio, 'Developer');
    });

    test('copyWith should create new instance', () {
      final now = DateTime(2024);
      final original = Contact(
        id: '3',
        name: 'Original',
        source: 'nfc',
        importedAt: now,
      );

      final copy = original.copyWith(name: 'Updated', email: 'up@test.com');

      expect(copy.name, 'Updated');
      expect(copy.email, 'up@test.com');
      expect(copy.id, '3');
      expect(copy.source, 'nfc');
    });

    test('copyWith should keep existing fields when not provided', () {
      final now = DateTime(2024);
      final original = Contact(
        id: '4',
        name: 'Keep',
        email: 'keep@test.com',
        source: 'qr',
        importedAt: now,
      );

      final copy = original.copyWith();

      expect(copy.name, 'Keep');
      expect(copy.email, 'keep@test.com');
      expect(copy.source, 'qr');
    });

    test('copyWith should update source', () {
      final now = DateTime(2024);
      final original = Contact(
        id: '5',
        name: 'Test',
        source: 'qr',
        importedAt: now,
      );

      final copy = original.copyWith(source: 'nfc');

      expect(copy.source, 'nfc');
    });
  });
}
