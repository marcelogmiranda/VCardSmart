# Directory Structure

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estrutura Final

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── app_provider.dart
├── core/
│   ├── config/
│   │   ├── app_config.dart
│   │   └── env_config.dart
│   ├── constants/
│   │   └── app_constants.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   │   └── error_handler.dart
│   ├── extensions/
│   │   └── string_extensions.dart
│   ├── services/
│   │   ├── logger_service.dart
│   │   └── migration_service.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   └── formatters.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   └── l10n/
│       ├── app_localizations.dart
│       └── l10n/
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── dialogs/
│   │   ├── inputs/
│   │   └── layout/
│   └── utils/
├── features/
│   ├── profile/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── providers/
│   │   ├── application/
│   │   │   └── usecases/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── value_objects/
│   │   └── data/
│   │       ├── models/
│   │       ├── datasources/
│   │       └── repositories/
│   ├── sharing/
│   ├── contacts/
│   ├── settings/
│   ├── security/
│   ├── ads/
│   ├── history/
│   └── about/
└── features/
```

---

## Estrutura de Cada Feature

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

## Regras

| # | Regra |
|---|-------|
| 1 | Uma feature por diretório |
| 2 | Camadas separadas dentro da feature |
| 3 | Domínio não depende de Flutter |
| 4 | Data implementa interfaces do Domain |
| 5 | Infrastructure contém plugins |

---

## Documentos Relacionados

- [03_ProjectStructure.md](../04_Architecture/03_ProjectStructure.md)
- [06_ArchitectureLayers.md](./06_ArchitectureLayers.md)
- [ADR-018](./ADR-018.md)
