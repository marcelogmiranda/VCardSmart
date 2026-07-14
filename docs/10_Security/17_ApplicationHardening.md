# Hardening do Aplicativo — VCardSmart

## Visão Geral

Técnicas de fortalecimento do aplicativo contra engenharia reversa e ataques.

## Configurações de Build

### Release

```yaml
# android/app/build.gradle
android {
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### iOS

```ruby
# ios/Runner.xcodeproj
# Strip debug symbols
STRIP_INSTALLED_PRODUCT = YES
# Strip Swift symbols
STRIP_SWIFT_SYMBOLS = YES
```

## Obfuscation

### Dart

```bash
# Build com obfuscation
flutter build apk --obfuscate --split-debug-info=build/debug-info --release
flutter build ios --obfuscate --split-debug-info=build/debug-info --release
```

### Configuração

```yaml
# android/app/build.gradle
android {
    buildTypes {
        release {
            // ...
            crunchPngs false
        }
    }
    
    // ...
}
```

## Minification

### Android (R8)

```proguard
# android/app/proguard-rules.pro

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Hive
-keep class com.vcardsmart.** { *; }
-keep class hive.** { *; }

# Local Auth
-keep class com.dexterous.** { *; }

# NFC
-keep class com.vcardsmart.nfc.** { *; }
```

### iOS

```ruby
# ios/Podfile
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

## Sem Logs

### Debug

```dart
// ❌ ERRADO - Em produção
print('Perfil: ${profile.name}');
debugPrint('Erro: $error');
log('Debug: $data');

// ✅ CORRETO - Apenas em debug
if (kDebugMode) {
  print('Perfil: ${profile.name}');
}
```

### Configuração

```dart
// lib/core/utils/logger.dart
class Logger {
  static void log(String message) {
    if (kDebugMode) {
      print('[VCardSmart] $message');
    }
  }
  
  static void error(String message, [dynamic error]) {
    if (kDebugMode) {
      print('[VCardSmart ERROR] $message');
      if (error != null) {
        print('[VCardSmart ERROR] $error');
      }
    }
  }
}
```

## Sem Debug

### Configuração

```dart
// lib/main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Desabilitar debug em produção
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  
  runApp(const VCardSmartApp());
}
```

## Sem DevTools

### Configuração

```dart
// lib/main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Desabilitar DevTools em produção
  if (kReleaseMode) {
    // Desabilitar inspect
    debugInspect = false;
  }
  
  runApp(const VCardSmartApp());
}
```

## Segurança de Rede

### Certificate Pinning

```dart
// Não aplicável - App offline
// Dados nunca trafegam pela rede
```

### SSL

```dart
// Não aplicável - App offline
// Única exceção: Google Mobile Ads
```

## Proteção contra Debug

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<application
    android:debuggable="false"
    ...>
```

### iOS

```ruby
# ios/Runner.xcodeproj
# Disable debugger
DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym"
```

## Segurança de Dados

### Em Repouso

```dart
// Hive com AES-256
final box = await Hive.openBox('profiles', cipher: cipher);
```

### Em Trânsito

```dart
// Não aplicável - App offline
```

## Checklist de Hardening

### Build

- [ ] minifyEnabled true
- [ ] shrinkResources true
- [ ] ProGuard configurado
- [ ] Obfuscation habilitado
- [ ] Debug symbols removidos

### Código

- [ ] Sem logs em produção
- [ ] Sem prints em produção
- [ ] Sem debug em produção
- [ ] Sem DevTools em produção
- [ ] Variáveis sensíveis em Secure Storage

### Dados

- [ ] Hive criptografado
- [ ] Secure Storage para secrets
- [ ] Sem dados em logs
- [ ] Sem dados em cache

## Métricas

| Métrica | Meta |
|---------|------|
| Tamanho do APK | < 20MB |
| Obfuscation | Habilitado |
| Minification | Habilitado |
| Logs | 0 em produção |
| Debug | Desabilitado |
