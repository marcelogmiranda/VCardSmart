# Conformidade LGPD — VCardSmart

## Base Legal

### Consentimento

> O tratamento de dados pessoais é baseado no consentimento explícito do titular.

**Implementação**:
- Confirmação explícita para todas as ações
- Registro de consentimento
- Possibilidade de revogação

### Finalidade

> Os dados são tratados para finalidade específica e legítima.

**Implementação**:
- Dados usados apenas para perfil
- Sem uso para marketing
- Sem uso para analytics

### Necessidade

> Apenas os dados estritamente necessários são coletados.

**Implementação**:
- Campos opcionais claramente marcados
- Sem dados de telemetria
- Sem metadados

## Direitos do Titular

### 1. Acesso

> O titular tem direito de acessar seus dados.

**Implementação**:
- Dados sempre acessíveis no dispositivo
- Visualização completa do perfil
- Exportação em formatos padrão

### 2. Correção

> O titular pode corrigir seus dados.

**Implementação**:
- Edição permitida a qualquer momento
- Validação em tempo real
- Feedback imediato

### 3. Exclusão

> O titular pode excluir seus dados.

**Implementação**:
- Exclusão completa dos dados
- Confirmação obrigatória
- Irreversível

### 4. Portabilidade

> O titular pode transferir seus dados.

**Implementação**:
- Exportação em vCard
- Exportação em JSON
- Formatos padrão

### 5. Informação

> O titular deve ser informado sobre o tratamento.

**Implementação**:
- Política de privacidade clara
- Fluxos transparentes
- Feedback em tempo real

### 6. Consentimento

> O consentimento deve ser livre e informado.

**Implementação**:
- Sempre explícito
- Sempre informado
- Sempre granular
- Sempre revogável

## Implementação

### Exportação de Dados

```dart
class LGPDService {
  // Exportar dados do usuário
  static Future<String> exportData() async {
    final profile = await ProfileBox.get();
    final contacts = await ContactBox.getAll();
    final settings = await SettingsBox.get();
    
    final data = {
      'profile': profile?.toJson(),
      'contacts': contacts.map((c) => c.toJson()).toList(),
      'settings': settings?.toJson(),
      'exportDate': DateTime.now().toIso8601String(),
    };
    
    return jsonEncode(data);
  }
  
  // Excluir todos os dados
  static Future<void> deleteAllData() async {
    await ProfileBox.clear();
    await ContactBox.clear();
    await SettingsBox.clear();
    await SecureStorageService.deleteAll();
  }
}
```

### UI de Exclusão

```dart
class DeleteAllDataDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Excluir Todos os Dados'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Esta ação é irreversível.',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Todos os seus dados serão permanentemente excluídos. '
            'Esta ação não pode ser desfeita.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () async {
            await LGPDService.deleteAllData();
            Navigator.pop(context);
          },
          child: Text('Excluir Tudo'),
        ),
      ],
    );
  }
}
```

## Registro de Consentimento

### Estrutura

```json
{
  "userId": "user-001",
  "consents": [
    {
      "type": "camera",
      "granted": true,
      "timestamp": "2024-01-15T10:30:00Z",
      "purpose": "Leitura de QR Code"
    },
    {
      "type": "contacts",
      "granted": true,
      "timestamp": "2024-01-15T10:35:00Z",
      "purpose": "Salvar na agenda"
    }
  ]
}
```

### Implementação

```dart
class ConsentService {
  static Future<void> registerConsent({
    required String type,
    required bool granted,
    required String purpose,
  }) async {
    final consent = {
      'type': type,
      'granted': granted,
      'timestamp': DateTime.now().toIso8601String(),
      'purpose': purpose,
    };
    
    final box = await HiveService.openEncryptedBox('consents');
    await box.put(type, consent);
  }
  
  static Future<bool> hasConsent(String type) async {
    final box = await HiveService.openEncryptedBox('consents');
    final consent = box.get(type) as Map?;
    
    if (consent == null) return false;
    
    return consent['granted'] == true;
  }
  
  static Future<void> revokeConsent(String type) async {
    final box = await HiveService.openEncryptedBox('consents');
    await box.delete(type);
  }
}
```

## Checklist LGPD

### Dados

- [ ] Sem coleta de dados
- [ ] Sem envio de dados
- [ ] Sem compartilhamento com terceiros
- [ ] Sem analytics
- [ ] Sem telemetria
- [ ] Sem tracking

### Consentimento

- [ ] Sempre explícito
- [ ] Sempre informado
- [ ] Sempre granular
- [ ] Sempre revogável
- [ ] Registro de consentimento

### Direitos

- [ ] Acesso aos dados
- [ ] Correção dos dados
- [ ] Exclusão dos dados
- [ ] Portabilidade dos dados
- [ ] Informação sobre tratamento

### Transparência

- [ ] Política de privacidade clara
- [ ] Fluxos transparentes
- [ ] Feedback em tempo real
- [ ] Logs sem dados sensíveis

## Métricas

| Métrica | Meta |
|---------|------|
| Consentimento | 100% explícito |
| Direitos | 100% implementados |
| Transparência | 100% |
| Conformidade | 100% |
