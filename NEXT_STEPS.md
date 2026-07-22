# Proximos Passos — VCardSmart

## Status Atual

- **Versao**: 1.0.0+1
- **Branch**: main
- **Ultimo commit**: 37f265b
- **Flutter**: 3.44.7 stable
- **Xcode**: 26.6
- **flutter analyze**: 0 issues (only info-level warnings)
- **flutter test**: 492+ pass, 0 fail
- **Android APK**: 35.0MB (`app/build/app/outputs/flutter-apk/app-release.apk`)
- **Android AAB**: 56MB (`app/build/app/outputs/bundle/release/app-release.aab`)
- **Build iOS Simulator**: OK (Runner.app)

## Commits Recentes

- `37f265b` — add ios/build/ to .gitignore
- `a6d616b` — Flutter 3.44.7 upgrade, iOS simulator build support
- `36005cd` — v1.0 UX improvements (QR page, NFC fix, share, bottom nav)
- `665867f` — complete .gitignore, temp file cleanup
- `1913547` — test fixes, signing, ProGuard, Fastlane, marketing assets
- `fee11a4` — root .gitignore

## O Que Foi Corrigido Nesta Sessao

1. **Flutter 3.32.8 → 3.44.7** — upgrade completo, compatibilidade com Xcode 26.6
2. **iOS Simulator build** — xattr fix no Podfile, Swift Package Manager desabilitado
3. **Codigos restaurados** — stubs temporarios removidos, dependencias restauradas

## Para Testar

```bash
cd app

# Android (emulador)
PATH=/usr/bin:$PATH flutter run

# iOS (simulador)
PATH=/usr/bin:$PATH flutter run -d "iPhone 16"

# Analise
PATH=/usr/bin:$PATH flutter analyze

# Testes
PATH=/usr/bin:$PATH flutter test
```

## Para Publicar na Google Play

1. ~~Criar keystore~~ ✅ (`android/app/release-keystore.jks`)
2. ~~Configurar signing~~ ✅ (`android/key.properties`)
3. Criar conta no [Play Console](https://play.google.com/console)
4. Criar app (com.vcardsmart.app)
5. Preencher store listing usando `docs/12_Marketing/06_GooglePlayListing.md`
6. **Criar feature graphic** — abrir `assets/feature_graphic.html` no browser e capturar 1024x500 PNG
7. **Tirar screenshots** — abrir templates em `assets/screenshots/` no browser
8. ~~Build AAB~~ ✅ (`flutter build appbundle --release`)
9. Upload via Fastlane ou Play Console
10. Submeter para revisao

## Para Publicar na App Store

1. Criar conta no [Apple Developer](https://developer.apple.com)
2. Criar App ID (com.vcardsmart.app)
3. Criar provisioning profile
4. Configurar Xcode com signing
5. Build:
   ```bash
   flutter build ipa --release
   ```
6. Upload via Transporter ou Xcode
7. Submeter para revisao

## Pendencias Antes de Publicar

- [ ] **Substituir AdMob placeholder IDs** — `lib/core/ads/ad_units.dart` tem IDs de teste (`ca-app-pub-XXX/YYY`)
- [ ] **Criar feature graphic** — template em `assets/feature_graphic.html` (1024x500)
- [ ] **Tirar screenshots** — templates em `assets/screenshots/01-05` (1080x1920 / 1170x2532)
- [ ] **Testar em dispositivo fisico Android** — APK disponivel
- [ ] **Testar em dispositivo fisico iOS** — precisa Apple Developer account + signing
- [ ] **Criar listing Google Play** — usando docs/12_Marketing/06_GooglePlayListing.md

## Ambiente Local

- Flutter: 3.44.7 stable (Dart 3.12.2, DevTools 2.57.0)
- Xcode: 26.6 (Build 17F113)
- iOS Simulator: iPhone 16 (iOS 26.5)
- CocoaPods: 1.17.0
- Homebrew: 6.0.11 (em /opt/homebrew)
- Fastlane: 2.237.0

## Comandos Uteis

```bash
# iOS pod install
cd app/ios && PATH="/usr/bin:/usr/sbin:/bin:/sbin:/opt/homebrew/bin:$PATH" pod install

# iOS Simulator build
PATH=/usr/bin:$PATH flutter build ios --simulator

# iOS device build (precisa signing)
PATH=/usr/bin:$PATH flutter build ios --no-codesign

# Android release APK
PATH=/usr/bin:$PATH flutter build apk --release

# Android release AAB
PATH=/usr/bin:$PATH flutter build appbundle --release

# Limpar build
flutter clean
```
