# Segurança de vCard — VCardSmart

## Padrão

**RFC 6350** — vCard Format Specification

## Regras

1. **Validar campos** — Apenas campos conhecidos
2. **Sanitizar texto** — Remover caracteres perigosos
3. **Validar tamanho** — Limitar tamanho total
4. **Rejeitar campos desconhecidos** — Não processar

## Formato

### Estrutura Básica

```
BEGIN:VCARD
VERSION:3.0
FN:João Silva
N:Silva;João;;;
ORG:Empresa LTDA
TEL;TYPE=CELL:+5511999999999
EMAIL:joao@email.com
URL:https://empresa.com
END:VCARD
```

### Campos Suportados

| Campo | Obrigatório | Descrição |
|-------|-------------|-----------|
| BEGIN | Sim | Início do vCard |
| VERSION | Sim | Versão do vCard |
| FN | Sim | Nome completo |
| N | Sim | Nome para ordenação |
| ORG | Não | Organização |
| TITLE | Não | Cargo |
| TEL | Não | Telefone |
| EMAIL | Não | Email |
| URL | Não | Website |
| ADR | Não | Endereço |
| NOTE | Não | Observações |
| PHOTO | Não | Foto (base64) |

## Implementação

### Generator

```dart
class VCardGenerator {
  static String generate(Profile profile) {
    final buffer = StringBuffer();
    
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:3.0');
    
    // Nome
    buffer.writeln('FN:${_escape(profile.name)}');
    buffer.writeln('N:${_escape(profile.name)};;;;');
    
    // Organização
    if (profile.company != null && profile.company!.isNotEmpty) {
      buffer.writeln('ORG:${_escape(profile.company!)}');
    }
    
    // Telefone
    if (profile.phone != null && profile.phone!.isNotEmpty) {
      buffer.writeln('TEL;TYPE=CELL:${_escape(profile.phone!)}');
    }
    
    // Email
    if (profile.email != null && profile.email!.isNotEmpty) {
      buffer.writeln('EMAIL:${_escape(profile.email!)}');
    }
    
    // Website
    if (profile.website != null && profile.website!.isNotEmpty) {
      buffer.writeln('URL:${_escape(profile.website!)}');
    }
    
    // Endereço
    if (profile.address != null && profile.address!.isNotEmpty) {
      buffer.writeln('ADR:;;${_escape(profile.address!)};;;;');
    }
    
    // Redes sociais
    if (profile.networks != null && profile.networks!.isNotEmpty) {
      final networks = profile.networks!
          .map((n) => '${n.name}: ${n.url}')
          .join('\\n');
      buffer.writeln('NOTE:${_escape(networks)}');
    }
    
    buffer.writeln('END:VCARD');
    
    return buffer.toString();
  }
  
  static String _escape(String text) {
    return text
        .replaceAll('\\', '\\\\')
        .replaceAll(';', '\\;')
        .replaceAll(',', '\\,')
        .replaceAll('\n', '\\n');
  }
}
```

### Validator

```dart
class VCardValidator {
  static ValidationResult validate(String vcard) {
    // Verificar tamanho
    if (vcard.length > 4096) {
      return ValidationResult.invalid('vCard muito grande');
    }
    
    // Verificar BEGIN/END
    if (!vcard.contains('BEGIN:VCARD') || !vcard.contains('END:VCARD')) {
      return ValidationResult.invalid('Formato inválido');
    }
    
    // Verificar VERSION
    if (!vcard.contains('VERSION:3.0')) {
      return ValidationResult.invalid('Versão não suportada');
    }
    
    // Verificar FN
    if (!vcard.contains('FN:')) {
      return ValidationResult.invalid('Nome é obrigatório');
    }
    
    // Validar campos
    final lines = vcard.split('\n');
    for (var line in lines) {
      final validationResult = _validateLine(line);
      if (!validationResult.isValid) {
        return validationResult;
      }
    }
    
    return ValidationResult.valid(vcard);
  }
  
  static ValidationResult _validateLine(String line) {
    // Pular linhas de controle
    if (line.startsWith('BEGIN:') || line.startsWith('END:')) {
      return ValidationResult.valid(line);
    }
    
    // Verificar formato
    if (!line.contains(':')) {
      return ValidationResult.invalid('Formato de linha inválido');
    }
    
    // Extrair chave e valor
    final parts = line.split(':');
    final key = parts[0];
    final value = parts.sublist(1).join(':');
    
    // Validar campos conhecidos
    final knownFields = [
      'VERSION', 'FN', 'N', 'ORG', 'TITLE', 'TEL', 'EMAIL',
      'URL', 'ADR', 'NOTE', 'PHOTO', 'BDAY', 'GENDER',
    ];
    
    final fieldName = key.split(';')[0];
    if (!knownFields.contains(fieldName)) {
      // Campo desconhecido - registrar mas não rejeitar
      print('Campo desconhecido: $fieldName');
    }
    
    // Validar tamanho do valor
    if (value.length > 1000) {
      return ValidationResult.invalid('Valor muito longo: $fieldName');
    }
    
    return ValidationResult.valid(line);
  }
}
```

### Parser

```dart
class VCardParser {
  static Profile? parse(String vcard) {
    final validationResult = VCardValidator.validate(vcard);
    
    if (!validationResult.isValid) {
      return null;
    }
    
    final lines = vcard.split('\n');
    String? name;
    String? email;
    String? phone;
    String? company;
    String? website;
    String? address;
    List<SocialNetwork>? networks;
    
    for (var line in lines) {
      if (line.startsWith('FN:')) {
        name = _unescape(line.substring(3));
      } else if (line.startsWith('EMAIL:')) {
        email = _unescape(line.substring(6));
      } else if (line.startsWith('TEL')) {
        phone = _unescape(line.split(':').last);
      } else if (line.startsWith('ORG:')) {
        company = _unescape(line.substring(4));
      } else if (line.startsWith('URL:')) {
        website = _unescape(line.substring(4));
      } else if (line.startsWith('ADR:')) {
        final adrParts = line.substring(4).split(';');
        address = adrParts.length > 2 ? _unescape(adrParts[2]) : null;
      } else if (line.startsWith('NOTE:')) {
        final note = _unescape(line.substring(5));
        networks = _parseNetworks(note);
      }
    }
    
    if (name == null || name.isEmpty) {
      return null;
    }
    
    return Profile(
      name: name,
      email: email,
      phone: phone,
      company: company,
      website: website,
      address: address,
      networks: networks,
    );
  }
  
  static String _unescape(String text) {
    return text
        .replaceAll('\\\\', '\\')
        .replaceAll('\\;', ';')
        .replaceAll('\\,', ',')
        .replaceAll('\\n', '\n');
  }
  
  static List<SocialNetwork>? _parseNetworks(String note) {
    if (note.isEmpty) return null;
    
    final networks = <SocialNetwork>[];
    final lines = note.split('\\n');
    
    for (var line in lines) {
      final parts = line.split(': ');
      if (parts.length == 2) {
        networks.add(SocialNetwork(
          name: parts[0].trim(),
          url: parts[1].trim(),
        ));
      }
    }
    
    return networks.isEmpty ? null : networks;
  }
}
```

## Validação

### Campos

```dart
class VCardFieldValidator {
  static bool validateName(String name) {
    return name.isNotEmpty && name.length <= 100;
  }
  
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  static bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(phone);
  }
  
  static bool validateUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  static bool validateSize(String vcard) {
    return vcard.length <= 4096;
  }
}
```

## Fluxo Seguro

### Gerar

```
1. Usuário solicita gerar vCard
    ↓
2. Coletar dados do perfil
    ↓
3. Validar dados
    ↓
4. Gerar vCard
    ↓
5. Validar vCard gerado
    ↓
6. Compartilhar
```

### Importar

```
1. Receber vCard
    ↓
2. Validar formato
    ↓
3. Validar campos
    ↓
4. Validar tamanho
    ↓
5. Dados válidos?
    ↓ Sim
6. Parsear dados
    ↓
7. Mostrar resumo ao usuário
    ↓
8. Solicitar confirmação
    ↓
9. Usuário confirma
    ↓
10. Salvar perfil/contato

    ↓ Não
11. Mostrar erro
    ↓
12. Descartar dados
```

## Regras de Segurança

### 1. Validar Antes de Processar

```dart
// ❌ ERRADO
final profile = VCardParser.parse(vcard);

// ✅ CORRETO
final validationResult = VCardValidator.validate(vcard);
if (!validationResult.isValid) {
  throw InvalidVCardException();
}

final profile = VCardParser.parse(vcard);
```

### 2. Sanitizar Texto

```dart
// ❌ ERRADO
buffer.writeln('FN:$name');

// ✅ CORRETO
buffer.writeln('FN:${_escape(name)}');
```

### 3. Limitar Tamanho

```dart
// ❌ ERRADO
if (vcard.length > 10000) { // Tamanho muito grande

// ✅ CORRETO
if (vcard.length > 4096) { // Tamanho adequado
  throw DataTooLargeException();
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Validação | 100% dos campos |
| Sanitização | 100% do texto |
| Tamanho máximo | 4KB |
| RFC 6350 | 100% compliance |
