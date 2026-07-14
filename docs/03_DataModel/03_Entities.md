# Entities

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Entidades Principais

| Entidade | Descrição |
|----------|-----------|
| **UserProfile** | Perfil principal do usuário |
| **Company** | Empresa do usuário |
| **SocialNetwork** | Rede social vinculada |
| **Phone** | Telefone do usuário |
| **ReceivedCard** | Cartão importado |
| **Settings** | Configurações do app |
| **Preferences** | Preferências detalhadas |
| **History** | Histórico de ações |
| **ShareLog** | Log de compartilhamentos |

---

## UserProfile (Entidade Principal)

```dart
class UserProfile {
  final String id;
  final int version;
  final String fullName;
  final String companyName;
  final String jobTitle;
  final String presentation;
  final String? photoPath;
  final String? logoPath;
  final String email;
  final String? website;
  final List<Phone> phones;
  final List<SocialNetwork> socialNetworks;
  final String preferredLanguage;
  final ThemeMode themeMode;
  final ShareOptions shareOptions;
  final SecurityOptions securityOptions;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String schemaVersion;
}
```

### Campos

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `id` | String (UUID v4) | ✅ | Identificador único |
| `version` | int | ✅ | Versão do registro |
| `fullName` | String | ✅ | Nome completo |
| `companyName` | String | ✅ | Empresa |
| `jobTitle` | String | ✅ | Cargo |
| `presentation` | String | ✅ | Mensagem de apresentação |
| `photoPath` | String? | ❌ | Caminho da foto |
| `logoPath` | String? | ❌ | Caminho do logotipo |
| `email` | String | ✅ | E-mail (único) |
| `website` | String? | ❌ | Website pessoal |
| `phones` | List<Phone> | ✅ | Lista de telefones |
| `socialNetworks` | List<SocialNetwork> | ✅ | Lista de redes sociais |
| `preferredLanguage` | String | ✅ | Idioma preferido (padrão: "pt") |
| `themeMode` | ThemeMode | ✅ | Tema (padrão: system) |
| `shareOptions` | ShareOptions | ✅ | Opções de compartilhamento |
| `securityOptions` | SecurityOptions | ✅ | Opções de segurança |
| `createdAt` | DateTime | ✅ | Data de criação |
| `updatedAt` | DateTime | ✅ | Data de atualização |
| `schemaVersion` | String | ✅ | Versão do schema ("1.0") |

---

## Phone

```dart
class Phone {
  final String id;
  final String label;
  final String number;
  final String countryCode;
  final bool share;
  final bool whatsappEnabled;
}
```

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `id` | String (UUID) | ✅ | Identificador único |
| `label` | String | ✅ | Rótulo (ex: "Trabalho", "Celular") |
| `number` | String | ✅ | Número completo |
| `countryCode` | String | ✅ | Código do país (+55) |
| `share` | bool | ✅ | Compartilhar este telefone |
| `whatsappEnabled` | bool | ✅ | Habilitar WhatsApp |

---

## SocialNetwork

```dart
class SocialNetwork {
  final String id;
  final SocialNetworkType type;
  final String url;
  final String? username;
  final bool share;
  final int order;
}
```

### Tipos Suportados

| # | Tipo | Ícone |
|---|------|-------|
| 1 | Facebook | Facebook |
| 2 | Instagram | Instagram |
| 3 | LinkedIn | LinkedIn |
| 4 | X (Twitter) | X |
| 5 | Threads | Threads |
| 6 | TikTok | TikTok |
| 7 | YouTube | YouTube |
| 8 | GitHub | GitHub |
| 9 | GitLab | GitLab |
| 10 | Behance | Behance |
| 11 | Dribbble | Dribbble |
| 12 | Pinterest | Pinterest |
| 13 | Snapchat | Snapchat |
| 14 | Telegram | Telegram |
| 15 | WhatsApp | WhatsApp |
| 16 | Signal | Signal |
| 17 | Discord | Discord |
| 18 | Reddit | Reddit |
| 19 | Medium | Medium |
| 20 | Twitch | Twitch |
| 21 | Mastodon | Mastodon |
| 22 | Bluesky | Bluesky |
| 23 | Site Pessoal | Website |
| 24 | Outro | Custom |

---

## ShareOptions

```dart
class ShareOptions {
  final bool shareName;
  final bool shareCompany;
  final bool sharePosition;
  final bool sharePresentation;
  final bool sharePhoto;
  final bool shareLogo;
  final bool sharePhones;
  final bool shareEmail;
  final bool shareWebsite;
  final bool shareSocialNetworks;
}
```

Cada campo é configurável pelo usuário para permitir **compartilhamento seletivo**.

---

## SecurityOptions

```dart
class SecurityOptions {
  final bool biometricEnabled;
  final bool pinEnabled;
  final bool autoLock;
  final int lockTimeout;
  final bool hideScreenshots;
  final bool requireAuthenticationOnStart;
}
```

---

## ReceivedCard

```dart
class ReceivedCard {
  final String id;
  final String fullName;
  final String? companyName;
  final String? jobTitle;
  final String email;
  final List<Phone> phones;
  final List<SocialNetwork> socialNetworks;
  final String? photoPath;
  final DateTime receivedAt;
  final String source;
  final String? rawVcard;
}
```

---

## Documentos Relacionados

- [01_DataModelOverview.md](./01_DataModelOverview.md)
- [04_ValueObjects.md](./04_ValueObjects.md)
- [05_DTOs.md](./05_DTOs.md)
- [17_ERDiagram.md](./17_ERDiagram.md)
- [18_ClassDiagram.md](./18_ClassDiagram.md)
