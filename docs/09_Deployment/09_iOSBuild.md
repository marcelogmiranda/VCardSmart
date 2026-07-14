# Build iOS — VCardSmart

## Pré-requisitos

- macOS com Xcode 15+
- Apple Developer Account
- Certificados de assinatura
- Provisioning Profile

## Comandos

### IPA

```bash
# Debug
flutter build ios --debug

# Profile
flutter build ios --profile

# Release
flutter build ios --release

# Com flavor
flutter build ios --release --flavor prod
```

### Gerar IPA

```bash
# Build release
flutter build ios --release

# Gerar IPA para distribuição
flutter build ipa --release

# Com flavor
flutter build ipa --release --flavor prod
```

## Configurações

### ios/Runner.xcodeproj

```ruby
# Configurações de build
PRODUCT_BUNDLE_IDENTIFIER = com.vcardsmart
DEVELOPMENT_TEAM = YOUR_TEAM_ID
CODE_SIGN_STYLE = Automatic
IPHONEOS_DEPLOYMENT_TARGET = 12.0
```

### Podfile

```ruby
# ios/Podfile
platform :ios, '12.0'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_paths!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

## Assinatura

### Certificados

```bash
# Listar certificados
security find-identity -v -p codesigning

# Verificar certificado
openssl x509 -in certificate.pem -noout -dates
```

### Provisioning Profile

```bash
# Listar provisioning profiles
ls ~/Library/MobileDevice/Provisioning\ Profiles/

# Verificar provisioning profile
security cms -D -i profile.mobileprovision
```

### Configuração no Xcode

1. Abrir `ios/Runner.xcworkspace`
2. Selecionar target Runner
3. Configurar Signing & Capabilities
4. Selecionar Team
5. Configurar Bundle Identifier

## Estrutura de Build

```
build/
├── ios/
│   ├──iphoneos/
│   │   └── Runner.app
│   └── iphonesimulator/
│       └── Runner.app
└── ios/
    └── ipa/
        └── Runner.ipa
```

## Distribuição

### TestFlight

```bash
# Build para TestFlight
flutter build ipa --release

# Upload para TestFlight
# Usar Fastlane ou Xcode Organizer
```

### App Store

```bash
# Build para App Store
flutter build ipa --release

# Upload para App Store
# Usar Fastlane ou Xcode Organizer
```

## Verificação

```bash
# Verificar build
flutter build ios --release

# Verificar IPA
ls -la build/ios/ipa/

# Verificar tamanho
du -sh build/ios/ipa/Runner.ipa
```

## Troubleshooting

| Problema | Solução |
|----------|---------|
| CocoaPods error | `pod repo update` |
| Signing error | Verificar certificados no Xcode |
| Provisioning error | Verificar provisioning profiles |
| Build failed | `flutter clean && flutter pub get` |
