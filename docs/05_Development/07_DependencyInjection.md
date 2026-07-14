# Dependency Injection

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack

| Componente | Papel |
|-----------|-------|
| **Riverpod** | Container de dependências |
| **Provider** | Provedor de dependências |
| **Lazy Loading** | Inicialização sob demanda |

---

## Proibido

| Package | Motivo |
|---------|--------|
| **GetIt** | Riverpod é o container oficial |
| **Service Locator** | Riverpod é o container oficial |

---

## Injeção

### Provider
```dart
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(
    dataSource: ref.watch(profileDataSourceProvider),
  );
});
```

### Uso
```dart
class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> call(UserProfile profile) async {
    await repository.saveProfile(profile);
  }
}
```

### Provider do UseCase
```dart
final saveProfileUseCaseProvider = Provider<SaveProfileUseCase>((ref) {
  return SaveProfileUseCase(
    ref.watch(profileRepositoryProvider),
  );
});
```

---

## Lazy Loading

```dart
// Provider só é criado quando necessário
final heavyProvider = Provider<HeavyService>((ref) {
  return HeavyService();
});
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Uma dependência por Provider |
| 2 | Providers em ordem hierárquica |
| 3 | Lazy Loading sempre que possível |
| 4 | Sem dependências circulares |
| 5 | Testes com mocks via Provider overrides |

---

## Documentos Relacionados

- [05_StateManagement.md](../04_Architecture/05_StateManagement.md)
- [13_Providers.md](./13_Providers.md)
