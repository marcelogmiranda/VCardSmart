# Logging

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Níveis de Log

| Nível | Quando Usar | Exemplo |
|-------|-------------|---------|
| **Debug** | Desenvolvimento | "Profile loaded" |
| **Info** | Informações relevantes | "App started" |
| **Warning** | Avisos não críticos | "NFC unavailable" |
| **Error** | Erros que precisam de atenção | "Database error" |

---

## Comportamento por Ambiente

| Ambiente | Logs | Detalhes |
|----------|------|----------|
| **Debug** | Todos | Completos com stack trace |
| **Release** | Mínimos | Apenas errors sem dados pessoais |

---

## Regras

| # | Regra | Descrição |
|---|-------|-----------|
| 1 | Sem dados pessoais | Nunca logar nome, e-mail, telefone |
| 2 | Sem telemetria | Logs são apenas locais |
| 3 | Mínimos em release | Apenas errors críticos |
| 4 | Locais | Logs ficam no dispositivo |
| 5 | Sem cloud | Logs nunca são enviados externamente |

---

## Implementação

### Logger Service
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
    // Em release, logar em arquivo local se necessário
  }
}
```

---

## Uso

```dart
// ✅ CORRETO
LoggerService.debug('Profile loaded');
LoggerService.info('App started');
LoggerService.warning('NFC unavailable');
LoggerService.error('Database error', e, stackTrace);

// ❌ INCORRETO
LoggerService.debug('User name: João Silva'); // Dados pessoais
LoggerService.info('Email: joao@exemplo.com'); // Dados pessoais
```

---

## Documentos Relacionados

- [16_ErrorHandling.md](./16_ErrorHandling.md)
- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
- [13_Privacy.md](../03_Product/13_Privacy.md)
