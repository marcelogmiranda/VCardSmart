# DTOs (Data Transfer Objects)

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## O que são DTOs

DTOs são objetos usados para transferência de dados entre camadas. Eles isolam a representação de dados do banco da representação de negócio.

---

## ProfileDTO

```dart
class ProfileDTO {
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
  final List<PhoneDTO> phones;
  final List<SocialNetworkDTO> socialNetworks;
  final String preferredLanguage;
  final String themeMode;
  final ShareOptionsDTO shareOptions;
  final SecurityOptionsDTO securityOptions;
  final String createdAt;
  final String updatedAt;
  final String schemaVersion;

  // To Entity
  UserProfile toEntity() {
    return UserProfile(
      id: id,
      version: version,
      fullName: fullName,
      companyName: companyName,
      jobTitle: jobTitle,
      presentation: presentation,
      photoPath: photoPath,
      logoPath: logoPath,
      email: email,
      website: website,
      phones: phones.map((p) => p.toEntity()).toList(),
      socialNetworks: socialNetworks.map((s) => s.toEntity()).toList(),
      preferredLanguage: preferredLanguage,
      themeMode: AppThemeMode.fromString(themeMode),
      shareOptions: shareOptions.toEntity(),
      securityOptions: securityOptions.toEntity(),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      schemaVersion: schemaVersion,
    );
  }

  // From Entity
  factory ProfileDTO.fromEntity(UserProfile entity) {
    return ProfileDTO(
      id: entity.id,
      version: entity.version,
      fullName: entity.fullName,
      companyName: entity.companyName,
      jobTitle: entity.jobTitle,
      presentation: entity.presentation,
      photoPath: entity.photoPath,
      logoPath: entity.logoPath,
      email: entity.email,
      website: entity.website,
      phones: entity.phones.map((p) => PhoneDTO.fromEntity(p)).toList(),
      socialNetworks: entity.socialNetworks.map((s) => SocialNetworkDTO.fromEntity(s)).toList(),
      preferredLanguage: entity.preferredLanguage,
      themeMode: entity.themeMode.name,
      shareOptions: ShareOptionsDTO.fromEntity(entity.shareOptions),
      securityOptions: SecurityOptionsDTO.fromEntity(entity.securityOptions),
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
      schemaVersion: entity.schemaVersion,
    );
  }
}
```

---

## PhoneDTO

```dart
class PhoneDTO {
  final String id;
  final String label;
  final String number;
  final String countryCode;
  final bool share;
  final bool whatsappEnabled;

  Phone toEntity() => Phone(
    id: id,
    label: label,
    number: number,
    countryCode: countryCode,
    share: share,
    whatsappEnabled: whatsappEnabled,
  );

  factory PhoneDTO.fromEntity(Phone entity) => PhoneDTO(
    id: entity.id,
    label: entity.label,
    number: entity.number,
    countryCode: entity.countryCode,
    share: entity.share,
    whatsappEnabled: entity.whatsappEnabled,
  );
}
```

---

## SocialNetworkDTO

```dart
class SocialNetworkDTO {
  final String id;
  final String type;
  final String url;
  final String? username;
  final bool share;
  final int order;

  SocialNetwork toEntity() => SocialNetwork(
    id: id,
    type: type,
    url: url,
    username: username,
    share: share,
    order: order,
  );

  factory SocialNetworkDTO.fromEntity(SocialNetwork entity) => SocialNetworkDTO(
    id: entity.id,
    type: entity.type,
    url: entity.url,
    username: entity.username,
    share: entity.share,
    order: entity.order,
  );
}
```

---

## ShareOptionsDTO

```dart
class ShareOptionsDTO {
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

  ShareOptions toEntity() => ShareOptions(
    shareName: shareName,
    shareCompany: shareCompany,
    // ...
  );

  factory ShareOptionsDTO.fromEntity(ShareOptions entity) => ShareOptionsDTO(
    shareName: entity.shareName,
    shareCompany: entity.shareCompany,
    // ...
  );
}
```

---

## SecurityOptionsDTO

```dart
class SecurityOptionsDTO {
  final bool biometricEnabled;
  final bool pinEnabled;
  final bool autoLock;
  final int lockTimeout;
  final bool hideScreenshots;
  final bool requireAuthenticationOnStart;

  SecurityOptions toEntity() => SecurityOptions(
    biometricEnabled: biometricEnabled,
    pinEnabled: pinEnabled,
    // ...
  );

  factory SecurityOptionsDTO.fromEntity(SecurityOptions entity) => SecurityOptionsDTO(
    biometricEnabled: entity.biometricEnabled,
    pinEnabled: entity.pinEnabled,
    // ...
  );
}
```

---

## VCardDTO

```dart
class VCardDTO {
  final String version;
  final String fullName;
  final String? organization;
  final String? title;
  final List<String> phones;
  final String email;
  final String? url;
  final String? photo;
  final String? logo;
  final String? note;

  String toVCardString() {
    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:$version');
    buffer.writeln('FN:$fullName');
    if (organization != null) buffer.writeln('ORG:$organization');
    if (title != null) buffer.writeln('TITLE:$title');
    for (final phone in phones) {
      buffer.writeln('TEL;TYPE=CELL:$phone');
    }
    buffer.writeln('EMAIL:$email');
    if (url != null) buffer.writeln('URL:$url');
    if (photo != null) buffer.writeln('PHOTO;ENCODING=b;TYPE=JPEG:$photo');
    if (logo != null) buffer.writeln('LOGO;ENCODING=b;TYPE=JPEG:$logo');
    if (note != null) buffer.writeln('NOTE:$note');
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }
}
```

---

## JSON DTO

```dart
class ShareDTO {
  final String type;
  final String version;
  final ProfileDTO profile;
  final ShareMetadataDTO metadata;

  Map<String, dynamic> toJson() => {
    'type': type,
    'version': version,
    'profile': profile.toJson(),
    'metadata': metadata.toJson(),
  };

  factory ShareDTO.fromJson(Map<String, dynamic> json) => ShareDTO(
    type: json['type'],
    version: json['version'],
    profile: ProfileDTO.fromJson(json['profile']),
    metadata: ShareMetadataDTO.fromJson(json['metadata']),
  );
}
```

---

## Regras de Uso

| # | Regra |
|---|-------|
| 1 | DTOs são usados apenas para transferência de dados |
| 2 | Conversão sempre via toEntity() / fromEntity() |
| 3 | DTOs não possuem lógica de negócio |
| 4 | DTOs são usados para serialização JSON |

---

## Documentos Relacionados

- [03_Entities.md](./03_Entities.md)
- [06_JSONSchema.md](./06_JSONSchema.md)
- [07_VCardSchema.md](./07_VCardSchema.md)
