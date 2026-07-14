import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase(this.repository);

  Future<List<Contact>> call() async {
    return await repository.getAllContacts();
  }
}
