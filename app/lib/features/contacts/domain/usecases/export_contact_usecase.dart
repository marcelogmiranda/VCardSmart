import '../entities/contact.dart';
import '../repositories/contact_repository.dart';
import 'import_contact_usecase.dart';

class ExportContactUseCase {
  final ContactRepository repository;

  ExportContactUseCase(this.repository);

  Future<String> call(Contact contact, ExportDestination destination) async {
    switch (destination) {
      case ExportDestination.vcard:
        return await repository.exportToVCard(contact);
      case ExportDestination.agenda:
        await repository.exportToAgenda(contact);
        return '';
    }
  }
}
