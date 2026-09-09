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
- **NFC iOS (09/09)**: entitlement `com.apple.developer.nfc.readersession.formats` (NDEF + TAG) adicionado ao `Runner.entitlements`. Profile de distribuição regenerado com NFC habilitado — UUID `1be67110-02da-41cd-bf61-c3b2fbd8cc84`. `Info.plist` tem `NFCReaderUsageDescription`. NFC deve funcionar em iPhone 7+ após rebuild.
- Release build device: `flutter build ios --release`
- IPA App Store: `flutter build ipa --release` → `app/build/ios/ipa/VCardSmart.ipa` (subir via Transporter)

## Android
- Aparelho de teste: Redmi Note 8 (modelo `ginkgo`, Android 10/API 29, MIUI 12). ID adb: `11ae045e`.
  - **ATENÇÃO (31/08): o Redmi Note 8 `ginkgo` NÃO tem NFC** (variante global sem o chip NFC). Confirmado por `pm list features` (sem `android.hardware.nfc`), `/sys/class/nfc` inexistente e `ro.hardware.nfc` vazio. **NÃO usar este aparelho para testar NFC.** Para teste NFC real usar outro Android físico com NFC.
  - **ATENÇÃO (02/09): Galaxy Tab A9+ `SM-X210` (Wi-Fi) NÃO tem NFC** — id adb `R9XY50C2BWL`, modelo `SM_X210`/`gta9pwifi`. Confirmado: `pm list features` sem `android.hardware.nfc`, `/sys/class/nfc` inexistente, `dumpsys nfc` vazio (`ro.nfc.port` presente, mas é só driver, não indica hardware). A variante **SM-X216 (LTE/5G)** é a que tem chip NFC. **NÃO usar para teste NFC** — mostrará "NFC não disponível". Útil para testar migração .vcs / foto / ads / onboarding.
  - `adb` em: `/Users/mmiranda/Library/Android/sdk/platform-tools`
  - Build Android release já assinado: `android/key.properties` + `release-keystore.jks`.
  - Compile usa Java 11; build APK debug: `flutter build apk --debug`.
  - **Assinatura**: APK debug (Flutter debug key) NÃO instala por cima de APK release assinado (`INSTALL_FAILED_UPDATE_INCOMPATIBLE: signatures do not match`). Para sobrescrever um release no device ou usar o mesmo APK, desinstalar (perde dados) ou instalar release.
  - **Conexão USB (31/08)**: às vezes o adb fica `unauthorized` ou o device some — trocar de porta no Mac + confirmar o popup "Permitir depuração USB?" no Redmi costuma resolver. Confiram `adb devices` após reconectar.
- MIUI 12 bloqueia instalação via USB: ao instalar, o Security Center mostra "Instalar este app via USB?" com botão "Recusar (5)" (auto-cancela em 5s). Workaround: durante `adb install`, monitorar foco com `dumpsys window | grep AdbInstallActivity` e tocar no botão "Instalar" (coordenadas ~300,2060) via `input tap`.
- OneDrive trava o cache Gradle (`app/android/.gradle`). `app/android/.gradle` agora é symlink para pasta local (mesmo esquema do `build/`). Não recriar como pasta real dentro do OneDrive.

## Testes
- Suíte não-golden: `flutter test test/core test/features test/shared test/l10n` → verde (456 testes). `test/infrastructure/` está vazio e fora do git (apenas local) — **não** incluí-lo em comandos de CI (o runner falha ao "loadar" um path inexistente: `❌ loading .../test/infrastructure`).
- `test/golden/` tem ~29 falhas pré-existentes (AppAvatar etc.), não relacionadas a mudanças atuais. **A CI (`build.yml`) NÃO roda os goldens** — o job `test` usa a suíte determinística acima (golden é flaky entre macOS/Linux); goldens são só para uso local (`flutter test test/golden/`).
- **SPM DESATIVADO no projeto (11/08)**: `pubspec.yaml` → `flutter: config: enable-swift-package-manager: false`. Motivo: Flutter 3.44 ativa Swift Package Manager por padrão e migra `webview_flutter_wkwebview` para SPM; mas `google_mobile_ads` 4.0.0 (CocoaPods-only, min SPM desde 8.0.0) depende dele via podspec → build iOS do CI falhava (`Unable to find a specification for 'webview_flutter_wkwebview'`). Com o opt-out, o CI usa CocoaPods puro (igual ao local). Ponte até Dec/2026 (CocoaPods read-only); depois será preciso upgrade do `google_mobile_ads` p/ ≥8.0.0 e reativar SPM. Não rodar `flutter config --no-enable-swift-package-manager` na CI — o opt-out no pubspec é suficiente e commitável.
- CI/CD GitHub Actions fixado (11/08): Flutter pin `3.44.7` em `build.yml` e `release.yml` (3.32.8 quebrava com `targetSdk 36`); removido `build_runner` da CD (projeto não usa codegen). CD Android agora monta `android/key.properties` a partir de secrets (`KEYSTORE_BASE64/KEYSTORE_PASSWORD/KEYSTORE_ALIAS/KEY_PASSWORD`). CD iOS instala cert p12 + mobileprovision no runner via secrets (`IOS_DISTRIBUTION_CERT_BASE64/IOS_CERT_PASSWORD/IOS_PROVISIONING_PROFILE_BASE64`). **Falta criar essas secrets no GitHub** (comandos de export: `base64 -i app/android/app/release-keystore.jks`; p12: `security export -k login.keychain-db -t identities -f pkcs12 -P <senha> -o dist.p12`; perfil: `base64 -i certificates/VCardSmart_App_Store.mobileprovision`).
- `flutter analyze` → No issues found.
- Bug corrigido (10/08): no aparelho lento, o `context.push` do go_router NUNCA resolvia após o PIN (redirect durante o pop "orfanava" o completer) → o app travava no onboarding. Fix: a conclusão do setup (`markSecurityAsked` + `checkAuth` + navegação) agora roda direto na página do PIN (`security_setup_completion.dart`), sem depender do resultado do push. Reprodução em `test/features/security/presentation/repro_slow_device_test.dart` (delays 0/20/80/150ms). Validação no Redmi: setup → PIN → auth → desbloqueio → Home, tudo OK.
- Fix layout (10/08): `PinInput` de 6 dígitos (432dp) estourava 103px no Redmi (tela ~392dp lógicos). Envolvido em `FittedBox(scaleDown)` — banner de overflow sumiu no device.
- **IMPORTANTE**: o hash do PIN fica no `flutter_secure_storage` (Android: EncryptedSharedPreferences + Android Keystore), NÃO no Hive. `pm clear`/`uninstall` destrói o PIN de forma irrecuperável (a chave do Keystore se perde) — backup de `app_flutter/` não preserva PIN.
- Recuperação de PIN (10/08): se os settings dizem `pinEnabled=true` mas não existe hash de PIN (e sem biometria) — ex.: dados perdidos após restore/update — o `checkAuth` corrige o estado (`updatePin(false)`) e reabre o onboarding para novo cadastro, em vez de travar na tela de auth. `hasPin()`/biometria com erro são tratados como "sem PIN". Testes em `security_flow_integration_test.dart` (grupo "PIN storage recovery").
- Fix foto (10/08): `image_picker` guardava só o path do cache Android (`/data/user/0/.../cache/`), que o SO/limpador pode apagar → selfie "sumia". Agora `_pickImage` (`profile_form.dart`) copia a foto para o diretório persistente (`.../documents/photos/`) via `ImageUtils.savePhotoLocally` antes de salvar o path. Aguarda validação no Redmi.
- Usabilidade (10/08): unificados os cards "Meu QR Code" + "Compartilhar" do Home em um único card (mesma rota `/qr/share` com guard de perfil); removido widget morto `photo_picker.dart`.
- **Release Android crashava no Redmi (10/08)**: `VM snapshot invalid` + SIGSEGV no `FlutterJNI.performNativeAttach`. Causa: Android 10/MIUI carregava `libflutter.so` direto do APK e falhava (bug conhecido de Xiaomi; `lib/arm64` não era extraído). Fix: `android:extractNativeLibs="true"` no `<application>` do AndroidManifest.xml. Release validado no Redmi: onboarding → Home → card unificado → criação de perfil → QR → cold start estáveis.
- **IPA (10/08) RESOLVIDO**: as credenciais de distribuição sempre estiveram em `certificates/` no projeto (`distribution.cer` + `VCardSmart_App_Store.mobileprovision`) mas **não estavam instaladas** no keychain/Profiles. A chave privada já estava no keychain. Fix: `security add-certificates certificates/distribution.cer` + copiar o `.mobileprovision` para `~/Library/MobileDevice/Provisioning Profiles/<UUID>.mobileprovision` (UUID `c21b48c2-8486-47bc-a916-8308b0bd8e22`). Resultado: identidade `Apple Distribution: Marcelo Miranda (7775YGF9CJ)` ativa e `flutter build ipa --release` → `build/ios/ipa/VCardSmart.ipa` OK.

## Target SDK (Google Play)
- **Requisito Play (31/08/2026)**: novas versões e updates devem ter como alvo **Android 16 (API 36)** ou superior; `targetSdk=35` bloqueia o update.
- **Atualizado em 1.0.3+11 (10/08)**: `targetSdk = 36` no `app/android/app/build.gradle.kts` (compileSdk = `flutter.compileSdkVersion` = 36 no Flutter 3.44.7). AAB release validado (merged manifest: `targetSdkVersion="36"`, `versionCode=11`, `versionName=1.0.3`).
- Android 16 (API 36): edge-to-edge já vigente desde 35; 16KB page size suportado pelo Flutter 3.44 (sem libs nativas próprias). Testar no Redmi para confirmar que nada quebrou.
- **16KB page size — comentário Play (15/08)**: o pré-lançamento do Play reprovou com "app usa bibliotecas nativas sem suporte a 16KB". O AAB tinha 2 libs 64-bit com segmentos ELF alinhados a 4KB, ambas vindas do `mobile_scanner 3.5.7`: `libbarhopper_v3.so` (com.google.mlkit:barcode-scanning **17.2.0**) e `libimage_processing_util_jni.so` (androidx.camera:camera-core **1.3.1**). Fix: `dependencies { }` em `app/android/app/build.gradle.kts` forçando `com.google.mlkit:barcode-scanning:17.3.0` + CameraX `1.5.3` (camera-core/camera2/lifecycle) — essas versões emitem libs alinhadas a 16KB. Mantido `extractNativeLibs="true"` (libs compactadas/extraídas) para **não** regredir o fix do crash Xiaomi/Redmi (16KB ELF-alignment é o que o Play valida; o alinhamento zip de 16KB só se aplica a libs descompactadas). Verificado pós-build: todas as libs arm64-v8a/x86_64 com p_align ≥ 16384 (32-bit isento). Ferramenta: `llvm-readobj -l <lib> | awk '/PT_LOAD/{f=1} f && /Alignment:/{print $2; exit}'` (NDK r27).
- **Edge-to-edge — comentário Play (15/08)**: o pré-lançamento sugeriu adotar `enableEdgeToEdge()`. Flutter já renderiza fullscreen e o framework trata insets via MediaQuery/SafeArea (todas as telas usam Scaffold+AppBar; Shell usa NavigationBar). Fix adotado: `MainActivity.kt` chama `WindowCompat.setDecorFitsSystemWindows(window, false)` (androidx.core já vem via flutter_embedding) para API 30+, equivalente ao enableEdgeToEdge (API 35+ é forçado pelo SO). Redmi (API 29) não é afetado.

## Versões publicadas
- **1.0.0 (8)** — primeira versão; AAB enviado à Google Play (10/08).
- **1.0.1 (9)** — build iOS em TestFlight (testes, já em andamento).
- **1.0.2 (10)** — IPA subido ao App Store Connect (Transporter) pelo usuário.
- **1.0.3 (11)** — `targetSdk=36` (exigência Google Play 31/08/2026) + versão sincronizada Play/iOS.
- **1.0.4 (12)** — **atual** no pubspec (15/08): resposta aos comentários do pré-lançamento do Play (16KB page size + edge-to-edge). AAB e IPA gerados no mesmo commit/numeração.
- Status iOS (12/08): **IPA 1.0.3/11 entregue ao App Store Connect via Transporter** (substitui o 1.0.2/10) — `~/Downloads/VCardSmart-1.0.3-11.ipa` (33.8MB, SHA-256 `3f2304cd...11afd`). Aguarda processamento/validação.
- Status Android (12/08): **AAB 1.0.3/11 (targetSdk 36) enviado à Google Play — Production** (substitui o 1.0.0/8) — `~/Downloads/VCardSmart-1.0.3-11.aab` (65.2MB, SHA-256 `fa73da76...9a13`). Manifesto: `versionCode=11`, `versionName=1.0.3`, `targetSdk=36`, `minSdk=24`. Comentários do pré-lançamento (16KB + edge-to-edge) tratados na 1.0.4/12.
- Status 1.0.4/12 (15/08): **AAB** `~/Downloads/VCardSmart-1.0.4-12.aab` (66.1MB, SHA-256 `968de106...c958`) e **IPA** `~/Downloads/VCardSmart-1.0.4-12.ipa` (34.0MB, SHA-256 `a567ee5d...70f0`). AAB verificado: todas as libs 64-bit com p_align ≥ 16384; merged manifest `versionCode=12`, `versionName=1.0.4`, `targetSdk=36`, `extractNativeLibs=true`. IPA: `Version 1.0.4, Build 12`. Home com cards unificados (3) nas duas plataformas — o AAB 1.0.3/11 na loja ainda era o build antigo de 4 cards (pré-unificação).
- **Política de versão**: toda nova build (Play e iOS) deve subir **a mesma numeração** (`pubspec.yaml`) — iOS e Android derivam de `FLUTTER_BUILD_NAME/NUMBER` e `flutter.versionName/versionCode`.

## Ronda de melhoria 31/08 (v1.0.5 — NÃO subir às lojas; testar via USB)
Rodada de evolução focada em: (a) requisitos de qualidade do Play (memória), (b) padrão de migração de dispositivo do Play e (c) gravação de cartão NFC externo. **Nenhuma build subiu às lojas** — builds para teste direto em device via cabo USB.

### 1. Otimizações de memória (req. Play "redução de uso de memória + bitmap")
- `ImageUtils.compressImage` era **no-op** (não comprimia). O ganho real de memória veio de **não decodificar bitmap em resolução cheia**:
  - `profile_header.dart` e `profile_form.dart`: `FileImage` envolto em `ResizeImage(..., width:224, height:224)` (avatar 56dp → 224px, 2x density). NOTA: `FileImage` NÃO aceita `cacheWidth/cacheHeight` (esses são do widget `Image`); o correto é `ResizeImage`.
  - `local_ad_data_source.dart`: `MobileAds.initialize()` era chamado 2x (main.dart + datasource). Agora cacheia o future (`_initFuture ??=`) para rodar 1x por processo.
  - `profile_photo_datasource.dart`: `getPhotoPath` usava `listSync` + `path.contains(profileId)` (lento e impreciso). Agora filtra por prefixo `{id}_` e pega o mais novo.
- **NÃO** mexido em R8/proguard (já ativo).

### 2. Migração de dispositivo (req. Play "experiência de migração segura")
- Nova feature `features/migration/` (clean architecture): export/import de backup criptografado `.vcs` com senha do usuário.
- Dados incluídos: **profiles + contacts + settings + hash do PIN** (o hash SHA-256 do PIN é device-independent — `verifyPin` recomputa `sha256(pin)` e compara, sem chave ligada ao aparelho → transferível). Fluxo: `BackupDataSource.collectBackup()` (Hive boxes + flutter_secure_storage key `app_pin`) → `LocalBackupRepository` (encrypt via `EncryptionService` AES + senha) → arquivo `.vcs` compartilhado via `share_plus`. Import: picker de arquivo (`file_picker`, **nova dependência** `^8.0.0`) → decrypt → `restoreBackup` (limpa Hive, recria, restaura settings + PIN).
- UI: em `settings_page.dart` nova seção "Dados" → "Migração de Dispositivo" → `migration_page.dart` (rota `/settings/migration`).
- Erro de senha errada: `LocalBackupRepository.importFromFile` captura a exceção do AES e relança `FormatException` amigável ("Verifique a senha").
- **Segurança/limitação**: biometria NÃO é migrável (fica no secure storage do aparelho); precisa reconfigurar no novo device. `allowBackup=false` mantido (backup é por fricção manual, não auto).

### 3. Cartão NFC externo (vCard padrão)
- `LocalNFCRepository.send` agora escreve **vCard 3.0** (`text/vcard`) no lugar do JSON proprietário → cartão lido nativamente por **qualquer** celular (app de Contatos), não só usuários do VCardSmart.
- Novo `features/nfc/data/models/profile_vcard_converter.dart`: `Profile↔vCard` (todos os campos: nome, telefone, email, site, linkedin, facebook, x, social, instagram, bio).
- `receive` mantém retrocompat: detecta `BEGIN:VCARD` → converte; senão cai no JSON legado (`application/vcardsmart/profile`).
- UI: `nfc_share_page.dart` renomeada para "Gravar em Cartão NFC" com texto explicando cartão gravável (NTAG213/215/216) + botão "Gravar no cartão".

### 4. nfc_manager — NÃO atualizado (decisão)
- `nfc_manager ^3.0.0` (lock 3.5.1). A 4.x (4.2.1) tem **muitas breaking changes** (remove `Ndef`, renomeia tech classes, `isAvailable→checkAvailability`) e exige `nfc_manager_ndef`, além de risco no build 16KB/AdMob/CocoaPods crítico para a loja. Mantido em 3.5.1; upgrade fica para quando o `google_mobile_ads` subir p/ ≥8.0.0 e SPM for reativado (ponte Dec/2026).

### 5. Testes/estado
- `flutter analyze` → **No issues found**.
- Suíte determinística (não-golden): **467 testes verdes** (456 antigos + 11 novos: `profile_vcard_converter_test` (6), `backup_data_test` (2), `local_backup_repository_test` (3)). Após o fix do acesso NFC, rodei `test/features/nfc test/features/qr_code test/l10n` (113) → verde.
- Debug APK compilou com `file_picker` (`app-debug.apk` OK, 96MB).
- **Fix (31/08)**: a tela "Gravar em Cartão NFC" (`/nfc/share`) **não era acessível** — a rota existia no router mas nenhuma tela navegava até ela. Adicionei o botão **"Gravar em Cartão NFC"** no `QRSharePage` (card "Meu QR Code" no Home) via `context.push(AppConstants.nfcShareRoute)`; padronizei os AppBars do `NFCShareRoutePage` para "Gravar em Cartão NFC".
- **IPhone testado (31/08)**: instalei **1.0.5/13** por cima (App Store signing, preserva dados Hive) via `devicectl device install app` usando o `.app` do archive. App abre com dados preservados. **NFC iOS:** mostrou "NFC não disponível" — causa: App ID sem capability "NFC Tag Reading" (ver seção iOS). **Decidiu-se NÃO habilitar por ora.**
- **Redmi testado (31/08)**: o adb quase não pegou (problema físico/modo MTP + popup de depuração); conectou depois de trocar de porta + confirmar popup. **Confirmado: Redmi Note 8 `ginkgo` NÃO tem NFC** (`pm list features` sem `android.hardware.nfc`, `/sys/class/nfc` inexistente). App 1.0.4 instalado; APK debug **não** instala por cima (`INSTALL_FAILED_UPDATE_INCOMPATIBLE` — assinaturas diferentes). **Não usar para teste NFC.**
- **Cartão NFC do usuário**: é o cartão de visita com link do Instagram (gravado com NFC Tools). Precisa validação real de `isWritable`/regravação em **outro Android físico com NFC** (ver Pendências).

### Infra (ambiente)
- `app/build` e `app/android/.gradle` são symlinks para `/var/folders/.../T/opencode/vcardsmart_build` e `vcardsmart_android_gradle`; os alvos tinham sumido (OneDrive) — recriados. Não recriar como pastas reais dentro do OneDrive.

## Ronda v1.0.6 (09/09 — nova aba NFC + qualidade iOS Guideline 5.6)
Rodada para: (a) mover NFC para **aba dedicada** na barra de navegação (posição 3, antes de Configurações) com **detecção automática**; (b) corrigir issues da rejeição iOS **Guideline 5.6.4 (qualidade)** encontradas na revisão (26 itens). **Não subiu às lojas** — validar em device antes.

### Nova aba NFC (sempre visível, com detecção automática)
- `nfc_main_page.dart` (`/nfc`): verifica `nfcProvider.checkAvailability()`; se OK mostra "Gravar Cartão" (→`/nfc/share`) e "Receber Contato" (→`/nfc/receive`); se indisponível mostra ícone `Icons.contactless` + "NFC não disponível" + botão "Voltar ao Início" full-width.
- `shell_page.dart`: 4ª `NavigationDestination` (Icons.contactless_outlined/contactless) no índice 2; `_calculateSelectedIndex`: contacts=1, nfc=2, settings=3; `_onItemTapped` case 2 → `context.go('/nfc')`.
- `app_router.dart`: `GoRoute(/nfc)` dentro do `ShellRoute`; `/nfc/share` e `/nfc/receive` permanecem fora (push).
- `app_constants.dart`: `nfcRoute = '/nfc'`. Botão "Gravar em Cartão NFC" removido do `qr_share_page.dart`.
- Testes: 5 novos de `NFCMainPage` em `nfc_pages_test.dart`.

### Qualidade iOS — fixes aplicados (HIGH e parte dos MEDIUM)
- **Versão**: `package_info_plus ^8.0.0` + `app_version_provider.dart` (FutureProvider); `settings_page.dart` mostra `${version}+${buildNumber}` via `_AppVersionTile` (fallback `AppConstants.appVersion`). Atualizado para 1.0.6+14.
- **Migração** (`migration_page.dart`): erros técnicos → `_friendlyError` (senha incorreta/arquivo corrompido, caminho inacessível, erro inesperado); diálogo de senha com toggle mostrar/esconder (ícone olho).
- **Home** (`home_page.dart`): `_ProfileCard` → ConsumerWidget usando `homeProfilesProvider` (novo FutureProvider em `profile_provider.dart`); mostra nome/foto/email/telefone reais quando há perfil; `_shareProfile` com try/catch amigável.
- **Auth** (`auth_page.dart`): dead-end sem PIN/biometria resolvido com botão "Configurar Segurança" (`unmarkSecurityAsked()` novo em `settings_provider.dart` → `checkAuth` → home); cores via theme.
- **Settings**: desativar PIN/biometria agora pede confirmação (`_confirmDisable` AlertDialog Cancelar/Desativar); typo "cartão".
- **NFC receive** (`nfc_receive_page.dart`): removido `NfcManager` duplicado; botão "Voltar" só em success/error (não durante o polling); corpo scrollável; botões full-width. "Voltar" não interrompe mais a sessão NFC no meio.
- **NFC widgets**: cores → `AppColors.*` (não Colors hardcoded); idle text "Toque no botão para iniciar".
- **Contatos** (`contacts_page.dart`): SnackBar "Contato importado com sucesso!" (ref.listen loading→success); lista ordenada alfabeticamente; **excluir por swipe** (Dismissible) com confirmação + SnackBar; empty state com CTA "Importar contato" (ícone `Icons.add`); erro com detalhe + "Tentar novamente"; **pull-to-refresh (RefreshIndicator)** no list vazio e preenchido; `_DetailRow` cor `onSurfaceVariant`.
- **Banner ad** (`banner_ad_widget.dart`): `_loadFailed` → `SizedBox.shrink()` (não ocupa 50px quando falha).
- **Perfil** (`profile_header.dart`): 17x `Colors.grey[600]` → `colorScheme.onSurfaceVariant`.
- **PIN** (`pin_setup_page.dart`/`pin_input.dart`): estado `_saving` (bloqueia input + spinner); SafeArea; cores theme; `PinInput(enabled:)`.
- **Security setup** (`security_setup_page.dart`): cores theme; `AppButton` em `SizedBox(width: double.infinity)`.
- **ADiADO (fora de escopo desta rodada)**: localização completa das telas (NFC/contatos/settings têm strings pt hardcoded; test wrapper não tem delegates l10n — migrar quebraria testes); **link de privacy policy** (não há URL no projeto — decisão de produto). Demais MEDIUM já cobertos acima.

### Estado v1.0.7 (09/09)
- pubspec **1.0.7+15** (numeração única Play/iOS); `AppConstants.appVersion` = '1.0.7+15' (e teste).
- **NFC iOS HABILITADO**: `Runner.entitlements` com `com.apple.developer.nfc.readersession.formats` (NDEF+TAG); profile de distribuição **VCardSmart** regenerado com NFC (UUID `1be67110-02da-41cd-bf61-c3b2fbd8cc84`, Name=`VCardSmart`, equivale ao antigo "VCardSmart App Store"). Projeto iOS em **signing manual** (`CODE_SIGN_STYLE=Manual`, `CODE_SIGN_IDENTITY="Apple Distribution"`, `PROVISIONING_PROFILE_SPECIFIER=VCardSmart`) nas configs Release/Profile. `.app` verificado com entitlement NFC presente.
- **`flutter build ipa --release` FALHA no export** ("requires a provisioning profile with the NFC Tag Reading feature") → **workaround**: export via `xcodebuild -exportArchive` com `export_options.plist` manual (`method=app-store-connect`, `signingStyle=manual`, `provisioningProfiles` → `VCardSmart`). Resultado: **IPA 1.0.7/15 em `~/Downloads/VCardSmart-1.0.7-15.ipa`** (19MB, SHA-256 `98ae9364…8986`; CFBundle 1.0.7/15, Min iOS 15.0, **entitlement NFC = só `TAG`**). Validado: `codesign -d --entitlements` mostra NFC.
- **IMPORTANTE (App Store, 09/09)**: `NDEF` no entitlement `com.apple.developer.nfc.readersession.formats` é **DESENCONCEPTO/desligado** pela validação da App Store — erro `Asset validation failed (90778) ... 'NDEF is disallowed'`. Fix: manter **apenas `TAG`** (o `NFCTagReaderSession` do nfc_manager lê/grava NDEF mesmo assim). O profile no portal contém NDEF+TAG+PACE, mas o entitlement embarcado no `.app` é o do `Runner.entitlements`.
- Android: **NÃO subiu** (build AAB ainda não gerado nesta rodada) — issue NFC era iOS-only.

### Estado v1.0.8 (09/09) — melhorias de leitura/gravação NFC
- pubspec **1.0.8+16** (numeração única Play/iOS); `AppConstants.appVersion` = '1.0.8+16' (e teste).
- **Leitura**: `nfc_datasource.dart` decodifica registros NDEF **URI ('U') e Text ('T')** — cartão gravado com apps como NFC Tools (ex.: link do Instagram do usuário) agora é **lido e importável** (fallback `profileFromText` em `profile_vcard_converter.dart`; repositório trata vCard / JSON legado / texto solto). Região: `_extractPayload`.
- **Erros amigáveis**: sessão iOS mapeada via `_mapSessionError` (sessionTimeout → "Nenhum cartão foi encontrado. Segure o cartão na parte de trás do iPhone, próximo à câmera"; userCanceled → "Leitura cancelada."; systemIsBusy → "sistema ocupado"); classe `LocalNFCException` com mensagem para UI; SnackBars das páginas de share/receive exibem a mensagem real.
- **Gravação**: checagem de capacidade (`message.byteLength` > `ndef.maxSize` → orienta usar NTAG215/216); cartão não-gravável/protegido → "Este cartão não aceita a gravação de contatos (não é um NTAG gravável ou está protegido)".
- **UX**: textos orientando posicionar o cartão no topo do iPhone (widget de instrução + páginas share/receive).
- **Testes**: mock `nfc_channel_mock.dart` estendido (`NfcRecordMock` URI/Text, tag writable/maxSize, `failSession`); +12 testes novos (URI, Text, timeout, cancelado, read-only, capacidade, fallback). Suíte determinística: **480 testes verdes**; `flutter analyze` → No issues found.
- **Builds**: **IPA 1.0.8/16** em `~/Downloads/VCardSmart-1.0.8-16.ipa` (19.7MB, SHA-256 `c707c7f5…e3ce4`; CFBundle 1.0.8/16, Min iOS 15.0, **entitlement NFC = `TAG`** — validado via `codesign -d`). Archive: `build/ios/archive/Runner.xcarchive` (export via workaround xcodebuild). **AAB 1.0.8+16** em `~/Downloads/VCardSmart-1.0.8-16.aab` (67.9MB, SHA-256 `d8272fd5…39ee7`; merged manifest `versionCode=16`, `versionName=1.0.8`, `targetSdk=36`, `extractNativeLibs=true`; libs 64-bit com p_align ≥ 16384 — vérif. llvm-readobj).

## Pendências (próxima interação)
1. **Subir 1.0.8+16 às lojas**: Transporter (`~/Downloads/VCardSmart-1.0.8-16.ipa`) e Play Console (`~/Downloads/VCardSmart-1.0.8-16.aab`) — programáticas: **Play**: bots de 16KB/edge/versão; **App Store**: Export Compliance "standard encryption / exempt" (template em `docs/11_Legal/22_ExportCompliance.md`), NÃO marcar "no encryption".
2. **Validar NFC real em OUTRO Android físico com NFC** (Redmi Note 8 NÃO serve — sem chip NFC): conectar via USB, instalar `app-debug.apk`, tocar "Gravar em Cartão NFC" → "Gravar no cartão" com o cartão do usuário (link do Instagram) na mão. O app reporta `isWritable` (se regravável) e grava o vCard; validar leitura em app de Contatos de outro celular. **Se o cartão estiver write-locked, obter um NTAG213/215/216 em branco.**
3. **Validar NFC no iPhone (1.0.8/16)**: TestFlight ou IPA por USB. Testar "Gravar Cartão"/"Receber Contato" com o cartão do usuário (agora com erro/posicionamento claros e leitura de registro URI do Instagram). Validar migração (.vcs via share sheet/AirDrop).
4. **Validar migração .vcs (export→import)** e foto/avatar (ResizeImage 224) e fluxo de ads — preferencialmente no aparelho com NFC / outro device.
5. **Export Compliance (App Store)**: manter "standard encryption / exempt". Template de carta em `docs/11_Legal/22_ExportCompliance.md`. NÃO marcar "no encryption".

## Histórico de Commits (recente)
- `76cbfd9` feat: add facebook, x and generic social link fields to profile
- `578d4a7` fix: route security setup flow correctly and add integration tests
- `9f77f91` feat: redesigned security onboarding and configurable lock (v1.0.0+8)
- `3ffc72b` fix: upgrade flutter_contacts to 2.3.1 (v1.0.0+7)
- `5ff8fd1` fix: raise iOS deployment target to 15.0 (v1.0.0+6)
