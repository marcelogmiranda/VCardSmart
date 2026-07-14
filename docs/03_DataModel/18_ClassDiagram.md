# Class Diagram

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Diagrama de Classes

```mermaid
classDiagram
    class UserProfile {
        +String id
        +int version
        +String fullName
        +String companyName
        +String jobTitle
        +String presentation
        +String? photoPath
        +String? logoPath
        +String email
        +String? website
        +List~Phone~ phones
        +List~SocialNetwork~ socialNetworks
        +String preferredLanguage
        +ThemeMode themeMode
        +ShareOptions shareOptions
        +SecurityOptions securityOptions
        +DateTime createdAt
        +DateTime updatedAt
        +String schemaVersion
    }

    class Phone {
        +String id
        +String label
        +String number
        +String countryCode
        +bool share
        +bool whatsappEnabled
    }

    class SocialNetwork {
        +String id
        +SocialNetworkType type
        +String url
        +String? username
        +bool share
        +int order
    }

    class ShareOptions {
        +bool shareName
        +bool shareCompany
        +bool sharePosition
        +bool sharePresentation
        +bool sharePhoto
        +bool shareLogo
        +bool sharePhones
        +bool shareEmail
        +bool shareWebsite
        +bool shareSocialNetworks
    }

    class SecurityOptions {
        +bool biometricEnabled
        +bool pinEnabled
        +bool autoLock
        +int lockTimeout
        +bool hideScreenshots
        +bool requireAuthenticationOnStart
    }

    class ReceivedCard {
        +String id
        +String fullName
        +String? companyName
        +String? jobTitle
        +String email
        +List~Phone~ phones
        +List~SocialNetwork~ socialNetworks
        +String? photoPath
        +DateTime receivedAt
        +String source
        +String? rawVcard
    }

    class ShareOptionsDTO {
        +bool shareName
        +bool shareCompany
        +toEntity() ShareOptions
        +fromEntity() ShareOptionsDTO
    }

    class ProfileDTO {
        +String id
        +String fullName
        +toEntity() UserProfile
        +fromEntity() ProfileDTO
    }

    class VCardGenerator {
        +generate(UserProfile) String
    }

    class VCardValidator {
        +validate(String) bool
    }

    class JsonSchemaValidator {
        +validate(Map) bool
    }

    UserProfile "1" *-- "0..*" Phone : contains
    UserProfile "1" *-- "0..*" SocialNetwork : contains
    UserProfile "1" *-- "1" ShareOptions : has
    UserProfile "1" *-- "1" SecurityOptions : has
    ReceivedCard "1" *-- "0..*" Phone : contains
    ReceivedCard "1" *-- "0..*" SocialNetwork : contains
    ProfileDTO --> UserProfile : converts
    ShareOptionsDTO --> ShareOptions : converts
```

---

## Hierarquia de Classes

```
Entity
├── UserProfile
├── Phone
├── SocialNetwork
├── ShareOptions
├── SecurityOptions
└── ReceivedCard

DTO
├── ProfileDTO
├── PhoneDTO
├── SocialNetworkDTO
├── ShareOptionsDTO
├── SecurityOptionsDTO
├── VCardDTO
└── ShareDTO

Service
├── VCardGenerator
├── VCardValidator
├── JsonSchemaValidator
└── MigrationService
```

---

## Visualização no VS Code

Os diagramas Mermaid podem ser visualizados no VS Code com a extensão **Mermaid Preview**.

---

## Documentos Relacionados

- [03_Entities.md](./03_Entities.md)
- [05_DTOs.md](./05_DTOs.md)
- [17_ERDiagram.md](./17_ERDiagram.md)
