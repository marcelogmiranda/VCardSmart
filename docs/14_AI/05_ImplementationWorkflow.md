# Workflow de Implementação — VCardSmart

## Fluxo Geral

```
1. Receber Tarefa
      ↓
2. Ler Documentação
      ↓
3. Planejar Implementação
      ↓
4. Implementar
      ↓
5. Testar
      ↓
6. Revisar
      ↓
7. Documentar
      ↓
8. Commit
```

## Passo 1: Receber Tarefa

### Inputs

- Descrição da tarefa
- Acceptance Criteria
- Prioridade
- Dependências

### Validação

- [ ] Tarefa clara
- [ ] Critérios definidos
- [ ] Sem dependências pendentes
- [ ] Contexto suficiente

## Passo 2: Ler Documentação

### Documentos

| Documento | Ordem |
|-----------|-------|
| README | 1 |
| PROJECT_CONTEXT | 2 |
| PRODUCT_REQUIREMENTS | 3 |
| ARCHITECTURE | 4 |
| DATA_MODEL | 5 |
| ACCEPTANCE | 6 |
| TASK | 7 |

### Checklist

- [ ] Entendi o projeto
- [ ] Entendi a feature
- [ ] Entendi a arquitetura
- [ ] Entendi os padrões
- [ ] Entendi os critérios

## Passo 3: Planejar Implementação

### Componentes a Criar

| Componente | Camada | Descrição |
|------------|--------|-----------|
| Entity | Domain | Modelo de negócio |
| Model | Data | Serialização |
| Repository Interface | Domain | Contrato |
| Repository Implementation | Data | Implementação |
| UseCase | Domain | Lógica de negócio |
| Provider | Presentation | Estado |
| Page | Presentation | Tela |
| Widget | Presentation | Componente |
| Test | Test | Cobertura |
| Localization | Core | Textos |

### Ordem de Implementação

```
1. Entity
2. Model
3. Repository Interface
4. Repository Implementation
5. UseCase
6. Provider
7. Widget
8. Page
9. Test
10. Localization
```

## Passo 4: Implementar

### Entity

```dart
// domain/entities/profile.dart
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
```

### Model

```dart
// data/models/profile_model.dart
class ProfileModel {
  final String id;
  final String name;
  final String? email;
  
  ProfileModel({
    required this.id,
    required this.name,
    this.email,
  });
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
  
  Profile toDomain() {
    return Profile(
      id: id,
      name: name,
      email: email,
    );
  }
  
  factory ProfileModel.fromDomain(Profile profile) {
    return ProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
    );
  }
}
```

### Repository Interface

```dart
// domain/repositories/profile_repository.dart
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}
```

### Repository Implementation

```dart
// data/repositories/local_profile_repository.dart
class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;
  
  LocalProfileRepository(this.dataSource);
  
  @override
  Future<Profile> getProfile(String id) async {
    final model = await dataSource.getProfile(id);
    return model.toDomain();
  }
  
  @override
  Future<List<Profile>> getAllProfiles() async {
    final models = await dataSource.getAllProfiles();
    return models.map((m) => m.toDomain()).toList();
  }
  
  @override
  Future<void> saveProfile(Profile profile) async {
    final model = ProfileModel.fromDomain(profile);
    await dataSource.saveProfile(model);
  }
  
  @override
  Future<void> deleteProfile(String id) async {
    await dataSource.deleteProfile(id);
  }
}
```

### UseCase

```dart
// domain/usecases/get_profile_use_case.dart
class GetProfileUseCase {
  final ProfileRepository repository;
  
  GetProfileUseCase(this.repository);
  
  Future<Profile> call(String id) {
    return repository.getProfile(id);
  }
}
```

### Provider

```dart
// presentation/providers/profile_provider.dart
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
```

### Widget

```dart
// presentation/widgets/profile_card.dart
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

### Page

```dart
// presentation/pages/profile_page.dart
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: profileAsync.when(
        data: (profile) => profile != null
            ? ProfileCard(profile: profile)
            : const Center(child: Text('Nenhum perfil')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
```

## Passo 5: Testar

### Unit Tests

```dart
// test/domain/usecases/get_profile_use_case_test.dart
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
      expect(result.name, 'Test');
    });
  });
}
```

### Widget Tests

```dart
// test/presentation/widgets/profile_card_test.dart
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

## Passo 6: Revisar

### Checklist

- [ ] Código segue padrões
- [ ] Arquitetura mantida
- [ ] Testes passando
- [ ] Lints OK
- [ ] Performance OK
- [ ] Segurança OK

## Passo 7: Documentar

### Atualizar

- [ ] CHANGELOG
- [ ] README (se necessário)
- [ ] Documentação da feature
- [ ] ADR (se necessário)

## Passo 8: Commit

### Mensagem

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
