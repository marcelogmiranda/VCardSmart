# Secure Storage — VCardSmart

## Tecnologia

**Flutter Secure Storage** — Armazenamento seguro nativo

| Plataforma | Implementação |
|------------|---------------|
| Android | EncryptedSharedPreferences (AES-256) |
| iOS | Keychain (AES-256) |

## O que Armazenar

| Dado | Uso |
|------|-----|
| Hive Key | Chave de criptografia do Hive |
| PIN Hash | Hash bcrypt do PIN |
| Preferências Críticas | Configurações sensíveis |

## O que NUNCA Armazenar

| Dado | Motivo |
|------|--------|
| Dados do perfil | Usar Hive |
| Contatos | Usar Hive |
| Configurações gerais | Usar Hive |
| Dados de cartão | Nunca armazenar |

## Implementação

### Service

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  // Escrita
  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }
  
  // Leitura
  static Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }
  
  // Exclusão
  static Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }
  
  // Excluir tudo
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  // Verificar se existe
  static Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }
  
  // Ler todas as chaves
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
```

### Uso para Chave Hive

```dart
class HiveKeyService {
  static const _keyName = 'hive_encryption_key';
  
  static Future<Uint8List> getKey() async {
    final keyBase64 = await SecureStorageService.read(key: _keyName);
    
    if (keyBase64 == null) {
      // Gerar nova chave
      final key = Hive.generateSecureKey();
      await SecureStorageService.write(
        key: _keyName,
        value: base64Encode(key),
      );
      return key;
    }
    
    return base64Decode(keyBase64);
  }
  
  static Future<void> deleteKey() async {
    await SecureStorageService.delete(key: _keyName);
  }
}
```

### Uso para PIN

```dart
class PinStorageService {
  static const _pinHashKey = 'pin_hash';
  static const _pinAttemptsKey = 'pin_attempts';
  static const _pinLockoutKey = 'pin_lockout_until';
  
  static Future<void> savePinHash(String hash) async {
    await SecureStorageService.write(key: _pinHashKey, value: hash);
  }
  
  static Future<String?> getPinHash() async {
    return await SecureStorageService.read(key: _pinHashKey);
  }
  
  static Future<void> saveAttempts(int attempts) async {
    await SecureStorageService.write(
      key: _pinAttemptsKey,
      value: attempts.toString(),
    );
  }
  
  static Future<int> getAttempts() async {
    final attempts = await SecureStorageService.read(key: _pinAttemptsKey);
    return int.parse(attempts ?? '0');
  }
  
  static Future<void> saveLockoutUntil(DateTime until) async {
    await SecureStorageService.write(
      key: _pinLockoutKey,
      value: until.toIso8601String(),
    );
  }
  
  static Future<DateTime?> getLockoutUntil() async {
    final until = await SecureStorageService.read(key: _pinLockoutKey);
    return until != null ? DateTime.parse(until) : null;
  }
  
  static Future<void> clearAll() async {
    await SecureStorageService.delete(key: _pinHashKey);
    await SecureStorageService.delete(key: _pinAttemptsKey);
    await SecureStorageService.delete(key: _pinLockoutKey);
  }
}
```

## Configuração

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

### iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>KeychainAccessibility</key>
<string>FirstUnlockThisDevice</string>
```

## Segurança

### Regras

1. **Nunca expor dados** — Apenas via service
2. **Nunca logar dados** — Sem prints de valores
3. **Validar input** — Verificar tipos e tamanhos
4. **Tratar erros** — Fallback seguro
5. **Limpar dados** — deleteAll quando necessário

### Validação

```dart
// Validar antes de salvar
if (key.isEmpty || value.isEmpty) {
  throw ArgumentError('Chave e valor não podem ser vazios');
}

// Validar tamanho
if (value.length > 4096) {
  throw ArgumentError('Valor muito grande');
}
```

## Migração

### Versão 1.0.0

```dart
// Chaves iniciais
const keys = [
  'hive_encryption_key',
  'pin_hash',
  'pin_attempts',
  'pin_lockout_until',
];
```

### Versões Futuras

```dart
// Adicionar novas chaves conforme necessário
// Manter compatibilidade com versões anteriores
```

## Métricas

| Métrica | Meta |
|---------|------|
| Dados armazenados | Apenas secrets |
| Criptografia | AES-256 |
| Acesso | Biometria/PIN |
| Limpeza | deleteAll disponível |
