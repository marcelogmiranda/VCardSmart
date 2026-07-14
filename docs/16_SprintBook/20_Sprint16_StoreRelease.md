# Sprint 16 — Store Release

## Objetivo

Preparar e publicar nas lojas.

## Pré-requisitos

- Sprint 15 concluída
- Optimization implementado

## Documentos Obrigatórios

- Architecture.md
- GooglePlayListing.md
- AppStoreListing.md

## Arquivos Envolvidos

### Arquivos Alterados

- pubspec.yaml
- android/app/build.gradle
- ios/Runner.xcodeproj
- android/app/src/main/AndroidManifest.xml
- ios/Runner/Info.plist

## Checklist Android

### Build

```bash
# Limpar
flutter clean

# Dependências
flutter pub get

# Build de release
flutter build appbundle --release
```

### Assinatura

- [ ] Keystore criado
- [ ] key.properties configurado
- [ ] build.gradle configurado

### Configuração

- [ ] version no pubspec.yaml
- [ ] compileSdkVersion
- [ ] minSdkVersion (21)
- [ ] targetSdkVersion (34)
- [ ] Permissões no AndroidManifest.xml

### Store Listing

- [ ] Título (≤ 30 caracteres)
- [ ] Descrição curta (≤ 80 caracteres)
- [ ] Descrição completa
- [ ] Screenshots (1080x1920)
- [ ] Feature graphic (1024x500)
- [ ] Ícone (512x512)
- [ ] Classificação indicativa
- [ ] Data Safety preenchido

### Publicação

```bash
# Upload para Play Console
fastlane android deploy
```

## Checklist iOS

### Build

```bash
# Limpar
flutter clean

# Dependências
flutter pub get

# Build de release
flutter build ipa --release
```

### Assinatura

- [ ] Certificado criado
- [ ] Provisioning profile configurado
- [ ] Xcode configurado

### Configuração

- [ ] version no pubspec.yaml
- [ ] IPHONEOS_DEPLOYMENT_TARGET (12.0)
- [ ] Permissões no Info.plist

### Store Listing

- [ ] Título (≤ 30 caracteres)
- [ ] Subtítulo (≤ 30 caracteres)
- [ ] Keywords (≤ 100 caracteres)
- [ ] Descrição
- [ ] Screenshots (1170x2532)
- [ ] App Preview
- [ ] Ícone (1024x1024)
- [ ] Age Rating
- [ ] Privacy Labels

### Publicação

```bash
# Upload para App Store Connect
fastlane ios deploy
```

## CI/CD

### GitHub Actions

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build appbundle --release
      - uses: actions/upload-artifact@v3
        with:
          name: android
          path: build/app/outputs/bundle/release/

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build ipa --release
      - uses: actions/upload-artifact@v3
        with:
          name: ios
          path: build/ios/ipa/
```

## Versão

### SemVer

```
MAJOR.MINOR.PATCH

1.0.0
```

### Atualização

```yaml
# pubspec.yaml
version: 1.0.0+1
```

## Pós-Release

- [ ] Monitorar crash reports
- [ ] Monitorar reviews
- [ ] Monitorar métricas
- [ ] Responder feedback
- [ ] Planejar atualização

## Critérios de Aceitação

- [x] Build Android funcionando
- [x] Build iOS funcionando
- [x] Assinatura configurada (template key.properties)
- [x] Store listing completo (GooglePlayListing.md, AppStoreListing.md)
- [ ] Publicado na Google Play (requer keystore + Play Console)
- [ ] Publicado na App Store (requer certificado + App Store Connect)
- [ ] Monitoramento ativo

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80% (88.1%)
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Build Android funcionando
- [x] Build iOS funcionando
- [x] Assinatura configurada (template key.properties)
- [x] Store listing completo (GooglePlayListing.md, AppStoreListing.md)
- [ ] Publicado na Google Play (requer keystore + Play Console)
- [ ] Publicado na App Store (requer certificado + App Store Connect)
- [ ] Monitoramento ativo
- [x] CHANGELOG atualizado (v1.0.0+1)

## FIM

```
Parabéns! O VCardSmart está nas lojas!

Próximos passos:
- Monitorar métricas
- Coletar feedback
- Planejar v1.1.0
```
