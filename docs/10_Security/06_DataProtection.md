# Proteção de Dados — VCardSmart

## Fluxo de Proteção

```
Dados do Usuário
    ↓
Hive (AES-256)
    ↓
Flutter Secure Storage
    ↓
Biometria (opcional)
    ↓
PIN (opcional)
```

## Camadas de Proteção

### Camada 1: Armazenamento Criptografado

**Tecnologia**: Hive com AES-256

```dart
// Inicialização do Hive com criptografia
Future<void> initHive() async {
  final key = await SecureStorageService.getEncryptionKey();
  final cipher = HiveAesCipher(key: key);
  
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());
  
  await Hive.openBox('profiles', cipher: cipher);
}
```

### Camada 2: Chaves Seguras

**Tecnologia**: Flutter Secure Storage

```dart
// Armazenamento da chave de criptografia
class SecureStorageService {
  static Future<Uint8List> getEncryptionKey() async {
    const storage = FlutterSecureStorage();
    
    String? keyBase64 = await storage.read(key: 'hive_key');
    
    if (keyBase64 == null) {
      // Gerar nova chave
      final key = Hive.generateSecureKey();
      await storage.write(
        key: 'hive_key',
        value: base64Encode(key),
      );
      return key;
    }
    
    return base64Decode(keyBase64);
  }
}
```

### Camada 3: Autenticação

**Tecnologia**: Biometria + PIN

```dart
// Verificação de autenticação
Future<bool> authenticate() async {
  // Tentar biometria
  if (await LocalAuth.canCheckBiometrics) {
    return await LocalAuth.authenticate(
      localizedReason: 'Autentique-se para acessar',
    );
  }
  
  // Fallback para PIN
  return await verifyPin();
}
```

## Dados Protegidos

### Dados do Perfil

| Campo | Criptografado | Armazenamento |
|-------|---------------|---------------|
| Nome | ✅ | Hive |
| Email | ✅ | Hive |
| Telefone | ✅ | Hive |
| Empresa | ✅ | Hive |
| Website | ✅ | Hive |
| Endereço | ✅ | Hive |
| Redes Sociais | ✅ | Hive |
| Foto | ✅ | Hive |

### Dados de Autenticação

| Dado | Criptografado | Armazenamento |
|------|---------------|---------------|
| Chave Hive | ✅ | Secure Storage |
| PIN Hash | ✅ | Secure Storage |
| Biometria Habilitada | ✅ | Secure Storage |

### Configurações

| Config | Criptografado | Armazenamento |
|--------|---------------|---------------|
| Tema | ✅ | Hive |
| Idioma | ✅ | Hive |
| Biometria | ✅ | Hive |
| PIN | ✅ | Hive |

## Regras de Proteção

### 1. Criptografia Obrigatória

```dart
// NUNCA armazenar dados sem criptografia
await box.put('profile', profile); // ❌ ERRADO

// SEMPRE usar box criptografado
final encryptedBox = await Hive.openBox('profiles', cipher: cipher);
await encryptedBox.put('profile', profile); // ✅ CORRETO
```

### 2. Chaves Nunca em Texto

```dart
// NUNCA armazenar chaves em texto plano
const key = 'minha-chave-secreta'; // ❌ ERRADO

// SEMPRE usar Secure Storage
await storage.write(key: 'key', value: encryptedValue); // ✅ CORRETO
```

### 3. Dados Nunca em Logs

```dart
// NUNCA logar dados sensíveis
print('Perfil: ${profile.name}'); // ❌ ERRADO

// SEMPRE logar de forma segura
print('Perfil carregado com sucesso'); // ✅ CORRETO
```

## Validação de Integridade

### Versionamento

```dart
class Profile {
  final String version;
  final DateTime updatedAt;
  
  // Versionamento para migração segura
}
```

### Checksum

```dart
class DataIntegrity {
  static String calculateChecksum(dynamic data) {
    final json = jsonEncode(data);
    return sha256.convert(utf8.encode(json)).toString();
  }
  
  static bool verifyChecksum(dynamic data, String checksum) {
    return calculateChecksum(data) == checksum;
  }
}
```
