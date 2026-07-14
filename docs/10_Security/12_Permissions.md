# Permissões — VCardSmart

## Modelo de Permissões

| Permissão | Obrigatória | Justificativa | Uso |
|-----------|-------------|---------------|-----|
| Câmera | Sim | Leitura de QR Code | Escanear QR Code |
| NFC | Opcional | Compartilhamento NFC | Ler/Escrever NFC |
| Contatos | Opcional | Salvar na agenda | Exportar contatos |
| Biometria | Opcional | Proteção do aplicativo | Autenticação |
| Internet | Sim | Anúncios e atualização | Google Ads + Versão |

## Regras de Permissão

### 1. Solicitação Sob Demanda

```dart
// ❌ ERRADO - Solicitar todas no início
@override
void initState() {
  super.initState();
  _requestAllPermissions(); // ❌ ERRADO
}

// ✅ CORRETO - Solicitar quando necessário
Future<void> scanQrCode() async {
  final status = await Permission.camera.request();
  if (status.isGranted) {
    // Usar câmera
  }
}
```

### 2. Justificativa Clara

```dart
// Sempre explicar ao usuário
Future<void> requestCameraPermission() async {
  final status = await Permission.camera.request();
  
  if (status.isPermanentlyDenied) {
    // Mostrar como habilitar nas configurações
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permissão Necessária'),
        content: Text(
          'Para escanear QR Codes, precisamos de acesso à câmera. '
          'Por favor, habilite nas configurações do dispositivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => openAppSettings(),
            child: Text('Configurações'),
          ),
        ],
      ),
    );
  }
}
```

### 3. Possibilidade de Negar

```dart
// Sempre oferecer alternativa
Future<void> shareViaQrCode() async {
  final status = await Permission.camera.request();
  
  if (status.isGranted) {
    // Escanear QR Code
  } else {
    // Oferecer alternativa
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Câmera Indisponível'),
        content: Text(
          'Sem acesso à câmera, você pode compartilhar via:'
        ),
        actions: [
          TextButton(
            onPressed: () => shareViaNfc(),
            child: Text('NFC'),
          ),
          TextButton(
            onPressed: () => shareViaVCard(),
            child: Text('vCard'),
          ),
        ],
      ),
    );
  }
}
```

### 4. Revogação Permitida

```dart
// Permitir revogar a qualquer momento
Future<void> revokeCameraPermission() async {
  await Permission.camera驳请求();
}
```

## Implementação

### Service

```dart
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Câmera
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
  
  static Future<bool> isCameraGranted() async {
    return await Permission.camera.isGranted;
  }
  
  // NFC
  static Future<bool> requestNfc() async {
    // NFC não requer permissão no Android
    // No iOS, verificar disponibilidade
    return true;
  }
  
  // Contatos
  static Future<bool> requestContacts() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
  
  static Future<bool> isContactsGranted() async {
    return await Permission.contacts.isGranted;
  }
  
  // Biometria
  static Future<bool> requestBiometric() async {
    final status = await Permission生物计量.request();
    return status.isGranted;
  }
  
  // Verificar todas
  static Future<Map<String, bool>> checkAll() async {
    return {
      'camera': await isCameraGranted(),
      'contacts': await isContactsGranted(),
    };
  }
}
```

### Provider

```dart
final cameraPermissionProvider = FutureProvider<bool>((ref) async {
  return PermissionService.isCameraGranted();
});

final contactsPermissionProvider = FutureProvider<bool>((ref) async {
  return PermissionService.isContactsGranted();
});
```

## Configuração

### Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.NFC" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>NSCameraUsageDescription</key>
<string>Para escanear QR Codes</string>

<key>NSContactsUsageDescription</key>
<string>Para salvar contatos na agenda</string>

<key>NSFaceIDUsageDescription</key>
<string>Para autenticação biométrica</string>
```

## Fluxo de Permissão

### Câmera (QR Code)

```
1. Usuário toca em "Escanear QR Code"
    ↓
2. Verificar permissão atual
    ↓
3. Concedida?
    ↓ Sim
4. Abrir câmera

    ↓ Não
5. Solicitar permissão
    ↓
6. Concedida?
    ↓ Sim
7. Abrir câmera

    ↓ Não
8. Permanently denied?
    ↓ Sim
9. Mostrar como habilitar nas configurações

    ↓ Não
10. Oferecer alternativa (NFC/vCard)
```

### Contatos (Exportar)

```
1. Usuário toca em "Exportar para Agenda"
    ↓
2. Verificar permissão atual
    ↓
3. Concedida?
    ↓ Sim
4. Listar contatos

    ↓ Não
5. Solicitar permissão
    ↓
6. Concedida?
    ↓ Sim
7. Listar contatos

    ↓ Não
8. Oferecer alternativa (vCard)
```

## Métricas

| Métrica | Meta |
|---------|------|
| Permissões obrigatórias | Mínimo necessário |
| Justificativa | Sempre exibida |
| Alternativas | Sempre oferecidas |
| Revogação | Sempre permitida |
