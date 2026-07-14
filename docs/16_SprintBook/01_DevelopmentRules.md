# Regras de Desenvolvimento — VCardSmart

## Arquitetura

### Clean Architecture

```
Domain
├── entities/
├── repositories/
└── usecases/

Data
├── datasources/
├── models/
└── repositories/

Presentation
├── pages/
├── widgets/
└── providers/
```

### Regras

1. Domain não depende de Data
2. Data não depende de Presentation
3. Presentation depende de Domain
4. Repositories são abstratos em Domain
5. Implementações ficam em Data

## Naming

### Entities

```dart
class Profile {
  final String id;
  final String name;
}
```

### Models

```dart
class ProfileModel {
  factory ProfileModel.fromJson(Map<String, dynamic> json) {}
  Map<String, dynamic> toJson() {}
  Profile toDomain() {}
  factory ProfileModel.fromDomain(Profile profile) {}
}
```

### Repositories

```dart
// Interface (Domain)
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<void> saveProfile(Profile profile);
}

// Implementation (Data)
class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;
}
```

### UseCases

```dart
class GetProfileUseCase {
  final ProfileRepository repository;
  
  Future<Profile> call(String id) {
    return repository.getProfile(id);
  }
}
```

### Providers

```dart
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>(
  (ref) => ProfileNotifier(ref),
);
```

### Widgets

```dart
class ProfileCard extends StatelessWidget {
  final Profile profile;
}
```

### Pages

```dart
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
}
```

## Padrões

### Riverpod

```dart
// Provider
final profileProvider = StateNotifierProvider<...>(...);

// Notifier
class ProfileNotifier extends StateNotifier<AsyncValue<Profile?>> {
  Future<void> loadProfile(String id) async {}
  Future<void> createProfile(Profile profile) async {}
  Future<void> updateProfile(Profile profile) async {}
  Future<void> deleteProfile(String id) async {}
}

// Consumer
class ProfilePage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
  }
}
```

### GoRouter

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/profile/:id',
      builder: (context, state) => ProfilePage(
        id: state.pathParameters['id']!,
      ),
    ),
  ],
);
```

### Hive

```dart
// Box
final profileBox = Hive.box<ProfileModel>('profiles');

// Datasource
abstract class ProfileDataSource {
  Future<ProfileModel> getProfile(String id);
  Future<void> saveProfile(ProfileModel profile);
}

// Implementation
class HiveProfileDataSource implements ProfileDataSource {
  final Box<ProfileModel> box;
}
```

## Erros

```dart
// Exception
class ProfileNotFoundException extends AppException {
  ProfileNotFoundException(String id)
      : super('Profile not found: $id');
}

// Handler
class ErrorHandler {
  static AppException handle(Object error) {
    if (error is ProfileNotFoundException) {
      return error;
    }
    return UnknownException(error);
  }
}
```

## Testes

### Unit Tests

```dart
void main() {
  group('GetProfileUseCase', () {
    test('should return profile when found', () async {
      final repository = MockProfileRepository();
      final useCase = GetProfileUseCase(repository);
      
      when(repository.getProfile('1')).thenAnswer(
        (_) async => const Profile(id: '1', name: 'Test'),
      );
      
      final result = await useCase.call('1');
      
      expect(result.id, '1');
    });
  });
}
```

### Widget Tests

```dart
void main() {
  group('ProfileCard', () {
    testWidgets('should display profile name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProfileCard(
            profile: const Profile(id: '1', name: 'Test'),
          ),
        ),
      );
      
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
```

## Lints

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_locals
    - avoid_print
    - prefer_single_quotes
    - require_trailing_commas
    - always_declare_return_types
    - annotate_overrides
    - use_key_in_widget_constructors
```

## Commit

### Formato

```
[tipo](escopo): [descrição]

[corpo]

[footer]
```

### Tipos

- feat: nova feature
- fix: correção
- docs: documentação
- style: formatação
- refactor: refatoração
- test: testes
- chore: manutenção

### Exemplo

```
feat(profile): implement profile creation

- Add Profile entity
- Add ProfileModel
- Add ProfileRepository
- Add CreateProfileUseCase
- Add ProfileProvider
- Add ProfilePage
- Add unit tests
- Add widget tests

Closes #123
```
