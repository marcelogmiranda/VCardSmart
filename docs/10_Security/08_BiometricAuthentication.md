# Autenticação Biométrica — VCardSmart

## Suporte

| Plataforma | Tecnologia | Status |
|------------|------------|--------|
| iOS | Face ID | ✅ Suportado |
| iOS | Touch ID | ✅ Suportado |
| Android | Fingerprint | ✅ Suportado |
| Android | Android Biometrics | ✅ Suportado |

## Fallback

```
Biometria
    ↓ (falha)
PIN
    ↓ (falha)
Bloqueio
```

## Implementação

### Service

```dart
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _localAuth = LocalAuthentication();
  
  // Verificar disponibilidade
  static Future<bool> isAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }
  
  // Listar biometrias disponíveis
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }
  
  // Autenticar
  static Future<bool> authenticate({
    String localizedReason = 'Autentique-se para acessar',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }
  
  // Cancelar autenticação
  static Future<void> stopAuthentication() async {
    await _localAuth.stopAuthentication();
  }
}
```

### Provider

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  return BiometricService.isAvailable();
});

final biometricEnabledProvider = StateProvider<bool>((ref) => false);
```

### UI

```dart
class BiometricToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAvailable = ref.watch(biometricAvailableProvider);
    final isEnabled = ref.watch(biometricEnabledProvider);
    
    return isAvailable.when(
      data: (available) {
        if (!available) return SizedBox.shrink();
        
        return SwitchListTile(
          title: Text('Biometria'),
          subtitle: Text('Use Face ID ou Fingerprint'),
          value: isEnabled,
          onChanged: (value) async {
            if (value) {
              // Solicitar autenticação para habilitar
              final authenticated = await BiometricService.authenticate(
                localizedReason: 'Habilite a biometria',
              );
              
              if (authenticated) {
                ref.read(biometricEnabledProvider.notifier).state = true;
              }
            } else {
              ref.read(biometricEnabledProvider.notifier).state = false;
            }
          },
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (_, __) => SizedBox.shrink(),
    );
  }
}
```

## Fluxo de Autenticação

### Habilitar Biometria

```
1. Usuário ativa toggle
    ↓
2. Solicitar autenticação
    ↓
3. Biometria reconhecida?
    ↓ Sim
4. Salvar preferência
    ↓
5. Biometria habilitada

    ↓ Não
6. Mostrar erro
    ↓
7. Biometria não habilitada
```

### Usar Biometria

```
1. App inicia ou retorna do fundo
    ↓
2. Biometria habilitada?
    ↓ Sim
3. Solicitar autenticação
    ↓
4. Biometria reconhecida?
    ↓ Sim
5. Acesso liberado

    ↓ Não
6. Fallback para PIN
```

## Configurações

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

### iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>NSFaceIDUsageDescription</key>
<string>Use Face ID para acessar o aplicativo</string>
```

## Segurança

### Regras

1. **Nunca armazenar dados biométricos** — Apenas o sistema operacional
2. **Sempre oferecer fallback** — PIN como alternativa
3. **Timeout de sessão** — Re-autenticação após inatividade
4. **Limite de tentativas** — Sistema operacional gerencia

### Validação

```dart
// Verificar antes de usar
if (!await BiometricService.isAvailable()) {
  // Fallback para PIN
  return await PinService.authenticate();
}

// Autenticar
final authenticated = await BiometricService.authenticate();
if (!authenticated) {
  // Fallback para PIN
  return await PinService.authenticate();
}

return true;
```

## Métricas

| Métrica | Meta |
|---------|------|
| Disponibilidade | Detectar automaticamente |
| Fallback | Sempre disponível |
| Timeout | Configurável (padrão: 5min) |
| UX | Fluido e rápido |
