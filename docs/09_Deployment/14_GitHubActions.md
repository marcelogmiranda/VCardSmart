# GitHub Actions — VCardSmart

## Pipeline CI

```yaml
# .github/workflows/flutter_ci.yml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Analyze
        run: flutter analyze
      
      - name: Format check
        run: dart format --set-exit-if-changed .

  test:
    name: Test
    runs-on: ubuntu-latest
    needs: analyze
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Unit Tests
        run: flutter test --coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info

  build-android:
    name: Build Android
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '17'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build APK
        run: flutter build apk --release
      
      - name: Build AAB
        run: flutter build appbundle --release
      
      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: android-build
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab

  build-ios:
    name: Build iOS
    runs-on: macos-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign
      
      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: ios-build
          path: build/ios/iphoneos/Runner.app
```

## Pipeline Release

```yaml
# .github/workflows/flutter_release.yml
name: Flutter Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    name: Release
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run tests
        run: flutter test
      
      - name: Build Android
        run: flutter build apk --release
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign
      
      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          files: |
            build/app/outputs/flutter-apk/app-release.apk
          draft: false
          prerelease: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Dependabot

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "flutter"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
  
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

## CODEOWNERS

```
# .github/CODEOWNERS
* @developer

# Flutter code
lib/ @flutter-team

# Documentation
docs/ @docs-team
```

## PR Template

```markdown
<!-- .github/pull_request_template.md -->
## Descrição

[Descreva as mudanças]

## Tipo de Mudança

- [ ] Bug fix
- [ ] Nova funcionalidade
- [ ] Breaking change
- [ ] Documentação
- [ ] Refactoring

## Checklist

- [ ] Código formatado
- [ ] flutter analyze sem erros
- [ ] Testes passando
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado
```

## Issue Templates

### Bug Report

```yaml
# .github/ISSUE_TEMPLATE/bug_report.md
name: Bug Report
description: Reportar um bug
labels: ["bug"]
body:
  - type: textarea
    id: description
    attributes:
      label: Descrição
      description: Descreva o bug
    validations:
      required: true
  - type: textarea
    id: steps
    attributes:
      label: Passos para reproduzir
      description: Passos para reproduzir o comportamento
    validations:
      required: true
  - type: textarea
    id: expected
    attributes:
      label: Comportamento esperado
      description: O que deveria acontecer
    validations:
      required: true
  - type: dropdown
    id: platform
    attributes:
      label: Plataforma
      options:
        - Android
        - iOS
        - Both
    validations:
      required: true
```

### Feature Request

```yaml
# .github/ISSUE_TEMPLATE/feature_request.md
name: Feature Request
description: Sugerir uma nova funcionalidade
labels: ["enhancement"]
body:
  - type: textarea
    id: description
    attributes:
      label: Descrição
      description: Descreva a funcionalidade
    validations:
      required: true
  - type: textarea
    id: motivation
    attributes:
      label: Motivação
      description: Por que essa funcionalidade é importante
    validations:
      required: true
  - type: textarea
    id: alternatives
    attributes:
      label: Alternativas consideradas
      description: Outras soluções consideradas
```
