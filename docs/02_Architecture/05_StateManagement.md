# State Management

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack de Estado

| Componente | Papel |
|-----------|-------|
| **Riverpod** | Gerenciador de estado principal |
| **StateNotifier** | Estado mutável com lógica |
| **Provider** | Provedor de dependências |
| **AsyncNotifier** | Estado assíncrono |
| **Family** | Parâmetros dinâmicos |
| **AutoDispose** | Limpeza automática |

---

## Quando Usar Cada Padrão

| Padrão | Quando Usar | Exemplo |
|--------|-------------|---------|
| **StateNotifier** | Estado complexo com lógica | ProfileNotifier |
| **Provider** | Dependência simples | DatabaseProvider |
| **AsyncNotifier** | Operações assíncronas | ProfileAsyncNotifier |
| **Family** | Dados por parâmetro | profileByIdProvider(id) |
| **AutoDispose** | Estado temporário | searchProvider |

---

## NUNCA Utilizar

| Package | Motivo |
|---------|--------|
| **Provider Package** | Riverpod é o sucessor |
| **Bloc** | Complexidade desnecessária |
| **GetX** | Acoplamento excessivo |
| **MobX** | Complexidade desnecessária |

---

## Exemplo: Profile Feature

### Entity (Domain)
```dart
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  // ...
}
```

### Repository Interface (Domain)
```dart
abstract class ProfileRepository {
  Future<UserProfile?> getProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> deleteProfile();
}
```

### StateNotifier (Application)
```dart
class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final GetProfileUseCase getProfile;
  final SaveProfileUseCase saveProfile;

  ProfileNotifier({
    required this.getProfile,
    required this.saveProfile,
  }) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    state = const AsyncValue.loading();
    final profile = await getProfile();
    state = AsyncValue.data(profile);
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncValue.loading();
    await saveProfile(profile);
    state = AsyncValue.data(profile);
  }
}
```

### Provider (Application)
```dart
final profileProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final getProfile = ref.watch(getProfileUseCaseProvider);
  final saveProfile = ref.watch(saveProfileUseCaseProvider);
  return ProfileNotifier(getProfile: getProfile, saveProfile: saveProfile);
});
```

### Page (Presentation)
```dart
class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return profileAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Erro: $error'),
      data: (profile) => ProfileWidget(profile: profile),
    );
  }
}
```

---

## Regras de Estado

| Regra | Descrição |
|-------|-----------|
| **Um provider por feature** | Cada feature tem seu provider principal |
| **Estado imutável** | Nunca mutar estado diretamente, sempre criar novo |
| **Loading explícito** | Sempre mostrar estado de carregamento |
| **Erro tratado** | Sempre tratar erros com AsyncValue |
| **AutoDispose** | Usar para estado temporário |
| **Family** | Usar para dados por parâmetro |

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
- [06_Navigation.md](./06_Navigation.md)
