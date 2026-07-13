# vCard Architecture

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

## Campos vCard

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| `FN` | ✅ | Nome completo |
| `ORG` | ❌ | Empresa |
| `TITLE` | ❌ | Cargo |
| `TEL` | ✅ | Telefone |
| `EMAIL` | ✅ | E-mail |
| `URL` | ❌ | Website |
| `PHOTO` | ❌ | Foto (base64) |
| `LOGO` | ❌ | Logotipo (base64) |
| `NOTE` | ❌ | Observações |

---

## Formato vCard

### Exemplo
```
BEGIN:VCARD
VERSION:4.0
FN:João Silva
ORG:Empresa Exemplo
TITLE:CEO
TEL;TYPE=CELL:+55 11 99999-9999
EMAIL:joao@exemplo.com
URL:https://exemplo.com
NOTE:Cartão profissional
END:VCARD
```

---

## Geração

### Uso no Código
```dart
class VCardGenerator {
  static String generate(UserProfile profile) {
    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:3.0');
    buffer.writeln('FN:${profile.name}');
    if (profile.company != null) {
      buffer.writeln('ORG:${profile.company}');
    }
    if (profile.position != null) {
      buffer.writeln('TITLE:${profile.position}');
    }
    buffer.writeln('TEL;TYPE=CELL:${profile.phone}');
    buffer.writeln('EMAIL:${profile.email}');
    if (profile.website != null) {
      buffer.writeln('URL:${profile.website}');
    }
    if (profile.photo != null) {
      buffer.writeln('PHOTO;ENCODING=b;TYPE=JPEG:${profile.photo}');
    }
    if (profile.logo != null) {
      buffer.writeln('LOGO;ENCODING=b;TYPE=JPEG:${profile.logo}');
    }
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }
}
```

---

## Compatibilidade

| Plataforma | Importação | Exportação |
|------------|------------|------------|
| Android | ✅ | ✅ |
| iOS | ✅ | ✅ |
| Google Contacts | ✅ | ✅ |
| Apple Contacts | ✅ | ✅ |
| Outlook | ✅ | ✅ |

---

## Validação

### Campos Obrigatórios
- ✅ FN (nome completo)
- ✅ Pelo menos um TEL ou EMAIL

### Validação
```dart
class VCardValidator {
  static bool validate(String vcard) {
    if (!vcard.contains('BEGIN:VCARD')) return false;
    if (!vcard.contains('END:VCARD')) return false;
    if (!vcard.contains('VERSION:3.0')) return false;
    if (!vcard.contains('FN:')) return false;
    return true;
  }
}
```

---

## Tratamento de Erros

| Erro | Ação |
|------|------|
| vCard inválido | Rejeitar e informar |
| Campos faltantes | Aceitar parcialmente |
| Encoding inválido | Tentar corrigir |
| Versão incompatível | Aceitar vCard 2.1 e 3.0 |

---

## Documentos Relacionados

- [11_VCardArchitecture.md](./11_VCardArchitecture.md)
- [09_NFCArchitecture.md](./09_NFCArchitecture.md)
- [10_QRCodeArchitecture.md](./10_QRCodeArchitecture.md)
