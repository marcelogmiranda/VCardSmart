# Naming Convention

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Convenções

| Elemento | Formato | Exemplo |
|----------|---------|---------|
| **Classes** | PascalCase | `UserProfile` |
| **Variáveis** | camelCase | `userProfile` |
| **Arquivos** | snake_case | `user_profile.dart` |
| **Constantes** | camelCase | `maxProfileLength` |
| **Enums** | PascalCase | `SocialNetworkType` |
| **Providers** | camelCase + Provider | `profileProvider` |
| **Repositories** | PascalCase + Repository | `ProfileRepository` |
| **UseCases** | VerbNounUseCase | `SaveProfileUseCase` |
| **Services** | PascalCase + Service | `NfcService` |
| **Entities** | PascalCase | `UserProfile` |
| **Models** | PascalCase + Model | `UserProfileModel` |
| **DTOs** | PascalCase + DTO | `ProfileDTO` |

---

## Exemplos

### Classes
```dart
class UserProfile { }
class SaveProfileUseCase { }
class ProfileRepository { }
```

### Providers
```dart
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  // ...
});
```

### UseCases
```dart
class SaveProfileUseCase {
  Future<void> call(UserProfile profile) async { }
}
```

### Arquivos
```
user_profile.dart
save_profile_use_case.dart
profile_repository_impl.dart
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Nunca usar abreviações (`usr`, `prof`) |
| 2 | Sempre significativo (`userProfile`, não `up`) |
| 3 | Arquivos em snake_case |
| 4 | Classes em PascalCase |
| 5 | Variáveis e funções em camelCase |

---

## Documentos Relacionados

- [01_DevelopmentGuide.md](./01_DevelopmentGuide.md)
- [04_CodingStandards.md](./04_CodingStandards.md)
