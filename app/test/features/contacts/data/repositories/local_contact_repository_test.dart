import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/data/repositories/local_contact_repository.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

void main() {
  late LocalContactRepository repository;

  setUp(() {
    repository = LocalContactRepository();
  });

  group('getAllContacts', () {
    test('should return empty list initially', () async {
      final contacts = await repository.getAllContacts();
      expect(contacts, isEmpty);
    });

    test('should return saved contacts', () async {
      final contact = Contact(
        id: '1',
        name: 'Test',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      await repository.saveContact(contact);

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
      expect(contacts[0].name, 'Test');
    });
  });

  group('getContact', () {
    test('should return null for non-existent id', () async {
      final contact = await repository.getContact('999');
      expect(contact, isNull);
    });

    test('should return contact by id', () async {
      final contact = Contact(
        id: '1',
        name: 'Find Me',
        source: 'nfc',
        importedAt: DateTime(2024),
      );
      await repository.saveContact(contact);

      final found = await repository.getContact('1');
      expect(found?.name, 'Find Me');
    });
  });

  group('saveContact', () {
    test('should add new contact', () async {
      final contact = Contact(
        id: '1',
        name: 'New',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      await repository.saveContact(contact);

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
    });

    test('should update existing contact', () async {
      final contact = Contact(
        id: '1',
        name: 'Original',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      await repository.saveContact(contact);

      final updated = contact.copyWith(name: 'Updated');
      await repository.saveContact(updated);

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
      expect(contacts[0].name, 'Updated');
    });
  });

  group('deleteContact', () {
    test('should remove contact', () async {
      final contact = Contact(
        id: '1',
        name: 'Delete Me',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      await repository.saveContact(contact);
      await repository.deleteContact('1');

      final contacts = await repository.getAllContacts();
      expect(contacts, isEmpty);
    });
  });

  group('importFromVCard', () {
    test('should parse valid vCard', () async {
      const vcard = 'BEGIN:VCARD\nVERSION:3.0\nFN:VCard User\nEMAIL:vc@test.com\nTEL:555\nEND:VCARD';
      await repository.importFromVCard(vcard);

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
      expect(contacts[0].name, 'VCard User');
      expect(contacts[0].email, 'vc@test.com');
      expect(contacts[0].phone, '555');
      expect(contacts[0].source, 'vcard');
    });

    test('should ignore invalid vCard', () async {
      await repository.importFromVCard('invalid data');

      final contacts = await repository.getAllContacts();
      expect(contacts, isEmpty);
    });

    test('should parse vCard with LinkedIn', () async {
      const vcard = 'BEGIN:VCARD\nFN:LinkedIn User\nX-LINKEDIN:linkedin.com/in/user\nEND:VCARD';
      await repository.importFromVCard(vcard);

      final contacts = await repository.getAllContacts();
      expect(contacts[0].linkedin, 'linkedin.com/in/user');
    });

    test('should parse vCard with URL and NOTE', () async {
      const vcard =
          'BEGIN:VCARD\nFN:URL User\nURL:https://urluser.com\nNOTE:Important note\nEND:VCARD';
      await repository.importFromVCard(vcard);

      final contacts = await repository.getAllContacts();
      expect(contacts[0].website, 'https://urluser.com');
      expect(contacts[0].bio, 'Important note');
    });
  });

  group('importFromQR', () {
    test('should import QR JSON data', () async {
      await repository.importFromQR('{"name":"QR Import","email":"qr@test.com"}');

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
      expect(contacts[0].name, 'QR Import');
      expect(contacts[0].source, 'qr');
    });

    test('should handle invalid QR data gracefully', () async {
      await repository.importFromQR('not json');

      final contacts = await repository.getAllContacts();
      expect(contacts, isEmpty);
    });
  });

  group('importFromNFC', () {
    test('should import NFC JSON data', () async {
      await repository.importFromNFC('{"name":"NFC Import","phone":"999"}');

      final contacts = await repository.getAllContacts();
      expect(contacts.length, 1);
      expect(contacts[0].name, 'NFC Import');
      expect(contacts[0].source, 'nfc');
    });

    test('should handle invalid NFC data gracefully', () async {
      await repository.importFromNFC('not json');

      final contacts = await repository.getAllContacts();
      expect(contacts, isEmpty);
    });
  });

  group('exportToVCard', () {
    test('should generate vCard string', () async {
      final contact = Contact(
        id: '1',
        name: 'Export User',
        email: 'exp@test.com',
        phone: '111',
        website: 'https://exp.com',
        bio: 'Test bio',
        linkedin: 'linkedin.com/in/exp',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      final vcard = await repository.exportToVCard(contact);

      expect(vcard, contains('BEGIN:VCARD'));
      expect(vcard, contains('FN:Export User'));
      expect(vcard, contains('EMAIL:exp@test.com'));
      expect(vcard, contains('TEL:111'));
      expect(vcard, contains('URL:https://exp.com'));
      expect(vcard, contains('NOTE:Test bio'));
      expect(vcard, contains('X-LINKEDIN:linkedin.com/in/exp'));
      expect(vcard, contains('END:VCARD'));
    });
  });

  group('exportToAgenda', () {
    test('should complete without error', () async {
      final contact = Contact(
        id: '1',
        name: 'Agenda',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      await repository.exportToAgenda(contact);
    });
  });
}
