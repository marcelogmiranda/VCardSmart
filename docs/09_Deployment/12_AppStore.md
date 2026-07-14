# Apple App Store — VCardSmart

## Checklist de Publicação

### App Icon

- [ ] Ícone gerado (1024x1024 PNG)
- [ ] Sem transparência
- [ ] Sem arredondamento (App Store aplica automaticamente)

### Screenshots

- [ ] iPhone 6.7" (iPhone 15 Pro Max)
- [ ] iPhone 6.5" (iPhone 14 Plus)
- [ ] iPhone 5.5" (iPhone 8 Plus)
- [ ] iPad Pro 12.9" (6th gen)
- [ ] iPad Pro 12.9" (2nd gen)

### Descrição

- [ ] Descrição completa (máx. 4000 caracteres)
- [ ] Descrição curta (máx. 170 caracteres)

### Keywords

- [ ] Keywords (máx. 100 caracteres)
- [ ] Separados por vírgula

### Privacy Nutrition Labels

- [ ] Dados coletados declarados
- [ ] Finalidade de cada dado
- [ ] Vinculação a identidade

### App Privacy

- [ ] Práticas de privacidade declaradas
- [ ] URL da política de privacidade

### App Review Information

- [ ] Notas de revisão
- [ ] Informações de contato
- [ ] Demonstração (se necessário)

### Release Notes

- [ ] Novidades da versão
- [ ] Correções de bugs

## Estrutura de Publicação

### TestFlight

```ruby
# Fastlane
lane :testflight do
  build_ios_app(
    workspace: "ios/Runner.xcworkspace",
    scheme: "Runner",
    export_method: "app-store"
  )
  upload_to_testflight(
    skip_waiting_for_build_processing: true
  )
end
```

### App Store

```ruby
# Fastlane
lane :app_store do
  build_ios_app(
    workspace: "ios/Runner.xcworkspace",
    scheme: "Runner",
    export_method: "app-store"
  )
  upload_to_app_store(
    force: true,
    skip_screenshots: false,
    skip_metadata: false
  )
end
```

## Fastlane Config

### Fastfile

```ruby
default_platform(:ios)

platform :ios do
  desc "Build and deploy to TestFlight"
  lane :testflight do
    build_ios_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_testflight(
      skip_waiting_for_build_processing: true
    )
  end

  desc "Build and deploy to App Store"
  lane :app_store do
    build_ios_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_app_store(
      force: true
    )
  end
end
```

## Metadados

### Estrutura

```
fastlane/metadata/ios/
├── pt-BR/
│   ├── name.txt
│   ├── subtitle.txt
│   ├── description.txt
│   ├── keywords.txt
│   ├── release_notes.txt
│   ├── privacy_url.txt
│   └── screenshots/
│       ├── iPhone6.7/
│       ├── iPhone6.5/
│       ├── iPhone5.5/
│       └── iPadPro12.9/
├── en-US/
│   └── ...
└── es-ES/
    └── ...
```

## Comandos Úteis

```bash
# Build para App Store
flutter build ipa --release

# Upload com Fastlane
cd ios
bundle exec fastlane testflight
bundle exec fastlane app_store

# Verificar metadata
bundle exec fastlane deliver --validate_only
```

## Privacy Labels

```yaml
data_collection:
  - type: name
    purpose: app_functionality
  - type: email
    purpose: app_functionality
  - type: phone
    purpose: app_functionality
  - type: contacts
    purpose: app_functionality
    optional: true

data_sharing:
  - type: analytics
    third_party: google
    purpose: analytics
```

## Versionamento

```ruby
# ios/Runner.xcodeproj
MARKETING_VERSION = 1.0.0
CURRENT_PROJECT_VERSION = 1
```
