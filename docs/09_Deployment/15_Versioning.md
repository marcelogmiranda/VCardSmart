# Versionamento — VCardSmart

## Semantic Versioning

### Formato

```
Major.Minor.Patch+BuildNumber
```

| Campo | Descrição | Incremento |
|-------|-----------|------------|
| Major | Breaking changes | Mudanças incompatíveis |
| Minor | Novas funcionalidades | Backward compatible |
| Patch | Correções de bugs | Backward compatible |
| BuildNumber | Número do build | Sempre incrementa |

### Exemplos

| Versão | Descrição |
|--------|-----------|
| 1.0.0+1 | Primeira versão |
| 1.0.1+2 | Correção de bug |
| 1.1.0+3 | Nova funcionalidade |
| 2.0.0+4 | Breaking change |

## Configuração

### pubspec.yaml

```yaml
version: 1.0.0+1
```

### Android

```groovy
// android/app/build.gradle
android {
    defaultConfig {
        versionCode 1
        versionName "1.0.0"
    }
}
```

### iOS

```ruby
# ios/Runner.xcodeproj
MARKETING_VERSION = 1.0.0
CURRENT_PROJECT_VERSION = 1
```

## Automação

### Incrementar Versão

```bash
# Script para incrementar versão
#!/bin/bash

# Ler versão atual
CURRENT_VERSION=$(grep "version:" pubspec.yaml | cut -d' ' -f2)
VERSION_NAME=$(echo $CURRENT_VERSION | cut -d'+' -1)
BUILD_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -2)

# Incrementar build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))

# Atualizar pubspec.yaml
sed -i "s/version: $CURRENT_VERSION/version: $VERSION_NAME+$NEW_BUILD_NUMBER/" pubspec.yaml

echo "Versão atualizada: $VERSION_NAME+$NEW_BUILD_NUMBER"
```

### Fastlane

```ruby
# fastlane/Fastfile
lane :bump_version do
  # Incrementar build number
  increment_build_number(
    xcodeproj: "ios/Runner.xcodeproj"
  )
  
  # Atualizar versionCode Android
  gradle(task: "incrementVersionCode", project_dir: "android")
end
```

### GitHub Actions

```yaml
- name: Bump version
  run: |
    chmod +x scripts/bump_version.sh
    ./scripts/bump_version.sh
```

## Versionamento por Plataforma

### Android

| Campo | Descrição | Exemplo |
|-------|-----------|---------|
| versionName | Nome da versão | "1.0.0" |
| versionCode | Código numérico | 1 |

### iOS

| Campo | Descrição | Exemplo |
|-------|-----------|---------|
| MARKETING_VERSION | Nome da versão | "1.0.0" |
| CURRENT_PROJECT_VERSION | Código numérico | 1 |

## Histórico de Versões

### CHANGELOG.md

```markdown
# Changelog

## [1.2.0] - 2024-01-15
### Added
- NFC write support
- Multi-language support

### Changed
- Improved QR code generation

### Fixed
- Profile editing bug

## [1.1.0] - 2024-01-01
### Added
- QR code generation
- Contact import/export

### Fixed
- Login issue

## [1.0.0] - 2023-12-01
### Added
- Initial release
- Profile creation
- QR code scanning
```
