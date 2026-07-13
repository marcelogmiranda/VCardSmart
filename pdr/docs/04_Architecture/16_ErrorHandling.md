# Error Handling

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estratégia

| Conceito | Descrição |
|----------|-----------|
| **Exceptions** | Erros de sistema (Hive, plugins) |
| **Failure** | Erros de negócio (validação, regras) |
| **Result** | Tipo de retorno que encapsula sucesso/erro |
| **Logs** | Registro local de erros |
| **Mensagens** | Mensagens amigáveis ao usuário |

---

## Hierarquia de Erros

```
AppException
├── DatabaseException
│   ├── HiveException
│   └── MigrationException
├── PermissionException
│   ├── NfcPermissionException
│   ├── CameraPermissionException
│   └── ContactsPermissionException
├── ValidationException
│   ├── InvalidEmailException
│   ├── InvalidPhoneException
│   └── EmptyFieldException
├── ShareException
│   ├── NfcShareException
│   ├── QrShareException
│   └── VCardException
└── AuthException
    ├── BiometricException
    └── PinException
```

---

## Failure

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ShareFailure extends Failure {
  const ShareFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
```

---

## Result

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
```

---

## Uso

```dart
// Use Case
class SaveProfileUseCase {
  final ProfileRepository repository;

  Future<Result<void>> call(UserProfile profile) async {
    try {
      await repository.saveProfile(profile);
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure('Erro ao salvar perfil'));
    }
  }
}

// Provider
class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  Future<void> save(UserProfile profile) async {
    state = const AsyncValue.loading();
    final result = await saveProfile(profile);
    state = switch (result) {
      Success() => AsyncValue.data(profile),
      FailureResult(failure: final f) => AsyncValue.error(f.message, StackTrace.empty),
    };
  }
}
```

---

## Mensagens Amigáveis

| Erro | Mensagem para o Usuário |
|------|------------------------|
| NFC indisponível | "Seu dispositivo não possui NFC. Use QR Code." |
| Câmera indisponível | "Câmera não disponível. Use NFC." |
| Permissão negada | "Permissão necessária. Conceda nas configurações." |
| Dados inválidos | "Dados inválidos. Verifique e tente novamente." |
| Falha ao salvar | "Erro ao salvar. Tente novamente." |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Nunca mostrar StackTrace ao usuário |
| 2 | Sempre logar erros em debug |
| 3 | Mensagens amigáveis em release |
| 4 | Tratar erros de plugin graciosamente |
| 5 | Nunca crashar o app |

---

## Documentos Relacionados

- [17_Logging.md](./17_Logging.md)
- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
