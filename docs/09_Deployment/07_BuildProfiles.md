# Perfis de Build — VCardSmart

## Visão Geral

| Perfil | Uso | Otimização | Debug |
|--------|-----|------------|-------|
| Debug | Desenvolvimento | Não | Sim |
| Profile | Performance | Parcial | Não |
| Release | Produção | Total | Não |

## Perfis Disponíveis

### Debug

```bash
flutter build apk --debug
flutter build ios --debug
flutter run --debug
```

**Características**:
- Hot reload habilitado
- Debug symbols inclusos
- asserts habilitados
- Performance reduzida

### Profile

```bash
flutter build apk --profile
flutter build ios --profile
flutter run --profile
```

**Características**:
- Otimização parcial
- Métricas de performance disponíveis
- Sem hot reload
- Performance próxima da produção

### Release

```bash
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
```

**Características**:
- Otimização total
- Sem debug symbols
- Tree shaking
- Code obfuscation (opcional)
- Performance máxima

## Formatos de Build

### Android

| Formato | Comando | Uso |
|---------|---------|-----|
| APK | `flutter build apk` | Instalação direta |
| AAB | `flutter build appbundle` | Google Play |

### iOS

| Formato | Comando | Uso |
|---------|---------|-----|
| IPA | `flutter build ipa` | App Store / TestFlight |

## Configurações por Build

### android/build.gradle

```groovy
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.vcardsmart"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.debug // Substituir por release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    
    flavorDimensions "default"
    
    productFlavors {
        dev {
            dimension "default"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        staging {
            dimension "default"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
        }
        prod {
            dimension "default"
        }
    }
}
```

### ios/Runner.xcodeproj

```ruby
# Configurações de build
# Debug
# Profile
# Release
```

## Flavors

| Flavor | Sufixo | Uso |
|--------|--------|-----|
| dev | .dev | Desenvolvimento |
| staging | .staging | Homologação |
| prod | (nenhum) | Produção |

```bash
# Build com flavor
flutter build apk --flavor dev --target lib/main_dev.dart
flutter build apk --flavor staging --target lib/main_staging.dart
flutter build apk --flavor prod --target lib/main.dart
```

## Estrutura de Build

```
build/
├── android/
│   ├── apk/
│   │   └── release/
│   │       └── app-release.apk
│   └── app/
│       └── bundle/
│           └── release/
│               └── app-release.aab
├── ios/
│   └── ios/
│       └── build/
│           └── products/
│               └── Release-iphoneos/
├── artifacts/
│   ├── apk/
│   ├── aab/
│   └── ipa/
└── reports/
    ├── coverage/
    └── test/
```
