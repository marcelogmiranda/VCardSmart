import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/import_contact_usecase.dart';
import '../../domain/usecases/export_contact_usecase.dart';
import '../../domain/usecases/get_contacts_usecase.dart';
import '../../data/repositories/local_contact_repository.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../../profile/domain/entities/profile.dart';
import '../../../../core/database/hive_service.dart';

enum ContactStatus { idle, loading, success, error }

class ContactListStatus {
  final ContactStatus status;
  final List<Contact> contacts;
  final String? error;

  const ContactListStatus({
    this.status = ContactStatus.idle,
    this.contacts = const [],
    this.error,
  });

  ContactListStatus copyWith({
    ContactStatus? status,
    List<Contact>? contacts,
    String? error,
  }) {
    return ContactListStatus(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      error: error,
    );
  }
}

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return LocalContactRepository(HiveService.contactBox);
});

final getContactsUseCaseProvider = Provider((ref) {
  return GetContactsUseCase(ref.read(contactRepositoryProvider));
});

final importContactUseCaseProvider = Provider((ref) {
  return ImportContactUseCase(ref.read(contactRepositoryProvider));
});

final exportContactUseCaseProvider = Provider((ref) {
  return ExportContactUseCase(ref.read(contactRepositoryProvider));
});

class ContactListNotifier extends StateNotifier<ContactListStatus> {
  final GetContactsUseCase _getContacts;
  final ImportContactUseCase _importContact;
  final ContactRepository _repository;

  ContactListNotifier(
    this._getContacts,
    this._importContact,
    this._repository,
  ) : super(const ContactListStatus());

  Future<void> loadContacts() async {
    state = state.copyWith(status: ContactStatus.loading);
    try {
      final contacts = await _getContacts();
      state = state.copyWith(
        status: ContactStatus.success,
        contacts: contacts,
      );
    } catch (e) {
      state = state.copyWith(
        status: ContactStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> importData(String data, ImportSource source) async {
    state = state.copyWith(status: ContactStatus.loading);
    try {
      await _importContact(data, source);
      await loadContacts();
    } catch (e) {
      state = state.copyWith(
        status: ContactStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<bool> saveProfileAsContact(Profile profile, String source) async {
    final contact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: profile.name,
      email: profile.email,
      phone: profile.phone,
      linkedin: profile.linkedin,
      instagram: profile.instagram,
      website: profile.website,
      bio: profile.bio,
      source: source,
      importedAt: DateTime.now(),
    );

    try {
      await _repository.saveContact(contact);
      await loadContacts();
      return true;
    } catch (e) {
      state = state.copyWith(
        status: ContactStatus.error,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> deleteContact(String id) async {
    state = state.copyWith(status: ContactStatus.loading);
    try {
      await _repository.deleteContact(id);
      await loadContacts();
    } catch (e) {
      state = state.copyWith(
        status: ContactStatus.error,
        error: e.toString(),
      );
    }
  }
}

final contactListProvider =
    StateNotifierProvider<ContactListNotifier, ContactListStatus>((ref) {
  return ContactListNotifier(
    ref.read(getContactsUseCaseProvider),
    ref.read(importContactUseCaseProvider),
    ref.read(contactRepositoryProvider),
  )..loadContacts();
});
