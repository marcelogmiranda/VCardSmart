# Fastlane — VCardSmart

## Instalação

```bash
# macOS
brew install fastlane

# Ruby gem
gem install fastlane

# Inicializar
cd ios
fastlane init

cd ../android
fastlane init
```

## Estrutura

```
fastlane/
├── Appfile
├── Fastfile
├── Gemfile
├── Pluginfile
├── metadata/
│   ├── android/
│   │   └── pt-BR/
│   └── ios/
│       └── pt-BR/
└── screenshots/
    ├── android/
    └── ios/
```

## Configuração

### Appfile (Android)

```ruby
# fastlane/Appfile
json_key_file("path/to/google-play-key.json")
package_name("com.vcardsmart")
```

### Appfile (iOS)

```ruby
# fastlane/Appfile
app_identifier("com.vcardsmart")
apple_id("your@apple.id")
team_id("YOUR_TEAM_ID")
```

### Fastfile

```ruby
# fastlane/Fastfile
default_platform(:multi)

platform :multi do
  desc "Build and test"
  lane :test do
    # Android
    gradle(task: "clean testReleaseUnitTest", project_dir: "android")
    
    # iOS
    scan(workspace: "ios/Runner.xcworkspace", scheme: "Runner")
  end

  desc "Deploy to Internal Testing"
  lane :internal do
    # Android
    gradle(task: "clean assembleRelease", project_dir: "android")
    upload_to_play_store(track: 'internal')
    
    # iOS
    build_ios_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_testflight(skip_waiting_for_build_processing: true)
  end

  desc "Deploy to Beta"
  lane :beta do
    # Android
    gradle(task: "clean assembleRelease", project_dir: "android")
    upload_to_play_store(track: 'beta')
    
    # iOS
    build_ios_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_testflight(skip_waiting_for_build_processing: true)
  end

  desc "Deploy to Production"
  lane :production do
    # Android
    gradle(task: "clean assembleRelease", project_dir: "android")
    upload_to_play_store(track: 'production', rollout: '0.1')
    
    # iOS
    build_ios_app(
      workspace: "ios/Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_app_store(force: true)
  end

  desc "Upload metadata"
  lane :upload_metadata do
    # Android
    upload_to_play_store(skip_upload_apk: true, skip_upload_aab: true)
    
    # iOS
    deliver(skip_binary_upload: true)
  end

  desc "Upload screenshots"
  lane :upload_screenshots do
    # Android
    upload_to_play_store(skip_upload_apk: true, skip_upload_aab: true, skip_upload_changelogs: true)
    
    # iOS
    deliver(skip_binary_upload: true, skip_metadata: true)
  end
end
```

### Gemfile

```ruby
# Gemfile
source "https://rubygems.org"

gem "fastlane"
```

## Comandos

```bash
# Instalar dependências
bundle install

# Rodar lanes
bundle exec fastlane test
bundle exec fastlane internal
bundle exec fastlane beta
bundle exec fastlane production
bundle exec fastlane upload_metadata
bundle exec fastlane upload_screenshots

# Listar lanes
bundle exec fastlane lanes
```

## CI/CD Integration

### GitHub Actions

```yaml
- name: Deploy to Google Play
  uses: ruby/setup-ruby@v1
  with:
    ruby-version: '3.2'
    bundler-cache: true

- name: Fastlane Internal
  run: bundle exec fastlane internal
  env:
    GOOGLE_PLAY_JSON_KEY: ${{ secrets.GOOGLE_PLAY_JSON_KEY }}
```

## Plugins

```ruby
# Pluginfile
gem 'fastlane-plugin-firebase_app_distribution'
gem 'fastlane-plugin-versioning'
```

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Bundle install failed | `bundle update` |
| Fastlane not found | `gem install fastlane` |
| Google Play auth error | Verificar JSON key |
| iOS signing error | Verificar certificados |
