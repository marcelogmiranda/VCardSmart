# ER Diagram

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Diagrama ER

```mermaid
erDiagram
    USER_PROFILE {
        string id PK
        int version
        string fullName
        string companyName
        string jobTitle
        string presentation
        string photoPath
        string logoPath
        string email UK
        string website
        string preferredLanguage
        string themeMode
        string schemaVersion
        datetime createdAt
        datetime updatedAt
    }

    PHONE {
        string id PK
        string label
        string number
        string countryCode
        bool share
        bool whatsappEnabled
    }

    SOCIAL_NETWORK {
        string id PK
        string type
        string url
        string username
        bool share
        int order
    }

    SHARE_OPTIONS {
        bool shareName
        bool shareCompany
        bool sharePosition
        bool sharePresentation
        bool sharePhoto
        bool shareLogo
        bool sharePhones
        bool shareEmail
        bool shareWebsite
        bool shareSocialNetworks
    }

    SECURITY_OPTIONS {
        bool biometricEnabled
        bool pinEnabled
        bool autoLock
        int lockTimeout
        bool hideScreenshots
        bool requireAuthenticationOnStart
    }

    RECEIVED_CARD {
        string id PK
        string fullName
        string companyName
        string jobTitle
        string email
        datetime receivedAt
        string source
        string rawVcard
    }

    HISTORY {
        string id PK
        string action
        string method
        string targetId
        datetime timestamp
    }

    USER_PROFILE ||--o{ PHONE : "has phones"
    USER_PROFILE ||--o{ SOCIAL_NETWORK : "has socials"
    USER_PROFILE ||--|| SHARE_OPTIONS : "has share options"
    USER_PROFILE ||--|| SECURITY_OPTIONS : "has security options"
    USER_PROFILE ||--o{ HISTORY : "generates history"
    RECEIVED_CARD ||--o{ PHONE : "has phones"
    RECEIVED_CARD ||--o{ SOCIAL_NETWORK : "has socials"
```

---

## Entidades e Relacionamentos

| Entidade | Relacionamento | Entidade | Cardinalidade |
|----------|---------------|----------|---------------|
| USER_PROFILE | has | PHONE | 1:N |
| USER_PROFILE | has | SOCIAL_NETWORK | 1:N |
| USER_PROFILE | has | SHARE_OPTIONS | 1:1 |
| USER_PROFILE | has | SECURITY_OPTIONS | 1:1 |
| USER_PROFILE | generates | HISTORY | 1:N |
| RECEIVED_CARD | has | PHONE | 1:N |
| RECEIVED_CARD | has | SOCIAL_NETWORK | 1:N |

---

## Visualização no VS Code

Os diagramas Mermaid podem ser visualizados no VS Code com a extensão **Mermaid Preview**.

---

## Documentos Relacionados

- [03_Entities.md](./03_Entities.md)
- [09_Relationships.md](./09_Relationships.md)
- [18_ClassDiagram.md](./18_ClassDiagram.md)
