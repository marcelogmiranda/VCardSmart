# Política de Atualizações — VCardSmart

## Regra Principal

**Atualizações somente pelas lojas oficiais.**

## O que o App PODE Fazer

### Informar sobre Atualização

```dart
// Verificar versão disponível
Future<void> checkForUpdates() async {
  final currentVersion = await getCurrentVersion();
  final latestVersion = await getLatestVersion();
  
  if (latestVersion > currentVersion) {
    showUpdateDialog();
  }
}

// Mostrar diálogo de atualização
void showUpdateDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Atualização Disponível'),
      content: Text('Existe uma nova versão disponível.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Agora Não'),
        ),
        ElevatedButton(
          onPressed: () => openStore(),
          child: Text('Atualizar'),
        ),
      ],
    ),
  );
}

// Abrir loja
Future<void> openStore() async {
  final url = Platform.isAndroid
      ? 'market://details?id=com.vcardsmart'
      : 'https://apps.apple.com/app/idYOUR_APP_ID';
  
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}
```

## O que o App NUNCA PODE Fazer

### ❌ Atualização Interna (In-App Update)

```dart
// NUNCA fazer isso
void downloadUpdate() {
  // Baixar APK de servidor próprio
  // Instalar atualização
  // Reiniciar app
}
```

### ❌ Download de APKs

```dart
// NUNCA fazer isso
void downloadApk() {
  // Baixar APK de site de terceiros
  // Instalar manualmente
}
```

### ❌ Instalar Versões Externas

```dart
// NUNCA fazer isso
void installExternalVersion() {
  // Instalar versão de fonte não oficial
}
```

## Implementação

### Service

```dart
class UpdateService {
  static Future<bool> checkForUpdates() async {
    try {
      final currentVersion = await _getCurrentVersion();
      final latestVersion = await _getLatestVersion();
      
      return latestVersion > currentVersion;
    } catch (e) {
      return false;
    }
  }
  
  static Future<void> openStore() async {
    final url = Platform.isAndroid
        ? 'market://details?id=com.vcardsmart'
        : 'https://apps.apple.com/app/idYOUR_APP_ID';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
```

### Provider

```dart
final updateProvider = FutureProvider<bool>((ref) async {
  return UpdateService.checkForUpdates();
});
```

### UI

```dart
class UpdateBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUpdate = ref.watch(updateProvider);
    
    return hasUpdate.when(
      data: (hasUpdate) {
        if (!hasUpdate) return SizedBox.shrink();
        
        return MaterialBanner(
          content: Text('Nova versão disponível'),
          actions: [
            TextButton(
              onPressed: () => UpdateService.openStore(),
              child: Text('Atualizar'),
            ),
          ],
        );
      },
      loading: () => SizedBox.shrink(),
      error: (_, __) => SizedBox.shrink(),
    );
  }
}
```

## ADR

**ADR-024**: Atualizações Exclusivamente pelas Lojas

> O aplicativo nunca executará atualização interna (in-app update próprio).
> Poderá apenas informar ao usuário que existe uma nova versão disponível, direcionando-o à respectiva loja.
