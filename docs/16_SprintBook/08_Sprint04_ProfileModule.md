# Sprint 4 — Profile Module

## Objetivo

Implementar o módulo de perfil completo.

## Pré-requisitos

- Sprint 3 concluída
- Hive configurado

## Documentos Obrigatórios

- Architecture.md
- DataModel.md
- ProfileFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── features/
│   └── profile/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── profile_local_datasource.dart
│       │   ├── models/
│       │   │   └── profile_model.dart
│       │   └── repositories/
│       │       └── local_profile_repository.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── profile.dart
│       │   ├── repositories/
│       │   │   └── profile_repository.dart
│       │   └── usecases/
│       │       ├── get_profile_usecase.dart
│       │       ├── get_all_profiles_usecase.dart
│       │       ├── create_profile_usecase.dart
│       │       ├── update_profile_usecase.dart
│       │       └── delete_profile_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── profile_page.dart
│           │   └── profile_edit_page.dart
│           ├── widgets/
│           │   ├── profile_card.dart
│           │   ├── profile_form.dart
│           │   └── profile_header.dart
│           └── providers/
│               └── profile_provider.dart
```

### Arquivos Alterados

- lib/core/router/app_router.dart

## Modelos

### UseCases

```dart
class GetProfileUseCase {
  final ProfileRepository repository;
  
  GetProfileUseCase(this.repository);
  
  Future<Profile> call(String id) {
    return repository.getProfile(id);
  }
}

class GetAllProfilesUseCase {
  final ProfileRepository repository;
  
  GetAllProfilesUseCase(this.repository);
  
  Future<List<Profile>> call() {
    return repository.getAllProfiles();
  }
}

class CreateProfileUseCase {
  final ProfileRepository repository;
  
  CreateProfileUseCase(this.repository);
  
  Future<void> call(Profile profile) {
    return repository.saveProfile(profile);
  }
}

class UpdateProfileUseCase {
  final ProfileRepository repository;
  
  UpdateProfileUseCase(this.repository);
  
  Future<void> call(Profile profile) {
    return repository.saveProfile(profile);
  }
}

class DeleteProfileUseCase {
  final ProfileRepository repository;
  
  DeleteProfileUseCase(this.repository);
  
  Future<void> call(String id) {
    return repository.deleteProfile(id);
  }
}
```

### Provider

```dart
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>(
  (ref) => ProfileNotifier(ref),
);

final profileListProvider = StateNotifierProvider<ProfileListNotifier, AsyncValue<List<Profile>>>(
  (ref) => ProfileListNotifier(ref),
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
  
  Future<void> createProfile(Profile profile) async {
    try {
      await ref.read(createProfileUseCaseProvider).call(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> updateProfile(Profile profile) async {
    try {
      await ref.read(updateProfileUseCaseProvider).call(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> deleteProfile(String id) async {
    try {
      await ref.read(deleteProfileUseCaseProvider).call(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
```

### Page

```dart
class ProfilePage extends ConsumerWidget {
  final String id;
  
  const ProfilePage({super.key, required this.id});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: profileAsync.when(
        data: (profile) => profile != null
            ? ProfileView(profile: profile)
            : const Center(child: Text('Nenhum perfil')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
```

### Widget

```dart
class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback? onTap;
  
  const ProfileCard({
    super.key,
    required this.profile,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(profile.name),
        subtitle: Text(profile.email ?? ''),
        onTap: onTap,
      ),
    );
  }
}
```

## Critérios de Aceitação

- [x] Entity criada
- [x] Model criada
- [x] Repository Interface criada
- [x] Repository Implementation criada
- [x] UseCases criados
- [x] Provider criado
- [x] Pages criadas
- [x] Widgets criados
- [x] Rotas configuradas
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Entity criada
- [x] Model criada
- [x] Repository Interface criada
- [x] Repository Implementation criada
- [x] UseCases criados
- [x] Provider criado
- [x] Pages criadas
- [x] Widgets criados
- [x] Rotas configuradas
- [x] Build funcionando
- [x] Testes passando (67/67)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (100%)
- [x] CHANGELOG atualizado (v1.4.0)

## Próxima Sprint

Sprint 5 — Photo Module
