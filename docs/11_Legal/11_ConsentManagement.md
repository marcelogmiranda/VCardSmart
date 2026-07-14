# Gestão de Consentimento — VCardSmart

## Consentimentos Necessários

| Consentimento | Obrigatório | Finalidade |
|---------------|-------------|------------|
| Compartilhar dados | Sim | Compartilhar perfil |
| Atualizar agenda | Não | Salvar contatos |
| Importar contatos | Não | Carregar da agenda |
| Utilizar biometria | Não | Autenticação |
| Exibir anúncios | Sim | Anúncios não personalizados |

## Implementação

### Service

```dart
class ConsentService {
  static const _boxName = 'consents';
  
  static Future<Box> _getBox() async {
    return await HiveService.openEncryptedBox(_boxName);
  }
  
  // Registrar consentimento
  static Future<void> register({
    required String type,
    required bool granted,
    required String purpose,
  }) async {
    final box = await _getBox();
    
    final consent = {
      'type': type,
      'granted': granted,
      'timestamp': DateTime.now().toIso8601String(),
      'purpose': purpose,
    };
    
    await box.put(type, consent);
  }
  
  // Verificar consentimento
  static Future<bool> hasConsent(String type) async {
    final box = await _getBox();
    final consent = box.get(type) as Map?;
    
    if (consent == null) return false;
    
    return consent['granted'] == true;
  }
  
  // Revogar consentimento
  static Future<void> revoke(String type) async {
    final box = await _getBox();
    await box.delete(type);
  }
  
  // Revogar todos
  static Future<void> revokeAll() async {
    final box = await _getBox();
    await box.clear();
  }
  
  // Obter todos
  static Future<Map<String, dynamic>> getAll() async {
    final box = await _getBox();
    return Map<String, dynamic>.from(box.toMap());
  }
}
```

### Provider

```dart
final consentProvider = StateNotifierProvider<ConsentNotifier, Map<String, bool>>((ref) {
  return ConsentNotifier();
});

class ConsentNotifier extends StateNotifier<Map<String, bool>> {
  ConsentNotifier() : super({}) {
    _loadConsents();
  }
  
  Future<void> _loadConsents() async {
    final consents = await ConsentService.getAll();
    state = consents.map((key, value) => MapEntry(key, value['granted'] == true));
  }
  
  Future<void> grant(String type) async {
    await ConsentService.register(
      type: type,
      granted: true,
      purpose: _getPurpose(type),
    );
    state = {...state, type: true};
  }
  
  Future<void> revoke(String type) async {
    await ConsentService.revoke(type);
    state = {...state, type: false};
  }
  
  String _getPurpose(String type) {
    switch (type) {
      case 'share':
        return 'Compartilhar perfil';
      case 'contacts':
        return 'Salvar contatos na agenda';
      case 'import_contacts':
        return 'Importar contatos da agenda';
      case 'biometric':
        return 'Autenticação biométrica';
      case 'ads':
        return 'Exibir anúncios não personalizados';
      default:
        return 'Finalidade desconhecida';
    }
  }
}
```

### UI - Dialog de Consentimento

```dart
class ConsentDialog extends ConsumerWidget {
  final String type;
  final String title;
  final String description;
  final VoidCallback? onGranted;
  final VoidCallback? onRevoked;
  
  const ConsentDialog({
    required this.type,
    required this.title,
    required this.description,
    this.onGranted,
    this.onRevoked,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasConsent = ref.watch(consentProvider)[type] ?? false;
    
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description),
          SizedBox(height: 16),
          if (hasConsent)
            Text(
              'Consentimento concedido',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(consentProvider.notifier).revoke(type);
            onRevoked?.call();
            Navigator.pop(context);
          },
          child: hasConsent ? Text('Revogar') : Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(consentProvider.notifier).grant(type);
            onGranted?.call();
            Navigator.pop(context);
          },
          child: Text(hasConsent ? 'Confirmar' : 'Conceder'),
        ),
      ],
    );
  }
}
```

## Fluxo de Consentimento

### Compartilhar

```
1. Usuário toca em "Compartilhar"
    ↓
2. Verificar consentimento
    ↓
3. Consentimento concedido?
    ↓ Sim
4. Prosseguir com compartilhamento

    ↓ Não
5. Mostrar dialog de consentimento
    ↓
6. Usuário concede?
    ↓ Sim
7. Registrar consentimento
    ↓
8. Prosseguir com compartilhamento

    ↓ Não
9. Cancelar operação
```

### Importar Contatos

```
1. Usuário toca em "Importar"
    ↓
2. Verificar consentimento
    ↓
3. Consentimento concedido?
    ↓ Sim
4. Solicitar permissão da câmera

    ↓ Não
5. Mostrar dialog de consentimento
    ↓
6. Usuário concede?
    ↓ Sim
7. Registrar consentimento
    ↓
8. Solicitar permissão da câmera

    ↓ Não
9. Cancelar operação
```

## Revogação

### Pelo Usuário

```dart
// Acessar configurações de consentimento
class ConsentSettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consents = ref.watch(consentProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações de Consentimento'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Compartilhar dados'),
            subtitle: Text('Permitir compartilhamento de perfil'),
            value: consents['share'] ?? false,
            onChanged: (value) {
              if (value) {
                ref.read(consentProvider.notifier).grant('share');
              } else {
                ref.read(consentProvider.notifier).revoke('share');
              }
            },
          ),
          SwitchListTile(
            title: Text('Importar contatos'),
            subtitle: Text('Importar contatos da agenda'),
            value: consents['import_contacts'] ?? false,
            onChanged: (value) {
              if (value) {
                ref.read(consentProvider.notifier).grant('import_contacts');
              } else {
                ref.read(consentProvider.notifier).revoke('import_contacts');
              }
            },
          ),
          // ... outros consentimentos
        ],
      ),
    );
  }
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Consentimento | 100% explícito |
| Revogação | Sempre disponível |
| Registro | 100% documentado |
| Transparência | 100% |

## ADR

**ADR-027**: Consentimento Obrigatório

> Toda ação que compartilhe dados, importe contatos, altere a agenda ou substitua informações existentes deverá exigir confirmação explícita do usuário.
