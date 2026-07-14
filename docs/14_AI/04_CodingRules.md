# Regras de Código — VCardSmart

## Regras Gerais

### 1. Sempre Seguir Padrões Existentes

```dart
// ✅ CORRETO
class ProfileRepository {
  final HiveDataSource dataSource;
  
  ProfileRepository(this.dataSource);
}

// ❌ ERRADO
class profileRepo {
  var db;
}
```

### 2. Nunca Quebrar Arquitetura

```dart
// ✅ CORRETO - Domain não depende de Data
// domain/repositories/profile_repository.dart
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
}

// ❌ ERRADO - Domain depende de Data
// domain/repositories/profile_repository.dart
import 'package:vcardsmart/data/datasources/hive_datasource.dart';

class ProfileRepository {
  final HiveDataSource dataSource;
}
```

### 3. Sempre Usar Tipos

```dart
// ✅ CORRETO
Future<Profile> getProfile(String id) async {
  return _dataSource.getProfile(id);
}

// ❌ ERRADO
Future getProfile(id) async {
  return _dataSource.getProfile(id);
}
```

### 4. Sempre Tratar Erros

```dart
// ✅ CORRETO
Future<Profile> getProfile(String id) async {
  try {
    return await _dataSource.getProfile(id);
  } catch (e) {
    throw ProfileNotFoundException(id);
  }
}

// ❌ ERRADO
Future<Profile> getProfile(String id) async {
  return await _dataSource.getProfile(id);
}
```

### 5. Sempre Documentar

```dart
/// Obtém perfil pelo ID.
///
/// [id] é o identificador único do perfil.
/// Retorna o perfil encontrado.
/// Lança [ProfileNotFoundException] se não encontrar.
Future<Profile> getProfile(String id) async {
  // ...
}
```

## Regras por Camada

### Data

```dart
// Models devem ter factory fromJson e toJson
class ProfileModel {
  final String id;
  final String name;
  
  ProfileModel({required this.id, required this.name});
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// Datasources devem ser abstratas
abstract class ProfileDataSource {
  Future<ProfileModel> getProfile(String id);
  Future<void> saveProfile(ProfileModel profile);
}

// Repositories devem implementar interface do domain
class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;
  
  LocalProfileRepository(this.dataSource);
  
  @override
  Future<Profile> getProfile(String id) async {
    final model = await dataSource.getProfile(id);
    return model.toDomain();
  }
}
```

### Domain

```dart
// Entities devem ser imutáveis
class Profile {
  final String id;
  final String name;
  final String? email;
  
  const Profile({
    required this.id,
    required this.name,
    this.email,
  });
}

// UseCases devem ter um único método
class GetProfileUseCase {
  final ProfileRepository repository;
  
  GetProfileUseCase(this.repository);
  
  Future<Profile> call(String id) {
    return repository.getProfile(id);
  }
}

// Repositories devem ser abstratos
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}
```

### Presentation

```dart
// Providers devem usar StateNotifier
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>(
  (ref) => ProfileNotifier(ref),
);

class ProfileNotifier extends StateNotifier<AsyncValue<Profile?>> {
  final Ref ref;
  
  ProfileNotifier(this.ref) : super(const AsyncValue.data(null));
  
  Future<void> loadProfile(String id) async {
    state = const AsyncValue.loading();
    try {
      final profile = await ref.read(getProfileUseCaseProvider).call(id);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Pages devem usar ConsumerWidget
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    
    return profileAsync.when(
      data: (profile) => ProfileView(profile: profile),
      loading: () => const LoadingWidget(),
      error: (e, st) => ErrorWidget(error: e),
    );
  }
}

// Widgets devem ser Stateless quando possível
class ProfileCard extends StatelessWidget {
  final Profile profile;
  
  const ProfileCard({super.key, required this.profile});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(profile.name),
        subtitle: Text(profile.email ?? ''),
      ),
    );
  }
}
```

## Regras de Teste

```dart
// Unit Tests
void main() {
  group('GetProfileUseCase', () {
    test('should return profile when found', () async {
      // Arrange
      final repository = MockProfileRepository();
      final useCase = GetProfileUseCase(repository);
      
      when(repository.getProfile('1')).thenAnswer(
        (_) async => const Profile(id: '1', name: 'Test'),
      );
      
      // Act
      final result = await useCase.call('1');
      
      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test');
    });
  });
}

// Widget Tests
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

### analysis_options.yaml

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_locals
    - avoid_print
    - avoid_relative_lib_imports
    - prefer_single_quotes
    - require_trailing_commas
    - prefer_void_to_null
    - always_declare_return_types
    - annotate_overrides
    - avoid_empty_else
    - avoid_init_to_null
    - avoid_unnecessary_containers
    - avoid_web_libraries_in_flutter
    - no_duplicate_case_values
    - null_closures
    - prefer_adjacent_string_concatenation
    - prefer_collection_literals
    - prefer_is_empty
    - prefer_is_not_empty
    - sized_box_for_whitespace
    - unnecessary_const
    - unnecessary_new
    - unnecessary_string_interpolations
    - unnecessary_string_escapes
    - use_key_in_widget_constructors
```

## Checklist

- [ ] Segue padrões existentes
- [ ] Não quebra arquitetura
- [ ] Usa tipos corretamente
- [ ] Trata erros
- [ ] Documenta
- [ ] Testa
- [ ] Segue lints
