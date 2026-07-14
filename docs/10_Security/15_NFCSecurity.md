# Segurança de NFC — VCardSmart

## Princípios

1. **Validar Payload** — Sempre validar dados recebidos
2. **Versionar Payload** — Formato versionado
3. **Confirmar Envio** — Sempre com confirmação
4. **Confirmar Recebimento** — Sempre com validação
5. **Cancelar Permitido** — Usuário pode cancelar a qualquer momento
6. **Sem Execução Automática** — Dados nunca executados automaticamente

## Formato do Payload

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
  "checksum": "abc123...",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Versão

| Versão | Formato | Status |
|--------|---------|--------|
| 1 | JSON simples | ✅ Atual |
| 2 | JSON com criptografia | 🔄 Futuro |

## Implementação

### Service

```dart
import 'package:nfc_manager/nfc_manager.dart';

class NfcService {
  static Future<bool> isAvailable() async {
    return await NfcManager.instance.isAvailable();
  }
  
  static Future<void> startSession({
    required void Function(NfcTag) onDiscovered,
    required void Function(String) onError,
  }) async {
    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          onDiscovered(tag);
        },
        onError: (error) async {
          onError(error.toString());
        },
      );
    } catch (e) {
      onError(e.toString());
    }
  }
  
  static Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }
  
  static Future<bool> write({
    required NfcTag tag,
    required String data,
  }) async {
    try {
      final ndef = Ndef.from(tag);
      if (ndef == null) {
        return false;
      }
      
      if (!ndef.isWritable) {
        return false;
      }
      
      final message = NdefMessage([
        NdefRecord.createUri(Uri.parse('vcardsmart://vcard')),
        NdefRecord.createText(data),
      ]);
      
      await ndef.write(message);
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

### Generator

```dart
class NfcPayloadGenerator {
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
      'timestamp': DateTime.now().toIso8601String(),
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

### Validator

```dart
class NfcPayloadValidator {
  static ValidationResult validate(String payload) {
    try {
      final data = jsonDecode(payload);
      
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
      
      // Verificar timestamp
      if (data['timestamp'] != null) {
        final timestamp = DateTime.parse(data['timestamp']);
        final now = DateTime.now();
        
        // Verificar se não é muito antigo (24 horas)
        if (now.difference(timestamp).inHours > 24) {
          return ValidationResult.invalid('Dados muito antigos');
        }
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
class NfcPayloadParser {
  static Profile? parse(String payload) {
    final validationResult = NfcPayloadValidator.validate(payload);
    
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

### Enviar

```
1. Usuário seleciona "Compartilhar via NFC"
    ↓
2. Verificar disponibilidade NFC
    ↓
3. NFC disponível?
    ↓ Sim
4. Gerar payload
    ↓
5. Validar payload
    ↓
6. Mostrar resumo ao usuário
    ↓
7. Solicitar confirmação
    ↓
8. Usuário confirma
    ↓
9. Iniciar sessão NFC
    ↓
10. Aguardar detecção de tag
    ↓
11. Escrever payload
    ↓
12. Confirmar sucesso

    ↓ Não
13. Oferecer alternativa (QR Code/vCard)
```

### Receber

```
1. NFC detecta tag
    ↓
2. Ler payload
    ↓
3. Validar payload
    ↓
4. Payload válido?
    ↓ Sim
5. Parsear dados
    ↓
6. Mostrar resumo ao usuário
    ↓
7. Solicitar confirmação
    ↓
8. Usuário confirma
    ↓
9. Salvar perfil/contato
    ↓
10. Confirmar sucesso

    ↓ Não
11. Mostrar erro
    ↓
12. Descartar dados
```

## Validação de Entrada

### Sanitização

```dart
class NfcSanitizer {
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

### 1. Nunca Executar Dados

```dart
// ❌ ERRADO
eval(nfcData);

// ✅ CORRETO
final data = jsonDecode(nfcData);
```

### 2. Sempre Validar

```dart
// ❌ ERRADO
final profile = jsonDecode(nfcData);

// ✅ CORRETO
final validationResult = NfcPayloadValidator.validate(nfcData);
if (!validationResult.isValid) {
  throw InvalidDataException();
}
```

### 3. Sempre Confirmar

```dart
// ❌ ERRADO
await saveProfile(profile);

// ✅ CORRETO
final confirmed = await showDialog(
  context: context,
  builder: (context) => ImportDialog(profile: profile),
);

if (confirmed) {
  await saveProfile(profile);
}
```

### 4. Limitar Tamanho

```dart
// ❌ ERRADO
if (nfcData.length > 10000) { // Tamanho muito grande

// ✅ CORRETO
if (nfcData.length > 4096) { // Tamanho adequado
  throw DataTooLargeException();
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Validação | 100% dos payloads |
| Confirmação | 100% das operações |
| Checksum | Sempre verificado |
| Tamanho máximo | 4KB |
| Timeout | 30 segundos |
