# Proximos Passos — VCardSmart

## Status Atual

- **Versao**: 1.0.0+1
- **Branch**: main
- **Ultimo commit**: c23e8ce
- **Flutter**: 3.44.7 stable
- **Xcode**: 26.6
- **flutter analyze**: 0 erros (apenas warnings info)
- **flutter test**: 134+ passando (profile, contacts, QR, home)
- **Android APK**: 70.1MB (`app/build/app/outputs/flutter-apk/app-release.apk`)
- **Android AAB**: 64.1MB (`app/build/app/outputs/bundle/release/app-release.aab`)
- **Build iOS Simulator**: OK

## Commits Recentes

- `c23e8ce` — AdMob IDs reais (banner, interstitial, app ID)
- `770c6c3` — docs: screenshots e feature graphic
- `4369024` — assets: feature graphic + screenshots PNG
- `fb5f876` — vCard: instagram, foto, fix LinkedIn/Website
- `3c9ac8b` — docs: status update
- `37f265b` — ios/build no gitignore
- `a6d616b` — Flutter 3.44.7 upgrade
- `36005cd` — v1.0 UX improvements

## O Que Foi Feito Nesta Sessao

1. **Flutter 3.32.8 → 3.44.7** — upgrade completo
2. **iOS Simulator build** — xattr fix, Swift Package Manager desabilitado
3. **vCard campos** — adicionado instagram, foto (camera/galeria), fix LinkedIn/Website separados
4. **AdMob** — IDs reais configurados (banner + interstitial)
5. **Marketing assets** — feature graphic e screenshots capturados
6. **AAB** — cmdline-tools instalado, AAB gerado com sucesso

## Para Testar

```bash
cd app
PATH=/usr/bin:$PATH flutter analyze
PATH=/usr/bin:$PATH flutter test
PATH=/usr/bin:$PATH flutter build apk --release
PATH=/usr/bin:$PATH flutter build appbundle --release
```

## Para Publicar na Google Play

1. ~~Criar keystore~~ ✅ (`android/app/release-keystore.jks`)
2. ~~Configurar signing~~ ✅ (`android/key.properties`)
3. ~~Criar conta no Play Console~~ ✅ (mgm.consultoria50@gmail.com)
4. ~~Criar app (com.vcardsmart.app)~~ ✅
5. ~~Upload AAB v1.0.0+3~~ ✅ (teste fechado com 14 testadores)
6. ~~Preencher store listing~~ ✅
7. ~~Upload assets (icon, feature graphic, screenshots)~~ ✅
8. ~~Adicionar permissao AD_ID~~ ✅
9. Aguardar 14 dias de teste fechado
10. Solicitar acesso a producao

## Para Publicar na App Store

1. ~~Criar conta no [Apple Developer](https://developer.apple.com) ($99/ano)~~ ✅
2. ~~Criar App ID (com.vcardsmart.app)~~ ✅
3. ~~Criar provisioning profile~~ ✅
4. ~~Configurar Xcode com signing~~ ✅
5. ~~Build: `flutter build ipa --release`~~ ✅
6. ~~Upload via Transporter~~ ✅ (aguardando processamento)
7. Preencher listing no App Store Connect
8. Submeter para revisao

## URLs Importantes

- **Suporte Apple**: https://sites.google.com/unigex.com.br/suporte/in%C3%ADcio
- **Suporte Google Play**: https://sites.google.com/unigex.com.br/suporte/in%C3%ADcio

## Assets Disponiveis

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `app-release.apk` | 70.1MB | Teste manual + Play Console |
| `app-release.aab` | 64.1MB | Google Play Store |
| `feature_graphic_1024x500.png` | ~780KB | Google Play feature graphic |
| `01_home_profile.png` | ~224KB | Screenshot — Home |
| `02_qr_code.png` | ~199KB | Screenshot — QR Code |
| `03_dark_theme.png` | ~186KB | Screenshot — Tema Escuro |

## Pendencias Antes de Publicar

- [ ] Criar conta no Play Console
- [ ] Criar app (com.vcardsmart.app) no Play Console
- [ ] Criar conta de servico → baixar chave JSON
- [ ] Configurar Fastlane com chave JSON
- [ ] Preencher store listing
- [ ] Upload AAB + assets
- [ ] Submeter para revisao
- [ ] (Opcional) Criar Apple Developer account → publicar iOS

## Ambiente Local

- Flutter: 3.44.7 stable (Dart 3.12.2)
- Xcode: 26.6 (Build 17F113)
- iOS Simulator: iPhone 16 (iOS 26.5)
- CocoaPods: 1.17.0
- Fastlane: 2.237.0
- Android SDK: 34.0.0
- cmdline-tools: latest (instalado)

## Comandos Uteis

```bash
# iOS pod install
cd app/ios && PATH="/usr/bin:/usr/sbin:/bin:/sbin:/opt/homebrew/bin:$PATH" pod install

# iOS Simulator build
PATH=/usr/bin:$PATH flutter build ios --simulator

# Android release APK
PATH=/usr/bin:$PATH flutter build apk --release

# Android release AAB
PATH=/usr/bin:$PATH flutter build appbundle --release

# Deploy via Fastlane (precisa chave JSON)
cd app && fastlane android deploy_play_store

# Limpar build
flutter clean
```
