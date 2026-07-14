# Autenticação por PIN — VCardSmart

## Especificação

| Propriedade | Valor |
|-------------|-------|
| Tamanho | 4 a 8 dígitos |
| Hash | bcrypt |
| Tentativas | 5 máximo |
| Timeout | 5 minutos após falhas |
| Alteração | Mediante autenticação |

## Implementação

### Service

```dart
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  static const _storage = FlutterSecureStorage();
  static const _maxAttempts = 5;
  static const _lockoutDuration = Duration(minutes: 5);
  
  // Verificar se PIN está configurado
  static Future<bool> isPinConfigured() async {
    final pinHash = await _storage.read(key: 'pin_hash');
    return pinHash != null;
  }
  
  // Configurar PIN
  static Future<void> setupPin(String pin) async {
    final hash = BCrypt.hashpw(pin, BCrypt.gensalt());
    await _storage.write(key: 'pin_hash', value: hash);
    await _storage.write(key: 'pin_attempts', value: '0');
  }
  
  // Verificar PIN
  static Future<bool> verifyPin(String pin) async {
    // Verificar bloqueio
    if (await _isLockedOut()) {
      return false;
    }
    
    final hash = await _storage.read(key: 'pin_hash');
    if (hash == null) {
      return false;
    }
    
    final isValid = BCrypt.checkpw(pin, hash);
    
    if (isValid) {
      await _resetAttempts();
      return true;
    } else {
      await _incrementAttempts();
      return false;
    }
  }
  
  // Alterar PIN
  static Future<bool> changePin(String currentPin, String newPin) async {
    // Verificar PIN atual
    if (!await verifyPin(currentPin)) {
      return false;
    }
    
    // Configurar novo PIN
    await setupPin(newPin);
    return true;
  }
  
  // Remover PIN
  static Future<bool> removePin(String pin) async {
    if (!await verifyPin(pin)) {
      return false;
    }
    
    await _storage.delete(key: 'pin_hash');
    await _storage.delete(key: 'pin_attempts');
    await _storage.delete(key: 'pin_lockout_until');
    return true;
  }
  
  // Verificar bloqueio
  static Future<bool> _isLockedOut() async {
    final lockoutUntil = await _storage.read(key: 'pin_lockout_until');
    if (lockoutUntil == null) return false;
    
    final lockout = DateTime.parse(lockoutUntil);
    if (DateTime.now().isBefore(lockout)) {
      return true;
    }
    
    // Bloqueio expirou
    await _storage.delete(key: 'pin_lockout_until');
    await _resetAttempts();
    return false;
  }
  
  // Incrementar tentativas
  static Future<void> _incrementAttempts() async {
    final attempts = await _storage.read(key: 'pin_attempts') ?? '0';
    final newAttempts = int.parse(attempts) + 1;
    
    await _storage.write(key: 'pin_attempts', value: newAttempts.toString());
    
    if (newAttempts >= _maxAttempts) {
      final lockoutUntil = DateTime.now().add(_lockoutDuration);
      await _storage.write(
        key: 'pin_lockout_until',
        value: lockoutUntil.toIso8601String(),
      );
    }
  }
  
  // Resetar tentativas
  static Future<void> _resetAttempts() async {
    await _storage.write(key: 'pin_attempts', value: '0');
    await _storage.delete(key: 'pin_lockout_until');
  }
  
  // Obter tentativas restantes
  static Future<int> getRemainingAttempts() async {
    final attempts = await _storage.read(key: 'pin_attempts') ?? '0';
    return _maxAttempts - int.parse(attempts);
  }
}
```

### Provider

```dart
final pinConfiguredProvider = FutureProvider<bool>((ref) async {
  return PinService.isPinConfigured();
});

final pinEnabledProvider = StateProvider<bool>((ref) => false);
```

### UI

```dart
class PinSetupScreen extends ConsumerStatefulWidget {
  @override
  _PinSetupScreenState createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurar PIN'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'PIN (4-8 dígitos)',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Confirmar PIN',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _setupPin,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _setupPin() async {
    final pin = _pinController.text;
    final confirm = _confirmController.text;
    
    if (pin.length < 4 || pin.length > 8) {
      // Mostrar erro
      return;
    }
    
    if (pin != confirm) {
      // Mostrar erro
      return;
    }
    
    await PinService.setupPin(pin);
    Navigator.pop(context);
  }
}
```

## Fluxo

### Configurar PIN

```
1. Usuário acessa configurações
    ↓
2. Seleciona "Configurar PIN"
    ↓
3. Digita PIN (4-8 dígitos)
    ↓
4. Confirma PIN
    ↓
5. PIN salvo com hash
    ↓
6. PIN habilitado
```

### Verificar PIN

```
1. App solicita autenticação
    ↓
2. Usuário digita PIN
    ↓
3. PIN verificado contra hash
    ↓
4. Válido?
    ↓ Sim
5. Acesso liberado
    ↓ Não
6. Incrementar tentativas
    ↓
7. Tentativas restantes > 0?
    ↓ Sim
8. Solicitar novamente

    ↓ Não
9. Conta bloqueada por 5 minutos
```

## Segurança

### Hash

```dart
// Gerar hash
final hash = BCrypt.hashpw('1234', BCrypt.gensalt());

// Verificar PIN
final isValid = BCrypt.checkpw('1234', hash);
```

### Armazenamento

```dart
// Armazenar hash em Secure Storage
await storage.write(key: 'pin_hash', value: hash);
```

### Regras

1. **Nunca armazenar PIN em texto** — Apenas hash
2. **Salt aleatório** — bcrypt gera automaticamente
3. **Tentativas limitadas** — 5 máximo
4. **Bloqueio temporário** — 5 minutos
5. **Alteração segura** — Exige PIN atual

## Configurações

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

### iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>NSFaceIDUsageDescription</key>
<string>Use Face ID para acessar o aplicativo</string>
```
