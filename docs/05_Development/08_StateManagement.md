# State Management

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack

| Componente | Uso |
|-----------|-----|
| **AsyncNotifier** | Estado assíncrono |
| **Notifier** | Estado síncrono |
| **Provider** | Dependências |
| **FutureProvider** | Valores futuros |
| **StreamProvider** | Streams |
| **Family** | Parâmetros dinâmicos |
| **AutoDispose** | Limpeza automática |

---

## Quando Usar

| Padrão | Quando | Exemplo |
|--------|--------|---------|
| **AsyncNotifier** | Operações async complexas | ProfileNotifier |
| **Notifier** | Estado síncrono com lógica | ThemeNotifier |
| **Provider** | Dependência simples | RepositoryProvider |
| **FutureProvider** | Valor único async | profileFutureProvider |
| **StreamProvider** | Stream de dados | nfcStreamProvider |
| **Family** | Dados por parâmetro | profileByIdProvider(id) |
| **AutoDispose** | Estado temporário | searchProvider |

---

## Exemplo: AsyncNotifier

```dart
class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final getProfile = ref.read(getProfileUseCaseProvider);
    return await getProfile();
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncValue.loading();
    final saveProfile = ref.read(saveProfileUseCaseProvider);
    await saveProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile?>(
  ProfileNotifier.new,
);
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Um Provider por UseCase |
| 2 | Sem Providers gigantes |
| 3 | AutoDispose quando possível |
| 4 | Estado imutável |
| 5 | Loading explícito |
| 6 | Erro tratado |

---

## Documentos Relacionados

- [05_StateManagement.md](../04_Architecture/05_StateManagement.md)
- [13_Providers.md](./13_Providers.md)
- [14_Controllers.md](./14_Controllers.md)
