# JSON Schema

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Schema de Compartilhamento

### Estrutura Principal

```json
{
  "version": "1.0",
  "type": "vcardsmart",
  "profile": {
    "id": "uuid-v4",
    "fullName": "Nome Completo",
    "companyName": "Empresa",
    "jobTitle": "Cargo",
    "presentation": "Mensagem de apresentação",
    "photo": "base64...",
    "logo": "base64...",
    "email": "email@exemplo.com",
    "website": "https://exemplo.com",
    "phones": [
      {
        "id": "uuid",
        "label": "Celular",
        "number": "+55 11 99999-9999",
        "countryCode": "+55",
        "share": true,
        "whatsappEnabled": true
      }
    ],
    "socialNetworks": [
      {
        "id": "uuid",
        "type": "instagram",
        "url": "https://instagram.com/usuario",
        "username": "usuario",
        "share": true,
        "order": 1
      }
    ],
    "shareOptions": {
      "shareName": true,
      "shareCompany": true,
      "sharePosition": true,
      "sharePresentation": true,
      "sharePhoto": true,
      "shareLogo": true,
      "sharePhones": true,
      "shareEmail": true,
      "shareWebsite": true,
      "shareSocialNetworks": true
    }
  },
  "metadata": {
    "timestamp": "2026-07-13T00:00:00Z",
    "deviceId": "uuid-do-dispositivo",
    "appVersion": "1.0.0"
  }
}
```

---

## Schema de Cartão Recebido

```json
{
  "id": "uuid-v4",
  "fullName": "Nome",
  "companyName": "Empresa",
  "jobTitle": "Cargo",
  "email": "email@exemplo.com",
  "phones": [],
  "socialNetworks": [],
  "receivedAt": "2026-07-13T00:00:00Z",
  "source": "nfc",
  "rawVcard": "BEGIN:VCARD..."
}
```

---

## Campos

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `version` | String | ✅ | Versão do schema |
| `type` | String | ✅ | Tipo ("vcardsmart") |
| `profile` | Object | ✅ | Dados do perfil |
| `metadata` | Object | ✅ | Metadados |

---

## Validação

```dart
class JsonSchemaValidator {
  static bool validate(Map<String, dynamic> json) {
    if (json['version'] == null) return false;
    if (json['type'] != 'vcardsmart') return false;
    if (json['profile'] == null) return false;
    if (json['profile']['fullName'] == null) return false;
    if (json['profile']['email'] == null) return false;
    return true;
  }
}
```

---

## Documentos Relacionados

- [05_DTOs.md](./05_DTOs.md)
- [07_VCardSchema.md](./07_VCardSchema.md)
- [19_Versioning.md](./19_Versioning.md)
