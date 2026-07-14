# Error Handling

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Conceitos

| Conceito | Descrição |
|----------|-----------|
| **Failure** | Erro de negócio |
| **Result** | Tipo de retorno (sucesso/erro) |
| **Either** | Alternativa (esquerda=erro, direita=sucesso) |
| **Exceptions** | Erros de sistema (convertidos em Failure) |

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
```

---

## Mensagens Amigáveis

| Erro | Mensagem |
|------|----------|
| NFC indisponível | "Seu dispositivo não possui NFC. Use QR Code." |
| Câmera indisponível | "Câmera não disponível. Use NFC." |
| Permissão negada | "Permissão necessária. Conceda nas configurações." |
| Dados inválidos | "Dados inválidos. Verifique e tente novamente." |

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

- [16_ErrorHandling.md](../04_Architecture/16_ErrorHandling.md)
- [12_States.md](../06_UX_UI/12_States.md)
