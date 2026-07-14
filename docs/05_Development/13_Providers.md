# Providers

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Um Provider por UseCase |
| 2 | Sem Providers gigantes |
| 3 | AutoDispose quando possível |
| 4 | Providers em ordem hierárquica |

---

## Padrão

### Provider de UseCase
```dart
final saveProfileUseCaseProvider = Provider<SaveProfileUseCase>((ref) {
  return SaveProfileUseCase(
    ref.watch(profileRepositoryProvider),
  );
});
```

### Provider de Repository
```dart
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    dataSource: ref.watch(profileDataSourceProvider),
  );
});
```

### Provider de DataSource
```dart
final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  return ProfileDataSource();
});
```

### AsyncNotifier Provider
```dart
final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile?>(
  ProfileNotifier.new,
);
```

---

## AutoDispose

```dart
final searchProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  // Limpo automaticamente quando não utilizado
  return [];
});
```

---

## Family

```dart
final contactByIdProvider = FutureProvider.family<Contact?, String>((ref, id) async {
  final repository = ref.watch(contactsRepositoryProvider);
  return await repository.getContactById(id);
});
```

---

## Documentos Relacionados

- [05_StateManagement.md](../04_Architecture/05_StateManagement.md)
- [07_DependencyInjection.md](./07_DependencyInjection.md)
- [14_Controllers.md](./14_Controllers.md)
