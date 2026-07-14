# Logging

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Níveis

| Nível | Quando Usar |
|-------|-------------|
| **Debug** | Desenvolvimento |
| **Info** | Informações relevantes |
| **Warning** | Avisos não críticos |
| **Error** | Erros que precisam de atenção |

---

## Implementação

```dart
class LoggerService {
  static void debug(String message) {
    if (kDebugMode) {
      print('[DEBUG] $message');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      print('[WARNING] $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) print('  Error: $error');
      if (stackTrace != null) print('  Stack: $stackTrace');
    }
  }
}
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sem dados pessoais |
| 2 | Sem analytics |
| 3 | Mínimos em release |
| 4 | Locais |
| 5 | Sem cloud |

---

## Documentos Relacionados

- [17_Logging.md](../04_Architecture/17_Logging.md)
- [13_Privacy.md](../03_Product/13_Privacy.md)
