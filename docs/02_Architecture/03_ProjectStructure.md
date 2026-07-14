# Project Structure

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estrutura de Diretórios

```
lib/
├── main.dart
├── core/
│   ├── config/
│   │   ├── app_config.dart
│   │   └── env_config.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   └── l10n/
│   ├── routes/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── constants/
│   │   └── app_constants.dart
│   └── errors/
│       ├── exceptions.dart
│       ├── failures.dart
│       └── error_handler.dart
├── features/
│   ├── profile/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── controllers/
│   │       ├── pages/
│   │       └── widgets/
│   ├── sharing/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── nfc/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── qrcode/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── vcard/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── contacts/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── security/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── settings/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── ads/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── dialogs/
│   │   ├── inputs/
│   │   └── layout/
│   ├── models/
│   │   └── shared_models.dart
│   └── utils/
│       ├── validators.dart
│       ├── formatters.dart
│       └── helpers.dart
├── services/
│   ├── database/
│   │   ├── hive_service.dart
│   │   └── hive_boxes.dart
│   ├── plugins/
│   │   ├── nfc_service.dart
│   │   ├── qr_service.dart
│   │   ├── camera_service.dart
│   │   ├── biometric_service.dart
│   │   └── contacts_service.dart
│   └── analytics/
│       └── (vazio - sem analytics)
└── app/
    ├── app.dart
    └── app_provider.dart
```

---

## Organização por Feature

Cada feature segue a mesma estrutura interna:

```
feature/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── providers/
├── application/
│   └── usecases/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── value_objects/
└── data/
    ├── models/
    ├── datasources/
    └── repositories/
```

---

## Regras de Nomenclatura

| Elemento | Padrão | Exemplo |
|----------|--------|---------|
| Arquivo | snake_case | `profile_page.dart` |
| Classe | PascalCase | `ProfilePage` |
| Variável | camelCase | `userProfile` |
| Constante | camelCase | `maxProfileLength` |
| Provider | camelCase + Provider | `profileProvider` |
| Use Case | PascalCase + UseCase | `SaveProfileUseCase` |
| Entity | PascalCase | `UserProfile` |
| Model | PascalCase + Model | `UserProfileModel` |
| Repository | PascalCase + Repository | `ProfileRepository` |
| DataSource | PascalCase + DataSource | `ProfileDataSource` |

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
- [04_DependencyRules.md](./04_DependencyRules.md)
