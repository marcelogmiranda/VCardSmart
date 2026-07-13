# Migrations

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estratégia de Migração

| Conceito | Descrição |
|----------|-----------|
| **Schema Version** | Versão do schema em cada entidade |
| **Migration Strategy** | Estratégia de migração entre versões |
| **Backward Compatible** | Compatibilidade com versões anteriores |
| **Rollback** | Capacidade de reverter migração |

---

## Schema Version

### Campo em Toda Entidade
```dart
class UserProfile {
  final String schemaVersion; // "1.0"
  // ...
}
```

### Valores
| Versão | Descrição |
|--------|-----------|
| `1.0` | Versão inicial |

---

## Estratégia de Migração

### Fluxo
```
App Inicia
    ↓
Verificar schemaVersion
    ↓
Se versão diferente → Migrar
    ↓
Salvar nova versão
```

### Implementação
```dart
class MigrationService {
  static const currentVersion = '1.0';

  Future<void> migrate() async {
    final box = Hive.box('user_profile');
    final profile = box.get('profile');

    if (profile == null) return;

    if (profile.schemaVersion != currentVersion) {
      await _migrateToCurrent(profile);
    }
  }

  Future<void> _migrateToCurrent(UserProfileModel profile) async {
    if (profile.schemaVersion == '1.0') {
      // Migração 1.0 → 1.1
      await _migrate10to11(profile);
    }
    // Adicionar novas migrações conforme necessário
  }
}
```

---

## Backward Compatibility

### Regras
| # | Regra |
|---|-------|
| 1 | Novos campos devem ter valores padrão |
| 2 | Campos removidos devem ser ignorados |
| 3 | Formatos antigos devem ser aceitos |
| 4 | Migração é automática |

### Exemplo
```dart
// Campo adicionado em v1.1
final String? newField; // Opcional

// Ao ler v1.0
final field = profile.newField ?? 'defaultValue';
```

---

## Rollback

### Estratégia
```dart
class MigrationService {
  Future<void> rollback(String fromVersion, String toVersion) async {
    // Implementar reversão quando necessário
  }
}
```

### Status
| Status | Descrição |
|--------|-----------|
| ❌ Não implementado | Rollback não será implementado em V1 |

---

## Versionamento Automático

### Detecção
```dart
void main() async {
  await Hive.initFlutter();
  await MigrationService.migrate();
  runApp(const VCardSmartApp());
}
```

### Verificação
```dart
if (profile.schemaVersion != MigrationService.currentVersion) {
  await MigrationService.migrate();
}
```

---

## Documentos Relacionados

- [12_Migrations.md](./12_Migrations.md)
- [19_Versioning.md](./19_Versioning.md)
- [02_HiveArchitecture.md](./02_HiveArchitecture.md)
