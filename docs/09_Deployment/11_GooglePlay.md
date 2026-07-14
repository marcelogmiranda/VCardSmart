# Google Play Store — VCardSmart

## Checklist de Publicação

### Ícone

- [ ] Ícone gerado (512x512 PNG)
- [ ] Ícone adapativo (Android 8+)
- [ ] Ícone em todas as densidades

### Screenshots

- [ ] Phone (16:9) — mínimo 2
- [ ] Tablet (16:9) — mínimo 2
- [ ] Chromebook — mínimo 1 (opcional)

### Feature Graphic

- [ ] Feature graphic (1024x500 PNG)
- [ ] Imagens promocionais

### Política de Privacidade

- [ ] URL da política de privacidade
- [ ] Política revisada e atualizada

### Classificação Indicativa

- [ ] Classificação etária preenchida
- [ ] Conteúdo programático declarado

### Data Safety

- [ ] Tipos de dados coletados
- [ ] Finalidade da coleta
- [ ] Compartilhamento com terceiros
- [ ] Práticas de segurança
- [ ] Processo de exclusão

### Permissões

- [ ] Permissões justificadas
- [ ] Descrição de cada permissão

### Release Notes

- [ ] Novidades da versão
- [ ] Correções de bugs
- [ ] Melhorias de performance

## Estrutura de Publicação

### Internal Testing

```yaml
track: internal
status: completed
fraction: 100
```

### Closed Testing

```yaml
track: alpha
status: inProgress
fraction: 10
```

### Open Testing

```yaml
track: beta
status: inProgress
fraction: 100
```

### Production

```yaml
track: production
status: completed
fraction: 100
rollout:
  status: inProgress
  fraction: 10
```

## Fastlane Config

### Fastfile

```ruby
default_platform(:android)

platform :android do
  desc "Build and deploy to Google Play Internal"
  lane :internal do
    gradle(task: "clean assembleRelease")
    upload_to_play_store(track: 'internal')
  end

  desc "Build and deploy to Google Play Beta"
  lane :beta do
    gradle(task: "clean assembleRelease")
    upload_to_play_store(track: 'beta')
  end

  desc "Build and deploy to Google Play Production"
  lane :production do
    gradle(task: "clean assembleRelease")
    upload_to_play_store(track: 'production', rollout: '0.1')
  end
end
```

## Metadados

### Estrutura

```
fastlane/metadata/android/
├── pt-BR/
│   ├── full_description.txt
│   ├── short_description.txt
│   ├── title.txt
│   ├── changelogs/
│   │   └── 1.txt
│   └── images/
│       ├── phoneScreenshots/
│       ├── sevenInchScreenshots/
│       ├── tenInchScreenshots/
│       └── featureGraphic.png
├── en-US/
│   └── ...
└── es-ES/
    └── ...
```

## Versionamento

```ruby
# android/app/build.gradle
android {
    defaultConfig {
        versionCode 1
        versionName "1.0.0"
    }
}
```

## Comandos Úteis

```bash
# Build para Google Play
flutter build appbundle --release

# Upload com Fastlane
cd android
bundle exec fastlane internal
bundle exec fastlane beta
bundle exec fastlane production

# Verificar metadata
bundle exec fastlane supply --track internal --validate_only
```
