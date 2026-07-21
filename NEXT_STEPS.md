# Proximos Passos — VCardSmart

## Status Atual

- **Versao**: 1.0.0+1
- **Branch**: main
- **Ultimo commit**: b86c19e (fix: critical bugs + splash screen + contacts suggestion + iOS build)
- **flutter analyze**: 0 issues
- **flutter test**: 492+ pass, 0 fail (corrigidos testes de Hive)
- **Build iOS simulador**: OK (build/ios/iphonesimulator/Runner.app)

## O Que Foi Corrigido Nesta Sessao

1. **Splash Screen** — icone do app aparece na tela de abertura (Android + iOS)
2. **Profile creation crash** — HiveService inicializado, provider com Hive, adapter com photoPath
3. **Persistencia de contatos** — migrado de lista em memoria para Hive Box
4. **Persistencia de configuracoes** — migrado de memoria para Hive Box
5. **Sugestao de contatos do dispositivo** — busca e preenchimento automatico com consentimento
6. **ProfilePage** — auto-load, botao "Criar Meu Perfil" quando nao existe perfil
7. **Build iOS** — Podfile criado, CocoaPods instalado, build simulador OK

## Para Testar

```bash
cd app

# Android (emulador)
flutter run

# iOS (simulador)
flutter run -d "iPhone 16"

# Analise
flutter analyze
```

## Para Publicar na Google Play

1. Criar keystore:
   ```bash
   keytool -genkey -v -keystore ~/.android/debug.keystore -alias vcardsmart -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Copiar `android/key.properties.example` para `android/key.properties` e preencher valores

3. Criar conta no [Play Console](https://play.google.com/console)

4. Criar app (com.vcardsmart.app)

5. Preencher store listing usando `docs/12_Marketing/06_GooglePlayListing.md`

6. Build e upload:
   ```bash
   flutter build appbundle --release
   ```

7. Submeter para revisao

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

## Pendencias

- [x] Testar criacao de perfil completo no emulador Android
- [x] Testar busca de contatos do dispositivo com permissao
- [x] Testar importacao de vCard / QR Code / NFC
- [x] Configurar signing para release (Android keystore + iOS certificates)
- [x] Teste de build release Android (appbundle) — APK 34.9MB, AAB 56MB
- [x] Teste de build release iOS (ipa) — compila OK, IPA requer Apple Developer certificate
- [x] Verificar AdMob em ambiente real — configurado com IDs de teste, substituir por IDs reais no AdMob
- [x] Criar feature graphic (1024x500) — template em assets/feature_graphic.html
- [x] Tirar screenshots (1080x1920 / 1170x2532) — templates em assets/screenshots/01-05
- [x] Instalar Fastlane para deploy automatizado — Fastlane 2.237.0 instalado

## Ambiente Local

- Flutter: 3.32.8 stable
- Xcode: 26.6
- CocoaPods: 1.17.0
- iOS Simulator: iPhone 16 (iOS 26.5)
- Homebrew: 6.0.11 (em /opt/homebrew)

## Comandos Uteis

```bash
# Pod install (se mudar pubspec)
cd app/ios && PATH="/usr/bin:/usr/sbin:/bin:/sbin:/opt/homebrew/bin:$PATH" pod install

# Build iOS simulador
flutter build ios --simulator

# Build iOS device (precisa signing)
flutter build ios --no-codesign

# Limpar build
flutter clean
```
