# Permissões de Contatos — VCardSmart

## Regras

1. **Nunca importar automaticamente** — Sempre com ação do usuário
2. **Sempre perguntar** — Consentimento explícito
3. **Sempre permitir cancelar** — Botão de cancelar sempre visível
4. **Nunca sobrescrever** — Sempre comparar primeiro
5. **Solicitar confirmação final** — Antes de salvar

## Fluxo Seguro

```
1. Usuário seleciona "Importar Contato"
    ↓
2. Verificar permissão
    ↓
3. Permissão concedida?
    ↓ Sim
4. Listar contatos da agenda
    ↓
5. Usuário seleciona contato
    ↓
6. Comparar com perfil existente
    ↓
7. Mostrar diferenças
    ↓
8. Perguntar se deseja atualizar
    ↓
9. Usuário confirma
    ↓
10. Salvar contato
    ↓
11. Confirmar sucesso
```

## Implementação

### Service

```dart
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  // Listar contatos
  static Future<List<Contact>> getContacts() async {
    if (!await PermissionService.isContactsGranted()) {
      return [];
    }
    
    return await FlutterContacts.getContacts(
      withProperties: true,
      withThumbnail: false,
    );
  }
  
  // Buscar contato por ID
  static Future<Contact?> getContactById(String id) async {
    if (!await PermissionService.isContactsGranted()) {
      return null;
    }
    
    return await FlutterContacts.getContact(id);
  }
  
  // Salvar contato
  static Future<bool> saveContact(Contact contact) async {
    if (!await PermissionService.isContactsGranted()) {
      return false;
    }
    
    try {
      await FlutterContacts.insertContact(contact);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Atualizar contato
  static Future<bool> updateContact(Contact contact) async {
    if (!await PermissionService.isContactsGranted()) {
      return false;
    }
    
    try {
      await FlutterContacts.updateContact(contact);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Deletar contato
  static Future<bool> deleteContact(String id) async {
    if (!await PermissionService.isContactsGranted()) {
      return false;
    }
    
    try {
      await FlutterContacts.deleteContact(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

### Provider

```dart
final contactsProvider = FutureProvider<List<Contact>>((ref) async {
  return ContactService.getContacts();
});
```

### UI - Seleção de Contato

```dart
class ContactPickerScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Contato'),
      ),
      body: contacts.when(
        data: (contacts) => ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              title: Text(contact.displayName),
              subtitle: Text(contact.phones.first.number ?? ''),
              onTap: () => _selectContact(context, contact),
            );
          },
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, _) => Text('Erro ao carregar contatos'),
      ),
    );
  }
  
  void _selectContact(BuildContext context, Contact contact) {
    Navigator.pop(context, contact);
  }
}
```

### UI - Confirmação de Importação

```dart
class ImportContactDialog extends ConsumerWidget {
  final Contact contact;
  final Profile? existingProfile;
  
  const ImportContactDialog({
    required this.contact,
    this.existingProfile,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('Importar Contato'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nome: ${contact.displayName}'),
          if (contact.phones.isNotEmpty)
            Text('Telefone: ${contact.phones.first.number}'),
          if (contact.emails.isNotEmpty)
            Text('Email: ${contact.emails.first.address}'),
          
          if (existingProfile != null) ...[
            SizedBox(height: 16),
            Text(
              'Este contato já existe. Deseja atualizar?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDifferences(),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Importar'),
        ),
      ],
    );
  }
  
  Widget _buildDifferences() {
    // Comparar e mostrar diferenças
    return Container();
  }
}
```

## Validação

### Antes de Salvar

```dart
Future<bool> validateBeforeSave(Contact contact) async {
  // Verificar campos obrigatórios
  if (contact.displayName.isEmpty) {
    return false;
  }
  
  // Verificar tamanho
  if (contact.displayName.length > 100) {
    return false;
  }
  
  // Validar email
  if (contact.emails.isNotEmpty) {
    for (var email in contact.emails) {
      if (!isValidEmail(email.address)) {
        return false;
      }
    }
  }
  
  // Validar telefone
  if (contact.phones.isNotEmpty) {
    for (var phone in contact.phones) {
      if (!isValidPhone(phone.number)) {
        return false;
      }
    }
  }
  
  return true;
}
```

### Comparação

```dart
class ContactComparison {
  static Map<String, dynamic> compare(
    Contact existing,
    Contact newContact,
  ) {
    final differences = {};
    
    if (existing.displayName != newContact.displayName) {
      differences['name'] = {
        'old': existing.displayName,
        'new': newContact.displayName,
      };
    }
    
    if (existing.phones != newContact.phones) {
      differences['phones'] = {
        'old': existing.phones,
        'new': newContact.phones,
      };
    }
    
    if (existing.emails != newContact.emails) {
      differences['emails'] = {
        'old': existing.emails,
        'new': newContact.emails,
      };
    }
    
    return differences;
  }
}
```

## Regras de Segurança

### 1. Nunca Importar Automaticamente

```dart
// ❌ ERRADO
void onNfcDetected(NfcData data) {
  final contact = parseContact(data);
  ContactService.saveContact(contact); // ❌ ERRADO
}

// ✅ CORRETO
void onNfcDetected(NfcData data) {
  final contact = parseContact(data);
  showImportDialog(contact); // ✅ CORRETO
}
```

### 2. Sempre Confirmar

```dart
// ❌ ERRADO
await ContactService.saveContact(contact);

// ✅ CORRETO
final confirmed = await showDialog(
  context: context,
  builder: (context) => ImportContactDialog(contact: contact),
);

if (confirmed) {
  await ContactService.saveContact(contact);
}
```

### 3. Validar Antes de Salvar

```dart
// ❌ ERRADO
await ContactService.saveContact(unvalidatedContact);

// ✅ CORRETO
if (await validateBeforeSave(contact)) {
  await ContactService.saveContact(contact);
} else {
  showError('Dados inválidos');
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Confirmação | 100% das importações |
| Validação | 100% dos dados |
| Comparação | 100% das atualizações |
| Cancelamento | Sempre disponível |
