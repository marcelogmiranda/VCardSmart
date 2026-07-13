# Controllers

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Controllers apenas para UI |
| 2 | Sem regra de negócio |
| 3 | Sem acesso ao Hive |
| 4 | Controllers usam UseCases |

---

## Padrão

```dart
class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final getProfile = ref.read(getProfileUseCaseProvider);
    return await getProfile();
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncValue.loading();
    try {
      final saveProfile = ref.read(saveProfileUseCaseProvider);
      await saveProfile(profile);
      state = AsyncValue.data(profile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}
```

---

## Responsabilidades

| Responsabilidade | Quem |
|-----------------|------|
| Carregar dados | Controller |
| Salvar dados | Controller (via UseCase) |
| Tratar erros | Controller |
| Gerenciar estado | Controller |
| Regra de negócio | UseCase |
| Acesso a dados | Repository |

---

## Documentos Relacionados

- [08_StateManagement.md](./08_StateManagement.md)
- [13_Providers.md](./13_Providers.md)
- [11_UseCases.md](./11_UseCases.md)
