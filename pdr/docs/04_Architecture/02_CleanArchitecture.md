# Clean Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Camadas

```
Presentation  (UI)
      ↓
Application   (Controllers/Providers)
      ↓
Domain        (Use Cases / Business Logic)
      ↓
Data          (Repositories / Models / DataSources)
      ↓
Infrastructure (Plugins / Hive / Hardware)
```

---

## Responsabilidades

### Presentation
- Widgets e Pages
- Controllers (StateNotifier)
- Formatação visual
- Input do usuário
- Navegação

### Application
- Providers (Riverpod)
- State Notifiers
- Coordenação entre camadas
- Tratamento de estado

### Domain
- Use Cases (regras de negócio)
- Entities (entidades de negócio)
- Repository interfaces
- Regras de validação
- Lógica pura, sem dependência externa

### Data
- Repository implementations
- Models (mapeamento de dados)
- DataSources (Hive)
- Serialização/Deserialização

### Infrastructure
- Plugins (NFC, QR, Camera, Biometria)
- Hive (banco de dados)
- Plataforma (Android/iOS)
- Hardware

---

## Regras Fundamentais

### Regra 1: Presentation NUNCA acessa Hive
```dart
// ❌ INCORRETO
class ProfilePage extends ConsumerWidget {
  final box = Hive.box('userProfile');
}

// ✅ CORRETO
class ProfilePage extends ConsumerWidget {
  final ref = ref.watch(profileProvider);
}
```

### Regra 2: Presentation NUNCA acessa Plugins
```dart
// ❌ INCORRETO
class SharePage extends ConsumerWidget {
  final nfc = NfcManager.instance;
}

// ✅ CORRETO
class SharePage extends ConsumerWidget {
  final ref = ref.watch(nfcProvider);
}
```

### Regra 3: Presentation NUNCA conhece Models
```dart
// ❌ INCORRETO
class ProfilePage extends ConsumerWidget {
  final UserProfileModel profile;
}

// ✅ CORRETO
class ProfilePage extends ConsumerWidget {
  final UserProfile profile; // Entity
}
```

### Regra 4: Domain NUNCA conhece Flutter
```dart
// ❌ INCORRETO
import 'package:flutter/material.dart';

class SaveProfileUseCase {
  final BuildContext context;
}

// ✅ CORRETO
class SaveProfileUseCase {
  final ProfileRepository repository;
}
```

### Regra 5: Data implementa Repositories
```dart
// ❌ INCORRETO
class ProfileRepository {
  final box = Hive.box('userProfile');
}

// ✅ CORRETO
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;
}
```

### Regra 6: Infrastructure contém Plugins
```dart
// ❌ INCORRETO
class NfcService {
  final nfc = NfcManager.instance;
}

// ✅ CORRETO
// Plugins ficam apenas em infrastructure/
```

---

## Fluxo de Dependências

```
Presentation → Application → Domain ← Data ← Infrastructure
```

As dependências apontam **somente para dentro**. Nunca para fora.

---

## Benefícios

| Benefício | Descrição |
|-----------|-----------|
| **Testabilidade** | Cada camada pode ser testada isoladamente |
| **Troca de implementação** | Hive pode ser substituído sem afetar UI |
| **Reutilização** | Use Cases podem ser reutilizados por diferentes UIs |
| **Manutenção** | Alterações em uma camada não afetam outras |
| **Clareza** | Cada arquivo tem responsabilidade única |

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [03_ProjectStructure.md](./03_ProjectStructure.md)
- [04_DependencyRules.md](./04_DependencyRules.md)
