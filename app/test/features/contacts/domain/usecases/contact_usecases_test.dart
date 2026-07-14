import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/features/contacts/domain/usecases/import_contact_usecase.dart';
import 'package:vcardsmart/features/contacts/domain/usecases/export_contact_usecase.dart';
import 'package:vcardsmart/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:vcardsmart/features/contacts/domain/repositories/contact_repository.dart';

void main() {
  late _FakeContactRepository repository;

  setUp(() {
    repository = _FakeContactRepository();
  });

  group('ImportContactUseCase', () {
    test('should import vCard data', () async {
      final useCase = ImportContactUseCase(repository);

      await useCase('BEGIN:VCARD\nFN:Test\nEND:VCARD', ImportSource.vcard);

      expect(repository.importedVCard, 'BEGIN:VCARD\nFN:Test\nEND:VCARD');
    });

    test('should import QR data', () async {
      final useCase = ImportContactUseCase(repository);

      await useCase('{"name":"QR User"}', ImportSource.qr);

      expect(repository.importedQR, '{"name":"QR User"}');
    });

    test('should import NFC data', () async {
      final useCase = ImportContactUseCase(repository);

      await useCase('{"name":"NFC User"}', ImportSource.nfc);

      expect(repository.importedNFC, '{"name":"NFC User"}');
    });
  });

  group('ExportContactUseCase', () {
    test('should export to vCard', () async {
      repository.exportResult = 'BEGIN:VCARD\nFN:Export\nEND:VCARD';
      final useCase = ExportContactUseCase(repository);
      final contact = Contact(
        id: '1',
        name: 'Export',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      final result = await useCase(contact, ExportDestination.vcard);

      expect(result, 'BEGIN:VCARD\nFN:Export\nEND:VCARD');
    });

    test('should export to agenda', () async {
      final useCase = ExportContactUseCase(repository);
      final contact = Contact(
        id: '2',
        name: 'Agenda',
        source: 'nfc',
        importedAt: DateTime(2024),
      );

      final result = await useCase(contact, ExportDestination.agenda);

      expect(result, '');
      expect(repository.exportedToAgenda, true);
    });
  });

  group('GetContactsUseCase', () {
    test('should return all contacts', () async {
      repository.contacts = [
        Contact(id: '1', name: 'A', source: 'qr', importedAt: DateTime(2024)),
        Contact(id: '2', name: 'B', source: 'nfc', importedAt: DateTime(2024)),
      ];
      final useCase = GetContactsUseCase(repository);

      final result = await useCase();

      expect(result.length, 2);
      expect(result[0].name, 'A');
      expect(result[1].name, 'B');
    });

    test('should return empty list when no contacts', () async {
      repository.contacts = [];
      final useCase = GetContactsUseCase(repository);

      final result = await useCase();

      expect(result, isEmpty);
    });
  });
}

class _FakeContactRepository implements ContactRepository {
  String? importedVCard;
  String? importedQR;
  String? importedNFC;
  String exportResult = '';
  bool exportedToAgenda = false;
  List<Contact> contacts = [];

  @override
  Future<List<Contact>> getAllContacts() async => contacts;

  @override
  Future<Contact?> getContact(String id) async {
    try {
      return contacts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveContact(Contact contact) async {
    contacts.add(contact);
  }

  @override
  Future<void> deleteContact(String id) async {
    contacts.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> importFromVCard(String vcard) async {
    importedVCard = vcard;
  }

  @override
  Future<void> importFromQR(String qrData) async {
    importedQR = qrData;
  }

  @override
  Future<void> importFromNFC(String nfcData) async {
    importedNFC = nfcData;
  }

  @override
  Future<String> exportToVCard(Contact contact) async => exportResult;

  @override
  Future<void> exportToAgenda(Contact contact) async {
    exportedToAgenda = true;
  }
}
