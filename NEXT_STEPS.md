# Próximos Passos — VCardSmart

## Status Atual

- **Versão**: 1.0.0+1
- **Sprints completas**: 0-16 (todas)
- **Testes**: 432 passando
- **Coverage**: 88.1%
- **flutter analyze**: 0 issues
- **Docs**: 327 arquivos

## Para Publicar na Google Play

1. Criar keystore:
   ```bash
   keytool -genkey -v -keystore ~/.android/debug.keystore -alias vcardsmart -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Copiar `android/key.properties.example` → `android/key.properties` e preencher valores

3. Criar conta no [Play Console](https://play.google.com/console)

4. Criar app (com.vcardsmart.app)

5. Preencher store listing usando `docs/12_Marketing/06_GooglePlayListing.md`

6. Fazer upload do AAB:
   ```bash
   flutter build appbundle --release
   ```

7. Submeter para revisão

## Para Publicar na App Store

1. Criar conta no [Apple Developer](https://developer.apple.com)

2. Criar App ID (com.vcardsmart.app)

3. Criar provisioning profile

4. Configurar Xcode com signing

5. Preencher store listing usando `docs/12_Marketing/07_AppStoreListing.md`

6. Build e upload:
   ```bash
   flutter build ipa --release
   ```

7. Upload via Transporter ou Xcode

8. Submeter para revisão

## Configuração CI/CD

Para ativar auto-deploy, adicionar secrets no GitHub:

- `GOOGLE_PLAY_SERVICE_ACCOUNT` — JSON da service account do Play Console
- `APP_STORE_CONNECT_ISSUER_ID` — App Store Connect API issuer
- `APP_STORE_CONNECT_API_KEY_ID` — App Store Connect API key ID
- `APP_STORE_CONNECT_API_PRIVATE_KEY` — Chave privada API

## Pós-Release

- Monitorar crash reports (Sentry/Firebase Crashlytics)
- Monitorar reviews na loja
- Responder feedback
- Planejar v1.1.0

## Pendências Manuais

- [ ] Instalar Fastlane para deploy automatizado
- [ ] Verificar emulador Android
- [ ] Verificar simulador iOS
- [ ] Criar ícone do app (512x512 / 1024x1024)
- [ ] Tirar screenshots (1080x1920 / 1170x2532)
- [ ] Criar feature graphic (1024x500)
