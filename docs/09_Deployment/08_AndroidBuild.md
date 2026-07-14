# Build Android — VCardSmart

## Comandos

### APK

```bash
# Debug
flutter build apk --debug

# Profile
flutter build apk --profile

# Release
flutter build apk --release

# Com flavor
flutter build apk --release --flavor prod
```

### AAB (Android App Bundle)

```bash
# Release
flutter build appbundle --release

# Com flavor
flutter build appbundle --release --flavor prod
```

## Assinatura

### Criar Keystore

```bash
keytool -genkey -v \
  -keystore vcardsmart-release.keystore \
  -alias vcardsmart \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

### Configurar Assinatura

```groovy
// android/app/build.gradle
android {
    signingConfigs {
        release {
            keyAlias 'vcardsmart'
            keyPassword 'YOUR_KEY_PASSWORD'
            storeFile file('vcardsmart-release.keystore')
            storePassword 'YOUR_STORE_PASSWORD'
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### Gradle Properties

```properties
# android/gradle.properties
android.useAndroidX=true
android.enableJetifier=true
org.gradle.jvmargs=-Xmx4G
org.gradle.parallel=true
org.gradle.caching=true
```

## Configurações

### android/app/build.gradle

```groovy
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.vcardsmart"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        multiDexEnabled true
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
        
        debug {
            signingConfig signingConfigs.debug
            minifyEnabled false
        }
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = '1.8'
    }
}
```

### ProGuard Rules

```proguard
# android/app/proguard-rules.pro
-keep class com.vcardsmart.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
```

## Estrutura de Build

```
build/
├── android/
│   ├── apk/
│   │   ├── debug/
│   │   │   └── app-debug.apk
│   │   ├── profile/
│   │   │   └── app-profile.apk
│   │   └── release/
│   │       └── app-release.apk
│   └── app/
│       └── bundle/
│           └── release/
│               └── app-release.aab
```

## Verificação

```bash
# Verificar APK
flutter build apk --release
ls -la build/app/outputs/flutter-apk/

# Verificar AAB
flutter build appbundle --release
ls -la build/app/outputs/bundle/release/

# Verificar tamanho
du -sh build/app/outputs/flutter-apk/app-release.apk
```

## Otimizações

### Tamanho do APK

```bash
# Build com split per ABI
flutter build apk --split-per-abi --release

# Resultado:
# app-armeabi-v7a-release.apk
# app-arm64-v8a-release.apk
# app-x86_64-release.apk
```

### Performance

```bash
# Build com obfuscation
flutter build apk --obfuscate --split-debug-info=build/debug-info --release
```
