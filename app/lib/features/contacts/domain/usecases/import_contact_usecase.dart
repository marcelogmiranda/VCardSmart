import '../repositories/contact_repository.dart';

enum ImportSource { vcard, qr, nfc }

enum ExportDestination { vcard, agenda }

class ImportContactUseCase {
  final ContactRepository repository;

  ImportContactUseCase(this.repository);

  Future<void> call(String data, ImportSource source) async {
    switch (source) {
      case ImportSource.vcard:
        await repository.importFromVCard(data);
        break;
      case ImportSource.qr:
        await repository.importFromQR(data);
        break;
      case ImportSource.nfc:
        await repository.importFromNFC(data);
        break;
    }
  }
}
