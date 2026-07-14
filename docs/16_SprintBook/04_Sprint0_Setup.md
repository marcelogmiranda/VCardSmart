# Sprint 0 — Setup do Ambiente

## Objetivo

Preparar todo o ambiente de desenvolvimento.

## Pré-requisitos

- Sistema operacional configurado
- Conexão com internet
- Conta GitHub

## Entregas

### Flutter SDK

```bash
# Instalar Flutter
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"

# Verificar
flutter doctor
```

### Dart SDK

```bash
# Verificar
dart --version
```

### VSCode

- [ ] Instalar VSCode
- [ ] Instalar extensão Flutter
- [ ] Instalar extensão Dart
- [ ] Instalar extensão Riverpod
- [ ] Instalar extensão Error Lens

### Android SDK

- [ ] Instalar Android Studio
- [ ] Configurar Android SDK
- [ ] Criar emulador
- [ ] Testar emulador

### Xcode (macOS)

- [ ] Instalar Xcode
- [ ] Configurar iOS Simulator
- [ ] Testar simulador

### Git

- [ ] Instalar Git
- [ ] Configurar usuário
- [ ] Configurar SSH

### GitHub

- [ ] Criar repositório
- [ ] Configurar branch protection
- [ ] Configurar CI/CD

### Fastlane

```bash
# Instalar Fastlane
gem install fastlane

# Verificar
fastlane --version
```

### GitHub Actions

- [ ] Criar workflow de build
- [ ] Criar workflow de teste
- [ ] Criar workflow de release

### Scripts

- [ ] Criar script de build
- [ ] Criar script de teste
- [ ] Criar script de release

## Nada de Código

```
Esta sprint NÃO deve criar código da aplicação.

Apenas configurar ambiente.
```

## Checklist

- [x] Flutter SDK instalado (3.32.8)
- [x] Dart SDK instalado (3.8.1)
- [x] VSCode configurado
- [x] Android SDK configurado
- [x] Xcode configurado (macOS)
- [x] Git configurado (v2.33.0)
- [x] GitHub configurado (repositório criado)
- [ ] Fastlane instalado — pendente instalação
- [x] GitHub Actions configurado (build.yml, release.yml)
- [x] Scripts criados (build.sh, test.sh, release.sh)
- [ ] Emulador funcionando — pendente verificação
- [ ] Simulador funcionando — pendente verificação

## Validação

```bash
# Verificar ambiente
flutter doctor

# Verificar Git
git --version

# Verificar Fastlane
fastlane --version
```

## Próxima Sprint

Sprint 1 — Foundation
