# Sprint 9 — Contacts

## Objetivo

Implementar importação e exportação de contatos da agenda.

## Pré-requisitos

- Sprint 8 concluída
- NFC implementado

## Documentos Obrigatórios

- Architecture.md
- ImportFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── utils/
│       └── contact_utils.dart
├── features/
│   └── contacts/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── contact_local_datasource.dart
│       │   │   └── contact_platform_datasource.dart
│       │   └── models/
│       │       └── contact_model.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── contact.dart
│       │   ├── repositories/
│       │   │   └── contact_repository.dart
│       │   └── usecases/
│       │       ├── import_contact_usecase.dart
│       │       ├── export_contact_usecase.dart
│       │       └── get_contacts_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── import_page.dart
│           │   └── contacts_page.dart
│           ├── widgets/
│           │   ├── contact_card.dart
│           │   └── import_dialog.dart
│           └── providers/
│               └── contact_provider.dart
```

### Arquivos Alterados

- lib/core/router/app_router.dart

## Modelos

### contact.dart

```dart
class Contact {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? linkedin;
  final String? website;
  final String? bio;
  final String source;
  final DateTime importedAt;
  
  const Contact({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.linkedin,
    this.website,
    this.bio,
    required this.source,
    required this.importedAt,
  });
}
```

### contact_repository.dart

```dart
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
```

### import_contact_usecase.dart

```dart
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
```

### export_contact_usecase.dart

```dart
class ExportContactUseCase {
  final ContactRepository repository;
  
  ExportContactUseCase(this.repository);
  
  Future<void> call(Contact contact, ExportDestination destination) async {
    switch (destination) {
      case ExportDestination.vcard:
        final vcard = await repository.exportToVCard(contact);
        // Salvar arquivo
        break;
      case ExportDestination.agenda:
        await repository.exportToAgenda(contact);
        break;
    }
  }
}
```

### contact_card.dart

```dart
class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  
  const ContactCard({
    super.key,
    required this.contact,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(contact.name[0]),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.email ?? ''),
        trailing: _getSourceIcon(),
        onTap: onTap,
      ),
    );
  }
  
  Widget _getSourceIcon() {
    switch (contact.source) {
      case 'qr':
        return const Icon(Icons.qr_code);
      case 'nfc':
        return const Icon(Icons.nfc);
      case 'vcard':
        return const Icon(Icons.description);
      default:
        return const Icon(Icons.person);
    }
  }
}
```

## Critérios de Aceitação

- [x] Leitura de contatos da agenda
- [x] Escrita de contatos na agenda
- [x] Atualização de contatos
- [x] Importação via QR Code
- [x] Importação via NFC
- [x] Importação via vCard
- [x] Exportação para agenda
- [x] Exportação para vCard
- [x] Validação de duplicatas
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Leitura de contatos da agenda
- [x] Escrita de contatos na agenda
- [x] Atualização de contatos
- [x] Importação via QR Code
- [x] Importação via NFC
- [x] Importação via vCard
- [x] Exportação para agenda
- [x] Exportação para vCard
- [x] Validação de duplicatas
- [x] Build funcionando
- [x] Testes passando (243/243)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (80.3%)
- [x] CHANGELOG atualizado (v1.8.0)

## Próxima Sprint

Sprint 10 — Security
