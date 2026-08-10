# VCardSmart — Contexto do Projeto

App Flutter de cartões de visita digitais (vCard/QR/NFC). Fluxo atual: submissão à App Store.

## Build / Device
- Sempre prefixar comandos flutter com: `export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"`
- iPhone físico: "iPhone de Marcelo" (iPhone 14, iOS 26.5.2). Identificadores devicectl:
  - UUID legado: `00008110-001468600241401E`
  - CoreDevice atual: `D9CA6E3D-7783-5BC7-B545-498B0D98BC68`
- Install (overwrite) preserva dados Hive. `uninstall` apaga tudo (foi causa da "perda" de perfil anterior).
- Launch: `xcrun devicectl device process launch --device <id> com.vcardsmart.app`
  - Erro `FBSOpenApplicationServiceErrorDomain RequestDenied/Locked`: aparelho bloqueado; tocar no ícone.
- Assinatura App Store: cert `Apple Distribution: Marcelo Miranda (7775YGF9CJ)` já presente.
- Release build device: `flutter build ios --release`
- IPA App Store: `flutter build ipa --release` → `app/build/ios/ipa/VCardSmart.ipa` (subir via Transporter)

## Android
- Aparelho de teste: Redmi Note 8 (modelo `ginkgo`, Android 10/API 29, MIUI 12). ID adb: `11ae045e`.
  - `adb` em: `/Users/mmiranda/Library/Android/sdk/platform-tools`
  - Build Android release já assinado: `android/key.properties` + `release-keystore.jks`.
  - Compile usa Java 11; build APK debug: `flutter build apk --debug`.
- MIUI 12 bloqueia instalação via USB: ao instalar, o Security Center mostra "Instalar este app via USB?" com botão "Recusar (5)" (auto-cancela em 5s). Workaround: durante `adb install`, monitorar foco com `dumpsys window | grep AdbInstallActivity` e tocar no botão "Instalar" (coordenadas ~300,2060) via `input tap`.
- OneDrive trava o cache Gradle (`app/android/.gradle`). `app/android/.gradle` agora é symlink para pasta local (mesmo esquema do `build/`). Não recriar como pasta real dentro do OneDrive.

## Testes
- Suíte não-golden: `flutter test test/core test/features` → verde (415 testes).
- `test/golden/` tem ~27 falhas pré-existentes (AppAvatar etc.), não relacionadas a mudanças atuais.
- `flutter analyze` → No issues found.
- Bug corrigido (10/08): no aparelho lento, o `context.push` do go_router NUNCA resolvia após o PIN (redirect durante o pop "orfanava" o completer) → o app travava no onboarding. Fix: a conclusão do setup (`markSecurityAsked` + `checkAuth` + navegação) agora roda direto na página do PIN (`security_setup_completion.dart`), sem depender do resultado do push. Reprodução em `test/features/security/presentation/repro_slow_device_test.dart` (delays 0/20/80/150ms). Validação no Redmi: setup → PIN → auth → desbloqueio → Home, tudo OK.
- Fix layout (10/08): `PinInput` de 6 dígitos (432dp) estourava 103px no Redmi (tela ~392dp lógicos). Envolvido em `FittedBox(scaleDown)` — banner de overflow sumiu no device.
- **IMPORTANTE**: o hash do PIN fica no `flutter_secure_storage` (Android: EncryptedSharedPreferences + Android Keystore), NÃO no Hive. `pm clear`/`uninstall` destrói o PIN de forma irrecuperável (a chave do Keystore se perde) — backup de `app_flutter/` não preserva PIN.
- Recuperação de PIN (10/08): se os settings dizem `pinEnabled=true` mas não existe hash de PIN (e sem biometria) — ex.: dados perdidos após restore/update — o `checkAuth` corrige o estado (`updatePin(false)`) e reabre o onboarding para novo cadastro, em vez de travar na tela de auth. `hasPin()`/biometria com erro são tratados como "sem PIN". Testes em `security_flow_integration_test.dart` (grupo "PIN storage recovery").
- Fix foto (10/08): `image_picker` guardava só o path do cache Android (`/data/user/0/.../cache/`), que o SO/limpador pode apagar → selfie "sumia". Agora `_pickImage` (`profile_form.dart`) copia a foto para o diretório persistente (`.../documents/photos/`) via `ImageUtils.savePhotoLocally` antes de salvar o path. Aguarda validação no Redmi.
- Usabilidade (10/08): unificados os cards "Meu QR Code" + "Compartilhar" do Home em um único card (mesma rota `/qr/share` com guard de perfil); removido widget morto `photo_picker.dart`.
- **Release Android crashava no Redmi (10/08)**: `VM snapshot invalid` + SIGSEGV no `FlutterJNI.performNativeAttach`. Causa: Android 10/MIUI carregava `libflutter.so` direto do APK e falhava (bug conhecido de Xiaomi; `lib/arm64` não era extraído). Fix: `android:extractNativeLibs="true"` no `<application>` do AndroidManifest.xml. Release validado no Redmi: onboarding → Home → card unificado → criação de perfil → QR → cold start estáveis.
- **IPA (10/08) RESOLVIDO**: as credenciais de distribuição sempre estiveram em `certificates/` no projeto (`distribution.cer` + `VCardSmart_App_Store.mobileprovision`) mas **não estavam instaladas** no keychain/Profiles. A chave privada já estava no keychain. Fix: `security add-certificates certificates/distribution.cer` + copiar o `.mobileprovision` para `~/Library/MobileDevice/Provisioning Profiles/<UUID>.mobileprovision` (UUID `c21b48c2-8486-47bc-a916-8308b0bd8e22`). Resultado: identidade `Apple Distribution: Marcelo Miranda (7775YGF9CJ)` ativa e `flutter build ipa --release` → `build/ios/ipa/VCardSmart.ipa` OK.

## Versões publicadas
- **1.0.0 (8)** — primeira versão; AAB enviado à Google Play (10/08).
- **1.0.1 (9)** — build iOS em TestFlight (testes, já em andamento).
- **1.0.2 (10)** — **atual** no pubspec (10/08); maior que Play (8) e TestFlight (9).
- Status iOS (10/08): **IPA 1.0.2/10 subido ao App Store Connect** (Transporter) pelo usuário.
- Status Android (10/08): **AAB da Play continua em 1.0.0/8**; Android **não será recompilado agora** (fica em testes).
- **Política de versão**: toda nova build (Play e iOS) deve subir **a mesma numeração** (`pubspec.yaml`) para facilitar auditoria — ex.: próximo upload Android deve ser 1.0.2/10, idêntico ao iOS já publicado.

## Pendências (próxima interação)
1. **Android: compilar AAB 1.0.2/10** (mesma numeração do iOS já publicado) e reenviar à Play Console para substituir o 1.0.0/8. Antes: validar no Redmi o que falta — selfie (fix da foto — câmera manual), NFC, contatos, ads.
2. **iOS: confirmar 1.0.2/10 no TestFlight** (processando/liberado no App Store Connect) e validar visualmente splash + fluxo completo no device.
3. Contatos ("Preencher do dispositivo"): melhorado (permissão no foco + listar contatos), aguarda revalidação no aparelho.
4. Nota: ao limpar dados do Redmi para testar first-run, backup via `run-as tar` (veja `/var/folders/.../opencode/vcardsmart_release_prebackup.tar`) e restore via `run-as cp`; dados do perfil foram restaurados. O PIN antigo NÃO é recuperável — é preciso re-cadastrar.

## Histórico de Commits (recente)
- `76cbfd9` feat: add facebook, x and generic social link fields to profile
- `578d4a7` fix: route security setup flow correctly and add integration tests
- `9f77f91` feat: redesigned security onboarding and configurable lock (v1.0.0+8)
- `3ffc72b` fix: upgrade flutter_contacts to 2.3.1 (v1.0.0+7)
- `5ff8fd1` fix: raise iOS deployment target to 15.0 (v1.0.0+6)
