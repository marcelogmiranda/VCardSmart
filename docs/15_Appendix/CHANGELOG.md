# VCardSmart

## [1.0.0+1] - 2026-07-14

### Changed
- Sprint 16: Store Release
- Generated android/ios platform directories with flutter create
- Configured android/app/build.gradle.kts with signing template, minSdk 21, targetSdk 34, ProGuard
- Configured AndroidManifest.xml with NFC, camera, contacts, biometric, internet permissions
- Configured iOS Info.plist with NFC, camera, contacts, Face ID usage descriptions
- Created key.properties.example for signing configuration
- Created proguard-rules.pro for release builds
- Updated CI/CD build.yml and release.yml with working-directory and Flutter 3.32.8
- Removed boilerplate widget_test.dart from flutter create
- 432 tests passing, coverage 88.1%
- flutter analyze: 0 issues

## [1.13.0] - 2026-07-14

### Changed
- Sprint 15: Optimization
- VCardSmartApp: split ref.watch into Consumer widget to reduce rebuilds
- ContactsPage: added ListView.builder params (addAutomaticKeepAlives, addRepaintBoundaries)
- 68 prefer_const_constructors lints resolved across source
- Fixed require_trailing_commas in contacts_pages_test.dart
- 432 tests passing, coverage 88.1%
- flutter analyze: 0 issues

## [1.12.0] - 2026-07-14

### Added
- Sprint 14: Testing
- Testes adicionais para AuthNotifier (checkAuth, authenticate, verifyPin, setPin)
- Testes adicionais para PinInput widget (4 e 6 dígitos, backspace, onCompleted)
- Testes adicionais para AuthGuard (error, checking states)
- Testes adicionais para ContactsPage, ImportPage, ImportDialog, ContactCard
- Testes adicionais para NFCStatusWidget, NFCInstructionWidget
- Testes adicionais para QRSharePage, QRScanPage
- Testes para AdConfig, AdUnits, AdService (mock AdDataSource)
- Testes para LocaleUtils, AppLocalizations (todos 8 idiomas)
- 84 novos testes (500 total)
- Coverage: 88.1%
- flutter analyze: 0 issues

## [1.11.0] - 2026-07-14

### Added
- Sprint 13: Ads Module (Google AdMob)
- AdConfig (showAds, showBanner, showInterstitial, interstitialInterval)
- AdUnits (banner/interstitial Android/iOS com fallback)
- AdDataSource (abstração) + LocalAdDataSource (google_mobile_ads)
- AdService (inicialização, interstitial por intervalo, lifecycle)
- BannerAdWidget (banner responsivo 50px)
- InterstitialAdWidget (wrapper para AdService)
- 23 novos testes (416 total)
- Coverage: 85.7%
- flutter analyze: 0 issues

## [1.10.0] - 2026-07-14

### Added
- Sprint 12: Multilanguage (i18n)
- Infraestrutura Flutter l10n com `flutter gen-l10n`
- 8 arquivos ARB (pt, en, es, fr, it, de, ja, zh) com 70+ chaves de tradução
- AppLocalizations gerado para todos os 8 idiomas
- LocaleUtils (supportedLocales, getLanguageName, getDeviceLocale)
- Atualização do app.dart com localizationDelegates e locale reativo via settingsProvider
- LanguageSelector atualizado para 8 idiomas (Português, English, Español, Français, Italiano, Deutsch, 日本語, 中文)
- Substituição de strings hardcoded na settings_page.dart com AppLocalizations
- 20 novos testes (393 total)
- Coverage: 85.7%
- flutter analyze: 0 issues

## [1.9.0] - 2026-07-14

### Added
- Sprint 11: Settings Module
- Settings entity (themeMode, locale, biometricEnabled, pinEnabled, adsEnabled)
- SettingsRepository interface + LocalSettingsRepository (in-memory)
- GetSettingsUseCase e UpdateSettingsUseCase
- SettingsNotifier com Riverpod (tema, idioma, biometria, PIN, anúncios)
- SettingsPage completa com seções Aparência, Segurança, Privacidade
- ThemeToggle (SegmentedButton: light/dark/system)
- LanguageSelector (DropdownButton: pt-BR, en)
- SecuritySettings (biometria + PIN toggles)
- PrivacySettings (anúncios toggle)
- Rota /settings
- 28 novos testes (362 total)
- flutter analyze: 0 issues

## [1.8.0] - 2026-07-14

### Added
- Sprint 10: Security Module
- SecureStorageService (flutter_secure_storage wrapper)
- EncryptionService (AES-256 com IV embutido)
- BiometricService (local_auth wrapper)
- PinService (hash SHA-256 + storage)
- AuthService (orquestador de autenticação)
- AuthenticateUseCase, SetPinUseCase, VerifyPinUseCase
- AuthProvider com AuthStatus (unauthenticated, authenticated, checking, error)
- AuthPage (tela de autenticação)
- PinSetupPage (configuração de PIN com confirmação)
- BiometricButton widget
- PinInput widget (4-6 dígitos)
- AuthGuard widget (proteção de rotas)
- encrypt: ^5.0.3 e crypto: ^3.0.3 dependencies
- 20 novos testes

## [1.7.0] - 2026-07-14

### Added
- Sprint 8: NFC Module
- NFCData entity (type, payload, timestamp)
- NFCRepository interface + LocalNFCRepository
- NFCDataSource + LocalNFCDataSource (simulado)
- SendNFCUseCase e ReceiveNFCUseCase
- NFCPayload (encode/decode Profile para JSON)
- NFCNotifier com NFCStatus (idle, ready, sending, receiving, success, error)
- NFCStatusWidget (status visual: disponível/indisponível)
- NFCInstructionWidget (instruções por estado)
- NFCSharePage e NFCReceivePage
- Rotas /nfc/share e /nfc/receive
- nfc_manager: ^3.0.0 dependency
- 53 novos testes (total: 209)
- Coverage 82.8%

## [1.6.0] - 2026-07-14

### Added
- Sprint 7: vCard Module (RFC 6350)
- VCardData entity com 13 campos (version, firstName, lastName, organization, title, email, phone, website, address, note, photo, linkedin, fullName)
- VCardRepository interface + LocalVCardRepository
- VCardDataSource com encode/decode/exportToFile/importFromFile
- EncodeVCardUseCase e DecodeVCardUseCase
- VCardUtils com encode/decode/toFile/fromFile
- VCardPreview widget com layout completo
- Suporte a vCard 3.0 e 4.0
- 29 novos testes (total: 156)
- Coverage 83.1%

## [1.5.0] - 2026-07-14

### Added
- Sprint 6: QR Code Module
- QRData entity com type, payload, timestamp
- QRPayload model com encodeVCard/decodeVCard (vCard 3.0)
- QRRepository interface + LocalQRRepository
- QRDataSource abstrato + LocalQRDataSource
- GenerateQRUseCase e ScanQRUseCase
- QRNotifier com Riverpod (generate, scan, reset)
- QRCodeWidget com qr_flutter (tamanho e cores configuráveis)
- QRScannerWidget com mobile_scanner
- QRSharePage e QRScanPage
- QRUtils com funções base64 e vCard
- QRException adicionado
- Rotas /qr/share e /qr/scan configuradas
- 28 novos testes (total: 127)
- Coverage 82.0%

## [1.4.0] - 2026-07-14

### Added
- Sprint 4: Profile Module
- UseCases: GetProfile, GetAllProfiles, CreateProfile, UpdateProfile, DeleteProfile
- ProfileNotifier e ProfileListNotifier com Riverpod
- ProfilePage e ProfileEditPage
- ProfileCard, ProfileHeader, ProfileForm widgets
- Rotas configuradas para perfil
- 67 testes unitários e de widget
- Coverage 100%

## [1.3.0] - 2026-07-14

### Added
- Sprint 3: Local Database
- Hive configurado com criptografia
- Profile entity com copyWith
- ProfileDataSource abstrato + HiveProfileDataSource
- ProfileRepository interface + LocalProfileRepository
- HiveService com init, close, deleteFromDisk
- 54 testes unitários e de widget
- Coverage 100%

## [1.2.0] - 2026-07-14

### Added
- Sprint 2: Design System
- Design tokens: AppColors, AppTextStyles, AppSpacing, AppShadows, AppBorders
- Shared widgets: AppButton, AppCard, AppInput, AppIcon, AppAvatar, AppDivider, AppLoading, AppError
- 40 testes unitários e de widget
- Coverage 100%

## [1.1.0] - 2026-07-14

### Added
- Sprint 1: Foundation
- Estrutura Clean Architecture (core/, features/, l10n/)
- AppConstants com rotas e boxes do Hive
- AppException com exceções tipadas (Profile, Database, Cache, Validation, Permission)
- AppTheme com temas light/dark (Material 3)
- AppRouter com GoRouter
- AppUtils com funções de formatação
- HomeProvider com StateNotifier
- HomeWidget reutilizável
- HomePage com ConsumerWidget
- L10n suporte (app_en.arb)
- 22 testes unitários e de widget
- Coverage 100%

## [1.0.0] - 2026-07-14

### Added
- Sprint 0: Setup do Ambiente
- Estrutura do projeto Flutter com Clean Architecture
- Configuração do pubspec.yaml com todas as dependências
- Configuração do analysis_options.yaml
- Tema Material Design 3 (light/dark)
- Roteamento com GoRouter
- Tratamento de erros centralizado
- HomePage básica
- Scripts de build, teste e release
- GitHub Actions workflows (build, test, release)
- Teste unitário básico da HomePage
