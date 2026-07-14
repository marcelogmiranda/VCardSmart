# Segurança do Hive — VCardSmart

## Visão Geral

Hive é o armazenamento local principal do aplicativo, com criptografia AES-256.

## Configuração Segura

### Inicialização

```dart
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Registrar adaptadores
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(SettingsAdapter());
  }
  
  static Future<Box> openEncryptedBox(String name) async {
    final key = await HiveKeyService.getKey();
    final cipher = HiveAesCipher(key: key);
    
    return await Hive.openBox(name, cipher: cipher);
  }
}
```

### Criptografia

```dart
class HiveEncryption {
  static Future<HiveAesCipher> getCipher() async {
    final key = await HiveKeyService.getKey();
    return HiveAesCipher(key: key);
  }
}
```

## Boxes Seguras

### Box: profiles

```dart
class ProfileBox {
  static const String _boxName = 'profiles';
  static Box? _box;
  
  static Future<Box> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    
    _box = await HiveService.openEncryptedBox(_boxName);
    return _box!;
  }
  
  static Future<void> save(Profile profile) async {
    final box = await _getBox();
    await box.put('current', profile);
  }
  
  static Future<Profile?> get() async {
    final box = await _getBox();
    return box.get('current') as Profile?;
  }
  
  static Future<void> delete() async {
    final box = await _getBox();
    await box.delete('current');
  }
  
  static Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }
}
```

### Box: contacts

```dart
class ContactBox {
  static const String _boxName = 'contacts';
  static Box? _box;
  
  static Future<Box> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    
    _box = await HiveService.openEncryptedBox(_boxName);
    return _box!;
  }
  
  static Future<void> save(Contact contact) async {
    final box = await _getBox();
    await box.put(contact.id, contact);
  }
  
  static Future<List<Contact>> getAll() async {
    final box = await _getBox();
    return box.values.cast<Contact>().toList();
  }
  
  static Future<void> delete(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }
  
  static Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }
}
```

### Box: settings

```dart
class SettingsBox {
  static const String _boxName = 'settings';
  static Box? _box;
  
  static Future<Box> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    
    _box = await HiveService.openEncryptedBox(_boxName);
    return _box!;
  }
  
  static Future<void> save(Settings settings) async {
    final box = await _getBox();
    await box.put('settings', settings);
  }
  
  static Future<Settings?> get() async {
    final box = await _getBox();
    return box.get('settings') as Settings?;
  }
  
  static Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }
}
```

## Validação

### Integridade

```dart
class HiveValidation {
  static Future<bool> validateBox(String boxName) async {
    try {
      final box = await Hive.openBox(boxName);
      
      // Verificar se box pode ser lida
      for (var key in box.keys) {
        final value = box.get(key);
        if (value == null) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

### Versionamento

```dart
class HiveVersioning {
  static const int _currentVersion = 1;
  
  static Future<void> migrate() async {
    final settingsBox = await HiveService.openEncryptedBox('settings');
    final version = settingsBox.get('schema_version') ?? 0;
    
    if (version < _currentVersion) {
      await _migrateToVersion(version, _currentVersion);
      await settingsBox.put('schema_version', _currentVersion);
    }
  }
  
  static Future<void> _migrateToVersion(int from, int to) async {
    // Migração segura
    if (from < 1) {
      // Migração v0 -> v1
    }
  }
}
```

## Migração Segura

### Processo

```
1. Backup dos dados atuais
    ↓
2. Criar nova versão da box
    ↓
3. Migrar dados
    ↓
4. Validar dados migrados
    ↓
5. Deletar box antiga
    ↓
6. Renomear nova box
```

### Implementação

```dart
class HiveMigration {
  static Future<void> migrateBox({
    required String oldBoxName,
    required String newBoxName,
    required dynamic Function(dynamic) transformer,
  }) async {
    // Backup
    final oldBox = await Hive.openBox(oldBoxName);
    final backup = Map.from(oldBox.toMap());
    
    try {
      // Criar nova box
      final newBox = await HiveService.openEncryptedBox(newBoxName);
      
      // Migrar dados
      for (var entry in backup.entries) {
        final migrated = transformer(entry.value);
        await newBox.put(entry.key, migrated);
      }
      
      // Validar
      if (newBox.length != backup.length) {
        throw Exception('Migração falhou');
      }
      
      // Deletar box antiga
      await oldBox.close();
      await Hive.deleteBoxFromDisk(oldBoxName);
      
    } catch (e) {
      // Restaurar backup
      final box = await Hive.openBox(oldBoxName);
      await box.clear();
      await box.putAll(backup);
      
      throw e;
    }
  }
}
```

## Regras de Segurança

### 1. Sempre Criptografar

```dart
// ❌ ERRADO
final box = await Hive.openBox('profiles');

// ✅ CORRETO
final box = await HiveService.openEncryptedBox('profiles');
```

### 2. Validar Dados

```dart
// ❌ ERRADO
await box.put('profile', rawData);

// ✅ CORRETO
final profile = ProfileMapper.fromJson(rawData);
await box.put('profile', profile);
```

### 3. Tratar Erros

```dart
// ❌ ERRADO
final box = await Hive.openBox('profiles');

// ✅ CORRETO
try {
  final box = await HiveService.openEncryptedBox('profiles');
} catch (e) {
  // Fallback seguro
  await _handleError(e);
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Criptografia | AES-256 |
| Boxes | Todas criptografadas |
| Validação | 100% dos dados |
| Migração | Testada em staging |
