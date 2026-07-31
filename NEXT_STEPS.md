# Proximos Passos — VCardSmart

## Status Atual

- **Versao**: 1.0.0+4
- **Branch**: main
- **Ultimo commit**: 224c697
- **Flutter**: 3.44.7 stable
- **Xcode**: 26.6
- **flutter analyze**: 0 erros
- **flutter test**: 495 passando + 23 goldens falham isoladas (pixel diff ~0.06%, ambientais)
- **Build iOS IPA**: 33.4MB (`app/build/ios/ipa/VCardSmart.ipa`) — Version 1.0.0, Build 4
- **Build iOS Simulator**: OK
- **Status App Store**: **In Review** — submissao 1.0.0 (build 1) rejeitada (Guideline 5.6, features enganosas); corrigido, build 4 enviado via Transporter com notas de revisao e re-submetido em 31/07/2026

## Commits Recentes

- `224c697` — App Store resubmission v1.0.0+4 — features reais (QR/NFC/seguranca)
- `976321e` — chore: add certificates folder to gitignore
- `7dd16b3` — feat: Google Play Store v1.0.0+3 - teste fechado
- `c23e8ce` — AdMob IDs reais (banner, interstitial, app ID)
- `770c6c3` — docs: screenshots e feature graphic
- `4369024` — assets: feature graphic + screenshots PNG
- `fb5f876` — vCard: instagram, foto, fix LinkedIn/Website
- `3c9ac8b` — docs: status update
- `37f265b` — ios/build no gitignore
- `a6d616b` — Flutter 3.44.7 upgrade
- `36005cd` — v1.0 UX improvements

## O Que Foi Feito Nesta Sessao

1. **App Store v1.0.0 (build 1) rejeitada** — Guideline 5.6 (features enganosas)
2. **Auditoria de features** — identificados 6 achados; corrigidos 4 criticos
3. **QR scan salva contato** — botao "Salvar contato" no dialog Perfil Encontrado
4. **NFC receive salva contato** — botao "Salvar contato" no dialog Perfil Recebido
5. **Seguranca real** — sessao de autenticacao real, lock no router (redirect /auth), PIN em secure storage, biometria com isDeviceSupported, toggle PIN wired nas settings
6. **ImportDialog real** — rotas reais /qr/scan e /nfc/receive + colar vCard
7. **Removido AuthGuard** (dead code); adicionadas rotas /auth e /pin-setup
8. **Testes** — novos: auth_service, auth_redirect; atualizados security/settings/Qr/Nfc/ImportDialog (495 passando)

## Para Testar

```bash
cd app
PATH=/usr/bin:$PATH flutter analyze
PATH=/usr/bin:$PATH flutter test
PATH=/usr/bin:$PATH flutter build ipa --release
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
6. ~~Upload via Transporter~~ ✅ (build 4 / 1.0.0)
7. ~~Preencher listing no App Store Connect~~ ✅
8. ~~Re-submeter para revisao~~ ✅ **In Review** (build 4 / 1.0.0)
9. ~~Incluir notas de revisao~~ ✅ QR/NFC/seguranca agora funcionam de verdade

## Pendencias Antes de Publicar

- [ ] (App Store) Aguardar veredito do re-teste (In Review) → release para producao
- [ ] (Google Play) Aguardar 14 dias de teste fechado → solicitar producao
- [ ] Achado 5 (baixo): mismatch QR vCard × importFromQR JSON (latente, sem conflito)
- [ ] Achado 6 (baixo): interstitial nunca exibido / box de historico nao usado

## URLs Importantes

- **Suporte Apple**: https://sites.google.com/unigex.com.br/suporte/in%C3%ADcio
- **Suporte Google Play**: https://sites.google.com/unigex.com.br/suporte/in%C3%ADcio

## Assets Disponiveis

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `app-release.aab` | 64.1MB | Google Play Store |
| `VCardSmart.ipa` | 33.4MB | App Store (1.0.0 build 4) |
| `feature_graphic_1024x500.png` | ~780KB | Google Play feature graphic |
| `01_home_profile.png` | ~299KB | Screenshot — Home |
| `02_qr_code.png` | ~220KB | Screenshot — QR Code |
| `03_dark_theme.png` | ~218KB | Screenshot — Tema Escuro |

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
