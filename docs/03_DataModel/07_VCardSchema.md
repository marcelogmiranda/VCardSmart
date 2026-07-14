# vCard Schema

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Padrão

| Propriedade | Valor |
|-------------|-------|
| **Formato** | vCard 4.0 |
| **RFC** | RFC 6350 |
| **Extensão** | .vcf |

---

## Estrutura vCard

```
BEGIN:VCARD
VERSION:4.0
FN:Nome Completo
ORG:Empresa
TITLE:Cargo
TEL;TYPE=CELL:+55 11 99999-9999
EMAIL:email@exemplo.com
URL:https://exemplo.com
PHOTO;ENCODING=b;TYPE=JPEG:base64...
LOGO;ENCODING=b;TYPE=JPEG:base64...
NOTE:Mensagem de apresentação
END:VCARD
```

---

## Campos

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `FN` | String | ✅ | Nome completo |
| `ORG` | String | ❌ | Empresa |
| `TITLE` | String | ❌ | Cargo |
| `TEL` | String | ✅ | Telefone(s) |
| `EMAIL` | String | ✅ | E-mail |
| `URL` | String | ❌ | Website |
| `PHOTO` | Base64 | ❌ | Foto |
| `LOGO` | Base64 | ❌ | Logotipo |
| `NOTE` | String | ❌ | Observações |

---

## Geração

### Uso no Código
```dart
class VCardGenerator {
  static String generate(UserProfile profile) {
    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:4.0');
    buffer.writeln('FN:${profile.fullName}');
    if (profile.companyName.isNotEmpty) {
      buffer.writeln('ORG:${profile.companyName}');
    }
    if (profile.jobTitle.isNotEmpty) {
      buffer.writeln('TITLE:${profile.jobTitle}');
    }
    for (final phone in profile.phones) {
      if (phone.share) {
        buffer.writeln('TEL;TYPE=CELL:${phone.countryCode} ${phone.number}');
      }
    }
    if (profile.shareOptions.shareEmail) {
      buffer.writeln('EMAIL:${profile.email}');
    }
    if (profile.website != null && profile.shareOptions.shareWebsite) {
      buffer.writeln('URL:${profile.website}');
    }
    if (profile.photoPath != null && profile.shareOptions.sharePhoto) {
      buffer.writeln('PHOTO;ENCODING=b;TYPE=JPEG:${profile.photoPath}');
    }
    if (profile.logoPath != null && profile.shareOptions.shareLogo) {
      buffer.writeln('LOGO;ENCODING=b;TYPE=JPEG:${profile.logoPath}');
    }
    if (profile.presentation.isNotEmpty) {
      buffer.writeln('NOTE:${profile.presentation}');
    }
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }
}
```

---

## Validação

```dart
class VCardValidator {
  static bool validate(String vcard) {
    if (!vcard.contains('BEGIN:VCARD')) return false;
    if (!vcard.contains('END:VCARD')) return false;
    if (!vcard.contains('VERSION:4.0')) return false;
    if (!vcard.contains('FN:')) return false;
    return true;
  }
}
```

---

## Compatibilidade

| Plataforma | vCard 3.0 | vCard 4.0 |
|------------|-----------|-----------|
| Android | ✅ | ✅ |
| iOS | ✅ | ✅ |
| Google Contacts | ✅ | ✅ |
| Apple Contacts | ✅ | ✅ |
| Outlook | ✅ | ✅ |

---

## Documentos Relacionados

- [06_JSONSchema.md](./06_JSONSchema.md)
- [05_DTOs.md](./05_DTOs.md)
- [11_VCardArchitecture.md](../04_Architecture/11_VCardArchitecture.md)
