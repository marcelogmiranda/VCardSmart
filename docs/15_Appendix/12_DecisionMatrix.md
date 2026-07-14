# Decision Matrix — VCardSmart

## Stack Tecnológica

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Framework | Flutter | React Native | Native | Flutter |
| State | Riverpod | Bloc | Provider | Riverpod |
| Navigation | GoRouter | AutoRoute | Navigator 2.0 | GoRouter |
| Storage | Hive | SQLite | Isar | Hive |
| Secure | Flutter Secure Storage | Keychain/Keystore | - | Flutter Secure Storage |
| Testing | flutter_test | integration_test | golden_toolkit | flutter_test |
| CI/CD | GitHub Actions | Codemagic | Bitrise | GitHub Actions |

## Arquitetura

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Arquitetura | Clean Architecture | MVVM | MVC | Clean Architecture |
| Feature Organization | Feature-based | Layer-based | Domain-based | Feature-based |
| DI | Riverpod | GetIt | Injectable | Riverpod |
| Error Handling | Exceptions | Result Type | Either | Exceptions |

## Segurança

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Encryption | AES-256 | ChaCha20 | RSA | AES-256 |
| Key Storage | Secure Storage | Hive Encrypted | - | Secure Storage |
| Auth | Biometric | PIN | Password | Biometric + PIN |

## UI

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Design System | Material Design 3 | Cupertino | Custom | Material Design 3 |
| Theming | ThemeProvider | Dynamic Color | Static | ThemeProvider |
| Localization | intl | easy_localization | - | intl |

## Features

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| QR Code | mobile_scanner | qr_code_scanner | - | mobile_scanner |
| NFC | nfc_manager | ndef | - | nfc_manager |
| vCard | vcard | custom | - | custom |
| Sharing | share_plus | social_share | - | share_plus |

## Publicidade

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Ads | Google AdMob | Facebook Ads | Unity Ads | Google AdMob |
| IAP | Google Play Billing | RevenueCat | - | Google Play Billing |

## Monetização

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Free | Banner + Interstitial | Rewarded only | No Ads | Banner + Interstitial |
| Premium | Subscription | One-time | Freemium | Subscription |

## Deploy

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Android | Google Play | APK direct | - | Google Play |
| iOS | App Store | TestFlight | - | App Store |
| Versioning | SemVer | CalVer | - | SemVer |
| Signing | keystore | release key | - | keystore |

## Documentação

| Decisão | Opção 1 | Opção 2 | Opção 3 | Escolha |
|---------|---------|---------|---------|---------|
| Format | Markdown | RST | HTML | Markdown |
| Diagrams | Mermaid | PlantUML | Draw.io | Mermaid |
| ADRs | MADR | Custom | - | Custom |

## Critérios de Avaliação

### Peso dos Critérios

| Critério | Peso |
|----------|------|
| Privacidade | 30% |
| Offline | 25% |
| Simplicidade | 20% |
| Performance | 15% |
| Comunidade | 10% |

### Pontuação

| Opção | Privacidade | Offline | Simplicidade | Performance | Comunidade | Total |
|-------|-------------|---------|--------------|-------------|------------|-------|
| Flutter | 5 | 5 | 5 | 4 | 5 | 4.85 |
| React Native | 4 | 4 | 4 | 4 | 5 | 4.20 |
| Native | 5 | 5 | 3 | 5 | 4 | 4.55 |

**Escolha**: Flutter (4.85)
