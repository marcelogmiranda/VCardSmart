# Validation Rules

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Regras de Validação por Campo

### UserProfile

| Campo | Obrigatório | Regra de Validação |
|-------|-------------|-------------------|
| `fullName` | ✅ | Mínimo 2 caracteres |
| `companyName` | ✅ | Mínimo 1 caractere |
| `jobTitle` | ✅ | Mínimo 1 caractere |
| `presentation` | ✅ | Máximo 500 caracteres |
| `email` | ✅ | Formato de e-mail válido |
| `website` | ❌ | URL válida (se informado) |
| `photoPath` | ❌ | Caminho válido (se informado) |
| `logoPath` | ❌ | Caminho válido (se informado) |

### Phone

| Campo | Obrigatório | Regra de Validação |
|-------|-------------|-------------------|
| `label` | ✅ | Não vazio |
| `number` | ✅ | Mínimo 8 dígitos |
| `countryCode` | ✅ | Formato +XX |

### SocialNetwork

| Campo | Obrigatório | Regra de Validação |
|-------|-------------|-------------------|
| `type` | ✅ | Tipo suportado |
| `url` | ✅ | URL válida |
| `username` | ❌ | Não vazio (se informado) |

---

## Validação de E-mail

```dart
class EmailValidator {
  static bool isValid(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
```

---

## Validação de Telefone

```dart
class PhoneValidator {
  static bool isValid(String phone) {
    final regex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    return regex.hasMatch(phone) && phone.length >= 8;
  }
}
```

---

## Validação de URL

```dart
class UrlValidator {
  static bool isValid(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w-./?%&=]*)?$',
    );
    return regex.hasMatch(url);
  }
}
```

---

## Validação de UUID

```dart
class UuidValidator {
  static bool isValid(String uuid) {
    final regex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    );
    return regex.hasMatch(uuid);
  }
}
```

---

## Mensagens de Erro

| Campo | Mensagem |
|-------|----------|
| `fullName` | "Nome deve ter pelo menos 2 caracteres" |
| `email` | "E-mail inválido" |
| `phone` | "Telefone inválido" |
| `website` | "URL inválida" |
| `required` | "Campo obrigatório" |

---

## Documentos Relacionados

- [03_Entities.md](./03_Entities.md)
- [04_ValueObjects.md](./04_ValueObjects.md)
- [11_AcceptanceCriteria.md](../03_Product/11_AcceptanceCriteria.md)
