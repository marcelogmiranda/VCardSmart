# Configuração Flutter — VCardSmart

## Comandos Essenciais

### Verificação do Ambiente

```bash
# Verificar instalação completa
flutter doctor

# Verificar versão
flutter --version

# Verificar dispositivos conectados
flutter devices
```

### Gerenciamento de Pacotes

```bash
# Instalar dependências
flutter pub get

# Atualizar dependências
flutter pub upgrade

# Remover dependências não utilizadas
flutter pub cache clean

# Verificar dependências desatualizadas
flutter pub outdated
```

### Análise de Código

```bash
# Analisar código
flutter analyze

# Analisar com verbose
flutter analyze -v

# Analisar arquivo específico
flutter analyze lib/main.dart
```

### Testes

```bash
# Rodar todos os testes
flutter test

# Rodar com cobertura
flutter test --coverage

# Rodar teste específico
flutter test test/unit/profile_test.dart

# Rodar com verbose
flutter test -v
```

### Geração de Código

```bash
# Gerar localização
flutter gen-l10n

# Gerar modelos (build_runner)
dart run build_runner build

# Gerar modelos (watch)
dart run build_runner watch

# Limpar e gerar
dart run build_runner build --delete-conflicting-outputs
```

### Formatação

```bash
# Formatar todo o projeto
dart format .

# Verificar formatação
dart format --set-exit-if-changed .

# Formatar arquivo específico
dart format lib/main.dart
```

### Build

```bash
# Build debug
flutter build apk --debug

# Build release
flutter build apk --release

# Build profile
flutter build apk --profile

# Build iOS
flutter build ios --release

# Build AAB
flutter build appbundle --release
```

### Limpeza

```bash
# Limpar projeto
flutter clean

# Limpar e reconstruir
flutter clean && flutter pub get

# Limpar cache
flutter pub cache clean
```

## Configuração do Projeto

### pubspec.yaml

```yaml
name: vcardsmart
description: VCardSmart - Digital Business Card
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  
  # Navigation
  go_router: ^13.0.0
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  
  # Native Features
  local_auth: ^2.1.7
  flutter_contacts: ^1.1.7+1
  mobile_scanner: ^3.5.5
  nfc_manager: ^3.1.3
  
  # Sharing
  share_plus: ^7.2.1
  url_launcher: ^6.2.1
  
  # Ads
  google_mobile_ads: ^4.0.0
  
  # Utils
  uuid: ^4.2.1
  
  # Code Generation
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  
  # Code Generation
  build_runner: ^2.4.7
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  
  # Mocking
  mockito: ^5.4.3
  
  # Testing
  patrol: ^3.4.1

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
    - assets/l10n/

  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700

flutter_intl:
  enabled: true
  class_name: AppLocalizations
  output_dir: lib/generated
  main_locale: pt
  supported_locales:
    - pt
    - en
    - es
    - fr
    - it
    - de
    - ja
    - zh
```

## IDE Setup

### VS Code

- Extensão Flutter
- Extensão Dart
- Format on Save habilitado
- Auto import habilitado

### Android Studio

- Flutter plugin
- Dart plugin
- Android SDK
- iOS Simulator (macOS)

### Xcode (macOS)

- Command Line Tools
- iOS Simulator
- Certificados de assinatura
