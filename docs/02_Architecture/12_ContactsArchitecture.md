# Contacts Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Plugin

| Propriedade | Valor |
|-------------|-------|
| **Plugin** | flutter_contacts |
| **Plataformas** | Android, iOS |
| **Permissão** | Obrigatória |

---

## Funcionalidades

| Funcionalidade | Descrição |
|---------------|-----------|
| **Leitura** | Ler contatos da agenda |
| **Escrita** | Adicionar/atualizar contatos |
| **Busca** | Buscar contatos existentes |

---

## Regras

| # | Regra | Descrição |
|---|-------|-----------|
| 1 | Permissão | Sempre solicitar antes de acessar |
| 2 | Confirmação | Sempre confirmar antes de atualizar |
| 3 | Importação | Sempre confirmar antes de importar |
| 4 | Nunca sobrescrever | Não sobrescrever sem autorização |
| 5 | Validação | Validar dados antes de escrever |

---

## Fluxo de Atualização

```
Detectar contato existente (por e-mail ou telefone)
    ↓
Exibir dados atuais vs novos dados
    ↓
Solicitar confirmação do usuário
    ↓
Atualizar contato na agenda
```

---

## Fluxo de Importação

```
Receber vCard
    ↓
Validar formato
    ↓
Extrair dados
    ↓
Confirmar com usuário
    ↓
Criar novo contato na agenda
```

---

## Implementação

### Service
```dart
class ContactsService {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission();
  }

  Future<List<Contact>> getContacts() async {
    return await FlutterContacts.getContacts();
  }

  Future<void> addContact(Contact contact) async {
    await FlutterContacts.insertContact(contact);
  }

  Future<void> updateContact(Contact contact) async {
    await FlutterContacts.updateContact(contact);
  }

  Future<Contact?> findContactByEmail(String email) async {
    final contacts = await getContacts();
    return contacts.where((c) => c.emails.any((e) => e.address == email)).firstOrNull;
  }
}
```

---

## Tratamento de Erros

| Erro | Ação |
|------|------|
| Permissão negada | Informar limitação |
| Contato não encontrado | Criar novo |
| Contato duplicado | Perguntar se deseja atualizar |
| Erro ao salvar | Informar e sugerir retry |

---

## Permissões

| Plataforma | Permissão | Obrigatória |
|------------|-----------|-------------|
| Android | READ_CONTACTS | Sim |
| Android | WRITE_CONTACTS | Sim |
| iOS | Contacts | Sim |

---

## Documentos Relacionados

- [12_ContactsArchitecture.md](./12_ContactsArchitecture.md)
- [11_VCardArchitecture.md](./11_VCardArchitecture.md)
- [12_Permissions.md](../03_Product/12_Permissions.md)
