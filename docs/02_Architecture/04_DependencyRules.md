# Dependency Rules

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fluxo de Dependências

```
Presentation → Application → Domain ← Data ← Infrastructure
```

---

## Permitido

| De | Para | Exemplo |
|----|------|---------|
| Presentation | Application | Page acessa Provider |
| Application | Domain | Provider chama UseCase |
| Data | Domain | Repository implementa interface |
| Infrastructure | Data | DataSource usa Hive |
| Shared | Domain | Widget usa Entity |

---

## Proibido

| De | Para | Justificativa |
|----|------|---------------|
| Presentation | Hive | UI não acessa banco diretamente |
| Presentation | Plugins | UI não acessa hardware diretamente |
| Presentation | SQLite | UI não acessa banco diretamente |
| Presentation | NFC | UI não acessa hardware diretamente |
| Presentation | Contacts | UI não acessa agenda diretamente |
| Domain | Flutter | Domain não depende de UI |
| Domain | Material | Domain não depende de UI |
| Domain | Hive | Domain não depende de banco |
| Infrastructure | Presentation | Infrastructure não conhece UI |
| Data | Presentation | Data não conhece UI |

---

## Tabela de Dependências

| Camada | Pode Importar | Não Pode Importar |
|--------|--------------|-------------------|
| **Presentation** | Application, Domain, Shared | Data, Infrastructure, Hive, Plugins |
| **Application** | Domain, Shared | Presentation, Data, Infrastructure |
| **Domain** | Shared (entities) | Flutter, Material, Hive, Data, Infrastructure |
| **Data** | Domain, Infrastructure | Presentation |
| **Infrastructure** | Data | Presentation, Domain |

---

## Exemplos Corretos

### Presentation → Application
```dart
// ✅ Presentation acessa Application (Provider)
class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    // ...
  }
}
```

### Application → Domain
```dart
// ✅ Application acessa Domain (UseCase)
class ProfileNotifier extends StateNotifier<ProfileState> {
  final SaveProfileUseCase saveProfile;
  // ...
}
```

### Domain → Nada
```dart
// ✅ Domain não importa nada de Flutter, Hive ou Plugins
class SaveProfileUseCase {
  final ProfileRepository repository; // Interface apenas
  // ...
}
```

### Data → Domain
```dart
// ✅ Data implementa interface do Domain
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;
  // ...
}
```

### Infrastructure → Data
```dart
// ✅ Infrastructure contém plugins e banco
class ProfileDataSource {
  final box = Hive.box('userProfile');
  // ...
}
```

---

## Exemplos Incorretos

### ❌ Presentation acessa Hive
```dart
// INCORRETO
class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = Hive.box('userProfile'); // ERRADO
    return Container();
  }
}
```

### ❌ Presentation acessa Plugin
```dart
// INCORRETO
class SharePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NfcManager.instance.startSession(); // ERRADO
    return Container();
  }
}
```

### ❌ Domain importa Flutter
```dart
// INCORRETO
import 'package:flutter/material.dart'; // ERRADO

class SaveProfileUseCase {
  final BuildContext context; // ERRADO
}
```

---

## Verificação de Dependências

### Comando para verificar importações proibidas
```bash
# Verificar se Presentation importa Hive
grep -r "import.*hive" lib/features/*/presentation/

# Verificar se Domain importa Flutter
grep -r "import.*flutter" lib/features/*/domain/
```

### Regra de Ouro
> Se um arquivo importa algo que não deveria, o código está incorreto.
> Refatore imediatamente.

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
- [03_ProjectStructure.md](./03_ProjectStructure.md)
