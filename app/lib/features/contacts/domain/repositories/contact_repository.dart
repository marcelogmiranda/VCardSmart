import '../entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAllContacts();
  Future<Contact?> getContact(String id);
  Future<void> saveContact(Contact contact);
  Future<void> deleteContact(String id);
  Future<void> importFromVCard(String vcard);
  Future<void> importFromQR(String qrData);
  Future<void> importFromNFC(String nfcData);
  Future<String> exportToVCard(Contact contact);
  Future<void> exportToAgenda(Contact contact);
}
