# CI/CD

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Pipeline

| Etapa | Comando | Descrição |
|-------|---------|-----------|
| **Analyze** | `flutter analyze` | Verificar erros |
| **Format** | `dart format .` | Formatar código |
| **Test** | `flutter test` | Executar testes |
| **Build Android** | `flutter build apk` | Build APK |
| **Build iOS** | `flutter build ios` | Build iOS |
| **Release** | Deploy | Publicação |

---

## GitHub Actions

### Workflow
```yaml
name: CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter analyze
      - run: dart format --set-exit-if-changed .

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter test --coverage

  build-android:
    needs: [analyze, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter build apk

  build-ios:
    needs: [analyze, test]
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter build ios --no-codesign
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | CI roda em todo push/PR |
| 2 | Build só após analyze + test |
| 3 | Testes devem passar |
| 4 | Sem erros no analyze |

---

## Documentos Relacionados

- [20_CICD.md](./20_CICD.md)
- [19_GitStrategy.md](./19_GitStrategy.md)
