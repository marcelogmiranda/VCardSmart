# Índice de Arquitetura — VCardSmart

## Visão Geral

Documentação completa da arquitetura do projeto.

## Camadas

### Domain

```
domain/
├── entities/
│   ├── profile.dart
│   ├── contact.dart
│   ├── social_link.dart
│   └── ...
├── repositories/
│   ├── profile_repository.dart
│   ├── contact_repository.dart
│   └── ...
└── usecases/
    ├── get_profile_usecase.dart
    ├── create_profile_usecase.dart
    └── ...
```

### Data

```
data/
├── datasources/
│   ├── local/
│   │   ├── hive_datasource.dart
│   │   └── ...
│   └── remote/
│       └── ...
├── models/
│   ├── profile_model.dart
│   ├── contact_model.dart
│   └── ...
└── repositories/
    ├── local_profile_repository.dart
    ├── local_contact_repository.dart
    └── ...
```

### Presentation

```
presentation/
├── pages/
│   ├── home_page.dart
│   ├── profile_page.dart
│   └── ...
├── widgets/
│   ├── profile_card.dart
│   ├── qr_code_widget.dart
│   └── ...
└── providers/
    ├── profile_provider.dart
    ├── theme_provider.dart
    └── ...
```

## Componentes

### Core

```
core/
├── constants/
│   ├── app_constants.dart
│   ├── hive_boxes.dart
│   └── ...
├── theme/
│   ├── app_theme.dart
│   ├── app_colors.dart
│   └── ...
├── router/
│   ├── app_router.dart
│   └── ...
├── utils/
│   ├── encryption_utils.dart
│   ├── vcard_utils.dart
│   └── ...
└── errors/
    ├── app_exception.dart
    └── ...
```

## Diagramas

### Clean Architecture

```
┌─────────────────────────────────────┐
│         Presentation                │
│  Pages, Widgets, Providers          │
├─────────────────────────────────────┤
│           Domain                    │
│  Entities, UseCases, Repositories   │
├─────────────────────────────────────┤
│            Data                     │
│  Datasources, Models, Repositories  │
└─────────────────────────────────────┘
```

### Feature Structure

```
features/
└── profile/
    ├── data/
    │   ├── datasources/
    │   │   └── profile_local_datasource.dart
    │   ├── models/
    │   │   └── profile_model.dart
    │   └── repositories/
    │       └── local_profile_repository.dart
    ├── domain/
    │   ├── entities/
    │   │   └── profile.dart
    │   ├── repositories/
    │   │   └── profile_repository.dart
    │   └── usecases/
    │       ├── get_profile_usecase.dart
    │       └── create_profile_usecase.dart
    └── presentation/
        ├── pages/
        │   ├── profile_page.dart
        │   └── profile_edit_page.dart
        ├── widgets/
        │   ├── profile_card.dart
        │   └── profile_form.dart
        └── providers/
            └── profile_provider.dart
```

### Navigation

```
GoRouter
├── / (ShellRoute)
│   ├── /home
│   ├── /profile
│   │   └── /profile/:id
│   ├── /settings
│   └── /history
├── /profile/create
├── /profile/edit/:id
├── /import
├── /share
└── /splash
```

### Data Flow

```
User Action
    ↓
Provider (StateNotifier)
    ↓
UseCase
    ↓
Repository (Interface)
    ↓
Repository (Implementation)
    ↓
DataSource (Hive)
    ↓
UI Update
```

## Padrões

### Repository Pattern

```dart
// Interface (Domain)
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<void> saveProfile(Profile profile);
}

// Implementation (Data)
class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;
  
  @override
  Future<Profile> getProfile(String id) async {
    final model = await dataSource.getProfile(id);
    return model.toDomain();
  }
}
```

### UseCase Pattern

```dart
class GetProfileUseCase {
  final ProfileRepository repository;
  
  GetProfileUseCase(this.repository);
  
  Future<Profile> call(String id) {
    return repository.getProfile(id);
  }
}
```

### Provider Pattern

```dart
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>(
  (ref) => ProfileNotifier(ref),
);
```

## Dependências

### Externas

| Pacote | Versão | Uso |
|--------|--------|-----|
| flutter_riverpod | ^2.x | State Management |
| go_router | ^12.x | Navigation |
| hive | ^2.x | Local Storage |
| flutter_secure_storage | ^9.x | Secure Storage |
| local_auth | ^2.x | Biometric Auth |
| mobile_scanner | ^3.x | QR Code |
| nfc_manager | ^3.x | NFC |
| share_plus | ^7.x | Sharing |
| url_launcher | ^6.x | URL Launch |
| path_provider | ^2.x | Path Provider |

### Internas

| Módulo | Uso |
|--------|-----|
| core/ | Constantes, tema, rotas |
| features/ | Funcionalidades |
| l10n/ | Localização |
