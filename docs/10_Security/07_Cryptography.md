# Criptografia — VCardSmart

## Algoritmo

| Propriedade | Valor |
|-------------|-------|
| Algoritmo | AES-256-GCM |
| Tamanho da Chave | 256 bits |
| Modo | GCM (Galois/Counter Mode) |
| IV | Gerado aleatoriamente |

## Chaves

### Armazenamento

| Chave | Local | Proteção |
|-------|-------|----------|
| Hive Encryption Key | Flutter Secure Storage | Biometria/PIN |
| PIN Hash | Flutter Secure Storage | Hardware Security |

### Geração

```dart
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CryptoService {
  static Future<Uint8List> generateKey() async {
    // Gerar chave aleatória de 256 bits
    return Hive.generateSecureKey();
  }
  
  static Future<void> storeKey(Uint8List key) async {
    const storage = FlutterSecureStorage();
    
    // Armazenar chave criptografada
    await storage.write(
      key: 'hive_encryption_key',
      value: base64Encode(key),
    );
  }
  
  static Future<Uint8List> retrieveKey() async {
    const storage = FlutterSecureStorage();
    
    final keyBase64 = await storage.read(key: 'hive_encryption_key');
    
    if (keyBase64 == null) {
      // Gerar nova chave
      final key = await generateKey();
      await storeKey(key);
      return key;
    }
    
    return base64Decode(keyBase64);
  }
}
```

## Criptografia em Repouso

### Hive com AES-256

```dart
import 'package:hive_flutter/hive_flutter.dart';

class HiveEncryption {
  static Future<Box> openEncryptedBox(String boxName) async {
    final key = await CryptoService.retrieveKey();
    final cipher = HiveAesCipher(key: key);
    
    return await Hive.openBox(boxName, cipher: cipher);
  }
}
```

### Exemplo de Uso

```dart
// Abrir box criptografado
final box = await HiveEncryption.openEncryptedBox('profiles');

// Salvar dados (automaticamente criptografados)
await box.put('current', profile);

// Ler dados (automaticamente descriptografados)
final profile = box.get('current') as Profile;
```

## Criptografia de Chaves

### Flutter Secure Storage

```dart
class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
  
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
  
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
```

## Hash de PIN

### bcrypt

```dart
import 'package:bcrypt/bcrypt.dart';

class PinService {
  static String hashPin(String pin) {
    // Gerar hash com salt
    return BCrypt.hashpw(pin, BCrypt.gensalt());
  }
  
  static bool verifyPin(String pin, String hash) {
    // Verificar PIN contra hash
    return BCrypt.checkpw(pin, hash);
  }
}
```

## Regras de Segurança

### 1. Nunca Armazenar Chaves em Texto

```dart
// ❌ ERRADO
const key = 'minha-chave-secreta';

// ✅ CORRETO
final key = await SecureStorage.read('encryption_key');
```

### 2. Nunca Hardcode Secrets

```dart
// ❌ ERRADO
const apiKey = 'AIzaSy...';

// ✅ CORRETO
final apiKey = await SecureStorage.read('api_key');
```

### 3. Usar IV Aleatório

```dart
// ❌ ERRADO
final iv = Uint8List(12); // IV fixo

// ✅ CORRETO
final iv = Hive.generateSecureKey(); // IV aleatório
```

### 4. Validar Integridade

```dart
// Sempre validar dados recebidos
if (!DataIntegrity.verifyChecksum(data, checksum)) {
  throw IntegrityException('Dados corrompidos');
}
```

## Rotina de Segurança

### Rotação de Chaves

```dart
// Não implementado inicialmente
// Futura funcionalidade Premium:
// - Backup criptografado
// - Rotação de chaves
// - Sincronização segura
```

## ADRs

- **ADR-025**: Security by Design
- **ADR-028**: Zero Trust Local
