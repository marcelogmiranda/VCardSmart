# Versioning

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Schema Versioning

| Conceito | Descrição |
|----------|-----------|
| **Schema Version** | Versão do schema em cada entidade |
| **Migração Obrigatória** | Em alteração estrutural |
| **Compatibilidade** | Mantida sempre que possível |

---

## Versão Atual

| Schema | Versão | Status |
|--------|--------|--------|
| UserProfile | 1.0 | Ativo |
| Settings | 1.0 | Ativo |
| ReceivedCard | 1.0 | Ativo |

---

## Regras de Versão

| # | Regra |
|---|-------|
| 1 | Toda entidade possui schemaVersion |
| 2 | Alteração estrutural = nova versão |
| 3 | Migração automática ao iniciar |
| 4 | Compatibilidade com versões anteriores |
| 5 | Novos campos devem ter valores padrão |

---

## Fluxo de Versão

```
App Inicia
    ↓
Ler schemaVersion de cada entidade
    ↓
Se versão diferente → Migrar
    ↓
Salvar nova versão
    ↓
App funciona normalmente
```

---

## Exemplo de Migração

### v1.0 → v1.1 (Campo Adicionado)

```dart
// v1.0
class UserProfile {
  final String fullName;
  final String email;
}

// v1.1
class UserProfile {
  final String fullName;
  final String email;
  final String? newField; // Adicionado
}
```

### Migração
```dart
if (profile.schemaVersion == '1.0') {
  profile.newField = 'defaultValue';
  profile.schemaVersion = '1.1';
  await box.put('profile', profile);
}
```

---

## Compatibilidade entre Versões

| Versão | Compatível com |
|--------|---------------|
| 1.0 | 1.0 |
| 1.1 | 1.0 |
| 1.2 | 1.0, 1.1 |
| 2.0 | 1.x (com migração) |

---

## Compartilhamento entre Versões

### QR Code / NFC
```json
{
  "version": "1.0",
  "profile": { ... }
}
```

### Validação
```dart
if (json['version'] != currentVersion) {
  // Aceitar com aviso
  // ou rejeitar
}
```

---

## Documentos Relacionados

- [12_Migrations.md](./12_Migrations.md)
- [06_JSONSchema.md](./06_JSONSchema.md)
- [01_DataModelOverview.md](./01_DataModelOverview.md)
