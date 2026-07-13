# Flutter Standards

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Versão

| Propriedade | Valor |
|-------------|-------|
| **Flutter** | Stable (latest) |
| **Dart** | Stable (latest) |
| **Null Safety** | ✅ Obrigatório |
| **Material Design** | 3 |

---

## Features Obrigatórias

| Feature | Status |
|---------|--------|
| **Null Safety** | ✅ Obrigatório |
| **Const Constructors** | ✅ Obrigatório |
| **Named Parameters** | ✅ Obrigatório |
| **Extension Methods** | ✅ Quando necessário |
| **Enums** | ✅ Obrigatório |
| **Records** | ✅ Quando aplicável |
| **Pattern Matching** | ✅ Quando aplicável |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sem código depreciado |
| 2 | Sem warnings no `flutter analyze` |
| 3 | Null safety obrigatório |
| 4 | Const constructors sempre que possível |
| 5 | Named parameters para funções com 3+ parâmetros |

---

## Exemplos

### ✅ CORRETO
```dart
class UserProfile {
  final String id;
  final String fullName;
  final String email;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
  });
}
```

### ❌ INCORRETO
```dart
class UserProfile {
  String id;
  String fullName;
  String email;

  UserProfile(this.id, this.fullName, this.email);
}
```

---

## Documentos Relacionados

- [01_DevelopmentGuide.md](./01_DevelopmentGuide.md)
- [04_CodingStandards.md](./04_CodingStandards.md)
- [05_NamingConvention.md](./05_NamingConvention.md)
