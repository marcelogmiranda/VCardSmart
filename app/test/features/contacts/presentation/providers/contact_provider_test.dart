import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

void main() {
  group('ContactListStatus', () {
    test('should have default values', () {
      const status = ContactListStatus();
      expect(status.status, ContactStatus.idle);
      expect(status.contacts, isEmpty);
      expect(status.error, isNull);
    });

    test('copyWith should create new state', () {
      const status = ContactListStatus();
      final updated = status.copyWith(
        status: ContactStatus.success,
        contacts: [
          Contact(id: '1', name: 'A', source: 'qr', importedAt: DateTime(2024)),
        ],
      );

      expect(updated.status, ContactStatus.success);
      expect(updated.contacts.length, 1);
      expect(updated.error, isNull);
    });

    test('copyWith should clear error', () {
      const status = ContactListStatus(error: 'old error');
      final updated = status.copyWith();

      expect(updated.error, isNull);
    });
  });
}
