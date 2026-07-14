# Retenção de Dados — VCardSmart

## Política

### Regra Principal

> Dados mantidos enquanto o aplicativo permanecer instalado.

## Detalhamento

### Local de Armazenamento

| Tipo | Local | Criptografia |
|------|-------|--------------|
| Perfil | Hive | AES-256 |
| Contatos | Hive | AES-256 |
| Configurações | Hive | AES-256 |
| Chaves | Secure Storage | Hardware |
| PIN Hash | Secure Storage | Hardware |

### Tempo de Retenção

| Dado | Retenção |
|------|----------|
| Perfil | Enquanto instalado |
| Contatos | Enquanto instalado |
| Configurações | Enquanto instalado |
| Chaves | Enquanto instalado |
| PIN Hash | Enquanto instalado |

### Remoção

| Evento | Ação |
|--------|------|
| Exclusão do perfil | Remove perfil do Hive |
| Exclusão de contato | Remove contato do Hive |
| Exclusão de todos os dados | Remove tudo do Hive e Secure Storage |
| Desinstalação | Remove todos os dados |

## Sem Backup

### Regra

- ❌ Sem backup em nuvem
- ❌ Sem sincronização
- ❌ Sem exportação automática

### Exceção

- ✅ Exportação manual (vCard/JSON)
- ✅ Usuário controla quando exportar

## Sem Nuvem

### Regra

- ❌ Sem servidores
- ❌ Sem API remota
- ❌ Sem armazenamento remoto

### Implementação

```dart
// Dados sempre locais
final profile = await ProfileBox.get(); // Local
final contacts = await ContactBox.getAll(); // Local
final settings = await SettingsBox.get(); // Local
```

## Sem Sincronização

### Regra

- ❌ Sem sincronização entre dispositivos
- ❌ Sem backup automático
- ❌ Sem restore automático

### Implementação

```dart
// Cada dispositivo é independente
// Usuário deve exportar/importar manualmente
```

## Exclusão Completa

### Fluxo

```
1. Usuário solicita exclusão
    ↓
2. Confirmação obtida
    ↓
3. ProfileBox.clear()
    ↓
4. ContactBox.clear()
    ↓
5. SettingsBox.clear()
    ↓
6. SecureStorageService.deleteAll()
    ↓
7. Aplicativo limpo
```

### Implementação

```dart
class DataRetentionService {
  static Future<void> deleteAllData() async {
    // Limpar Hive
    await ProfileBox.clear();
    await ContactBox.clear();
    await SettingsBox.clear();
    
    // Limpar Secure Storage
    await SecureStorageService.deleteAll();
    
    // Limpar consents
    await ConsentService.revokeAll();
  }
  
  static Future<void> deleteProfile() async {
    await ProfileBox.clear();
  }
  
  static Future<void> deleteContact(String id) async {
    await ContactBox.delete(id);
  }
  
  static Future<void> deleteContacts() async {
    await ContactBox.clear();
  }
}
```

## Auditoria

### Frequência

- **Trimestral**: Revisão de dados armazenados
- **Por release**: Verificação de conformidade

### Checklist

- [x] Apenas dados necessários armazenados
- [x] Criptografia obrigatória
- [x] Sem backup em nuvem
- [x] Sem sincronização
- [x] Exclusão completa disponível
- [x] Remoção na desinstalação

## Métricas

| Métrica | Meta |
|---------|------|
| Retenção | Enquanto instalado |
| Backup | 0 |
| Sincronização | 0 |
| Exclusão | 100% completa |
