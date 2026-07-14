# Segurança de QR Code — VCardSmart

## Princípios

1. **Offline** — Sem URLs externas
2. **Sem JavaScript** — Apenas dados estáticos
3. **Sem comandos** — Apenas informações
4. **Validação** — Sempre validar dados recebidos
5. **Checksum** — Verificar integridade
6. **Versionamento** — Formato versionado

## Formato do QR Code

### Estrutura

```json
{
  "version": 1,
  "type": "vcard",
  "data": {
    "name": "João Silva",
    "email": "joao@email.com",
    "phone": "+5511999999999",
    "company": "Empresa LTDA"
  },
  "checksum": "abc123..."
}
```

### Versão

| Versão | Formato | Status |
|--------|---------|--------|
| 1 | JSON simples | ✅ Atual |
| 2 | JSON com criptografia | 🔄 Futuro |

## Implementação

### Geração

```dart
class QrCodeGenerator {
  static String generate(Profile profile) {
    final data = {
      'version': 1,
      'type': 'vcard',
      'data': {
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
        'company': profile.company,
        'website': profile.website,
        'address': profile.address,
        'networks': profile.networks
            .map((n) => {'name': n.name, 'url': n.url})
            .toList(),
      },
    };
    
    // Gerar checksum
    final checksum = _calculateChecksum(data);
    data['checksum'] = checksum;
    
    return jsonEncode(data);
  }
  
  static String _calculateChecksum(Map<String, dynamic> data) {
    final json = jsonEncode(data);
    return sha256.convert(utf8.encode(json)).toString();
  }
}
```

### Validação

```dart
class QrCodeValidator {
  static ValidationResult validate(String qrData) {
    try {
      final data = jsonDecode(qrData);
      
      // Verificar versão
      if (data['version'] == null) {
        return ValidationResult.invalid('Versão não encontrada');
      }
      
      if (data['version'] > 1) {
        return ValidationResult.invalid('Versão não suportada');
      }
      
      // Verificar tipo
      if (data['type'] != 'vcard') {
        return ValidationResult.invalid('Tipo inválido');
      }
      
      // Verificar dados
      if (data['data'] == null) {
        return ValidationResult.invalid('Dados não encontrados');
      }
      
      // Validar campos
      final validationResult = _validateFields(data['data']);
      if (!validationResult.isValid) {
        return validationResult;
      }
      
      // Verificar checksum
      if (data['checksum'] != null) {
        final calculatedChecksum = _calculateChecksum(data['data']);
        if (data['checksum'] != calculatedChecksum) {
          return ValidationResult.invalid('Checksum inválido');
        }
      }
      
      return ValidationResult.valid(data['data']);
      
    } catch (e) {
      return ValidationResult.invalid('Formato inválido');
    }
  }
  
  static ValidationResult _validateFields(Map<String, dynamic> data) {
    // Validar nome
    if (data['name'] == null || data['name'].toString().isEmpty) {
      return ValidationResult.invalid('Nome é obrigatório');
    }
    
    if (data['name'].toString().length > 100) {
      return ValidationResult.invalid('Nome muito longo');
    }
    
    // Validar email (opcional)
    if (data['email'] != null && data['email'].toString().isNotEmpty) {
      if (!isValidEmail(data['email'].toString())) {
        return ValidationResult.invalid('Email inválido');
      }
    }
    
    // Validar telefone (opcional)
    if (data['phone'] != null && data['phone'].toString().isNotEmpty) {
      if (!isValidPhone(data['phone'].toString())) {
        return ValidationResult.invalid('Telefone inválido');
      }
    }
    
    // Validar tamanho total
    final jsonSize = utf8.encode(jsonEncode(data)).length;
    if (jsonSize > 4096) {
      return ValidationResult.invalid('Dados muito grandes');
    }
    
    return ValidationResult.valid(data);
  }
  
  static String _calculateChecksum(Map<String, dynamic> data) {
    final json = jsonEncode(data);
    return sha256.convert(utf8.encode(json)).toString();
  }
}
```

### Parser

```dart
class QrCodeParser {
  static Profile? parse(String qrData) {
    final validationResult = QrCodeValidator.validate(qrData);
    
    if (!validationResult.isValid) {
      return null;
    }
    
    final data = validationResult.data;
    
    return Profile(
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      company: data['company'],
      website: data['website'],
      address: data['address'],
      networks: (data['networks'] as List?)
          ?.map((n) => SocialNetwork(
                name: n['name'],
                url: n['url'],
              ))
          .toList(),
    );
  }
}
```

## Fluxo Seguro

### Geração

```
1. Usuário solicita gerar QR Code
    ↓
2. Coletar dados do perfil
    ↓
3. Validar dados
    ↓
4. Gerar checksum
    ↓
5. Criar JSON
    ↓
6. Gerar imagem QR
    ↓
7. Exibir ao usuário
```

### Leitura

```
1. Câmera detecta QR Code
    ↓
2. Extrair dados do QR
    ↓
3. Validar formato
    ↓
4. Validar campos
    ↓
5. Verificar checksum
    ↓
6. Dados válidos?
    ↓ Sim
7. Mostrar resumo ao usuário
    ↓
8. Solicitar confirmação
    ↓
9. Usuário confirma
    ↓
10. Salvar perfil

    ↓ Não
11. Mostrar erro
    ↓
12. Descartar dados
```

## Validação de Entrada

### Sanitização

```dart
class QrSanitizer {
  static String sanitize(String input) {
    // Remover caracteres perigosos
    return input
        .replaceAll(RegExp(r'<script[^>]*>.*?</script>'), '')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'javascript:'), '')
        .replaceAll(RegExp(r'on\w+="[^"]*"'), '');
  }
  
  static Map<String, dynamic> sanitizeData(Map<String, dynamic> data) {
    final sanitized = <String, dynamic>{};
    
    for (var entry in data.entries) {
      if (entry.value is String) {
        sanitized[entry.key] = sanitize(entry.value);
      } else if (entry.value is Map) {
        sanitized[entry.key] = sanitizeData(entry.value);
      } else if (entry.value is List) {
        sanitized[entry.key] = entry.value.map((item) {
          if (item is String) return sanitize(item);
          if (item is Map) return sanitizeData(item);
          return item;
        }).toList();
      } else {
        sanitized[entry.key] = entry.value;
      }
    }
    
    return sanitized;
  }
}
```

## Regras de Segurança

### 1. Nunca Executar Código

```dart
// ❌ ERRADO
eval(qrData);

// ✅ CORRETO
final data = jsonDecode(qrData);
```

### 2. Sempre Validar

```dart
// ❌ ERRADO
final profile = jsonDecode(qrData);

// ✅ CORRETO
final validationResult = QrCodeValidator.validate(qrData);
if (!validationResult.isValid) {
  throw InvalidDataException();
}
```

### 3. Limitar Tamanho

```dart
// ❌ ERRADO
if (qrData.length > 10000) { // Tamanho muito grande

// ✅ CORRETO
if (qrData.length > 4096) { // Tamanho adequado
  throw DataTooLargeException();
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Validação | 100% dos dados |
| Sanitização | 100% dos inputs |
| Checksum | Sempre verificado |
| Tamanho máximo | 4KB |
