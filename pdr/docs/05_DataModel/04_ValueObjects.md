# Value Objects

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## O que são Value Objects

Value Objects são objetos imutáveis que representam valores com regras de negócio embutidas. Eles validam e encapsulam dados atômicos.

---

## Value Objects

### Email

```dart
class Email {
  final String value;

  const Email(this.value);

  factory Email.fromString(String email) {
    if (!isValid(email)) {
      throw InvalidEmailException(email);
    }
    return Email(email);
  }

  static bool isValid(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
```

### PhoneNumber

```dart
class PhoneNumber {
  final String value;
  final String countryCode;

  const PhoneNumber(this.value, this.countryCode);

  factory PhoneNumber.fromString(String phone, String countryCode) {
    if (!isValid(phone)) {
      throw InvalidPhoneException(phone);
    }
    return PhoneNumber(phone, countryCode);
  }

  static bool isValid(String phone) {
    final regex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    return regex.hasMatch(phone) && phone.length >= 8;
  }

  String get formatted => '$countryCode $value';
}
```

### Website

```dart
class Website {
  final String value;

  const Website(this.value);

  factory Website.fromString(String url) {
    if (!isValid(url)) {
      throw InvalidWebsiteException(url);
    }
    return Website(url);
  }

  static bool isValid(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w-./?%&=]*)?$',
    );
    return regex.hasMatch(url);
  }
}
```

### SocialNetwork

```dart
class SocialNetwork {
  final String type;
  final String url;

  const SocialNetwork(this.type, this.url);

  factory SocialNetwork.fromType(String type, String url) {
    if (!isSupportedType(type)) {
      throw UnsupportedSocialNetworkException(type);
    }
    return SocialNetwork(type, url);
  }

  static bool isSupportedType(String type) {
    return supportedTypes.contains(type);
  }

  static const supportedTypes = [
    'facebook', 'instagram', 'linkedin', 'twitter',
    'threads', 'tiktok', 'youtube', 'github',
    'gitlab', 'behance', 'dribbble', 'pinterest',
    'snapchat', 'telegram', 'whatsapp', 'signal',
    'discord', 'reddit', 'medium', 'twitch',
    'mastodon', 'bluesky', 'website', 'other',
  ];
}
```

### Language

```dart
class Language {
  final String code;

  const Language(this.code);

  factory Language.fromString(String code) {
    if (!isValid(code)) {
      throw InvalidLanguageException(code);
    }
    return Language(code);
  }

  static bool isValid(String code) {
    return supportedLanguages.contains(code);
  }

  static const supportedLanguages = [
    'pt', 'en', 'es', 'fr', 'it', 'de', 'ja', 'zh',
  ];
}
```

### ThemeMode

```dart
enum AppThemeMode {
  light,
  dark,
  system;

  factory AppThemeMode.fromString(String mode) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => AppThemeMode.system,
    );
  }
}
```

### CardId

```dart
class CardId {
  final String value;

  const CardId(this.value);

  factory CardId.generate() {
    return CardId(const Uuid().v4());
  }

  factory CardId.fromString(String id) {
    if (!isValid(id)) {
      throw InvalidCardIdException(id);
    }
    return CardId(id);
  }

  static bool isValid(String id) {
    final regex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    );
    return regex.hasMatch(id);
  }
}
```

### Timestamp

```dart
class Timestamp {
  final DateTime value;

  const Timestamp(this.value);

  factory Timestamp.now() {
    return Timestamp(DateTime.now().toUtc());
  }

  factory Timestamp.fromString(String iso) {
    return Timestamp(DateTime.parse(iso));
  }

  String get iso8601 => value.toIso8601String();
}
```

### CountryCode

```dart
class CountryCode {
  final String value;

  const CountryCode(this.value);

  factory CountryCode.fromString(String code) {
    if (!isValid(code)) {
      throw InvalidCountryCodeException(code);
    }
    return CountryCode(code);
  }

  static bool isValid(String code) {
    final regex = RegExp(r'^\+\d{1,3}$');
    return regex.hasMatch(code);
  }

  String get dialCode => value;
}
```

---

## Regras de Uso

| # | Regra |
|---|-------|
| 1 | Value Objects são imutáveis |
| 2 | Value Objects validam dados na criação |
| 3 | Value Objects são comparados por valor, não por referência |
| 4 | Value Objects não possuem identidade |

---

## Documentos Relacionados

- [03_Entities.md](./03_Entities.md)
- [10_ValidationRules.md](./10_ValidationRules.md)
