# Exclusão de Dados — VCardSmart

## Tipos de Exclusão

### 1. Exclusão do Perfil

```dart
Future<void> deleteProfile() async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Excluir Perfil'),
      content: Text('Tem certeza? Esta ação não pode ser desfeita.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            await ProfileBox.clear();
            Navigator.pop(context);
          },
          child: Text('Excluir'),
        ),
      ],
    ),
  );
}
```

### 2. Exclusão de Contato

```dart
Future<void> deleteContact(String id) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Excluir Contato'),
      content: Text('Tem certeza? Esta ação não pode ser desfeita.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            await ContactBox.delete(id);
            Navigator.pop(context);
          },
          child: Text('Excluir'),
        ),
      ],
    ),
  );
}
```

### 3. Exclusão de Todos os Dados

```dart
Future<void> deleteAllData() async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
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
            'Todos os seus dados serão permanentemente excluídos:\n\n'
            '• Perfil\n'
            '• Contatos\n'
            '• Configurações\n'
            '• Chaves de criptografia\n\n'
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            await DataRetentionService.deleteAllData();
            Navigator.pop(context);
          },
          child: Text('Excluir Tudo'),
        ),
      ],
    ),
  );
}
```

## Fluxo de Exclusão

### Perfil

```
1. Usuário acessa configurações
    ↓
2. Seleciona "Excluir Perfil"
    ↓
3. Confirma exclusão
    ↓
4. ProfileBox.clear()
    ↓
5. Perfil excluído
```

### Contato

```
1. Usuário seleciona contato
    ↓
2. Toca em "Excluir"
    ↓
3. Confirma exclusão
    ↓
4. ContactBox.delete(id)
    ↓
5. Contato excluído
```

### Todos os Dados

```
1. Usuário acessa configurações
    ↓
2. Seleciona "Excluir Todos os Dados"
    ↓
3. Confirma exclusão (2x)
    ↓
4. ProfileBox.clear()
    ↓
5. ContactBox.clear()
    ↓
6. SettingsBox.clear()
    ↓
7. SecureStorageService.deleteAll()
    ↓
8. Todos os dados excluídos
```

## Confirmação

### Nível 1 — Exclusão Simples

```dart
await showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Excluir?'),
    content: Text('Tem certeza?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Não'),
      ),
      ElevatedButton(
        onPressed: () async {
          await deleteItem();
          Navigator.pop(context);
        },
        child: Text('Sim'),
      ),
    ],
  ),
);
```

### Nível 2 — Exclusão Completa

```dart
await showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Excluir Todos os Dados?'),
    content: Text(
      'Esta ação é irreversível. '
      'Todos os seus dados serão permanentemente excluídos.',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancelar'),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () async {
          // Segunda confirmação
          await showSecondConfirmation();
        },
        child: Text('Excluir Tudo'),
      ),
    ],
  ),
);
```

## Validação

### Antes de Excluir

```dart
Future<bool> validateDeletion(String type) async {
  // Verificar se há dados
  switch (type) {
    case 'profile':
      final profile = await ProfileBox.get();
      return profile != null;
    
    case 'contacts':
      final contacts = await ContactBox.getAll();
      return contacts.isNotEmpty;
    
    case 'all':
      return true; // Sempre pode excluir tudo
    
    default:
      return false;
  }
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Confirmação | 100% das exclusões |
| Exclusão completa | 100% dos dados |
| Irreversível | Sim |
