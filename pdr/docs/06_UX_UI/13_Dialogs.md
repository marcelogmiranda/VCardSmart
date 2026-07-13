# Dialogs

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Tipos de Diálogo

### Confirmar Compartilhamento
```dart
AppDialog(
  title: 'Compartilhar Cartão',
  content: 'Deseja compartilhar seu cartão com este dispositivo?',
  confirmLabel: 'Compartilhar',
  cancelLabel: 'Cancelar',
  onConfirm: () => share(),
  isDestructive: false,
)
```

---

### Excluir Perfil
```dart
AppDialog(
  title: 'Excluir Perfil',
  content: 'Tem certeza? Esta ação não pode ser desfeita.',
  confirmLabel: 'Excluir',
  cancelLabel: 'Cancelar',
  onConfirm: () => delete(),
  isDestructive: true,
)
```

---

### Atualizar Agenda
```dart
AppDialog(
  title: 'Atualizar Agenda',
  content: 'Deseja atualizar este contato na sua agenda?',
  confirmLabel: 'Atualizar',
  cancelLabel: 'Não',
  onConfirm: () => updateContact(),
  isDestructive: false,
)
```

---

### Salvar Contato
```dart
AppDialog(
  title: 'Salvar Contato',
  content: 'Deseja salvar este cartão nos seus contatos?',
  confirmLabel: 'Salvar',
  cancelLabel: 'Cancelar',
  onConfirm: () => saveContact(),
  isDestructive: false,
)
```

---

### Erro
```dart
AppDialog(
  title: 'Erro',
  content: 'Ocorreu um erro. Tente novamente.',
  confirmLabel: 'OK',
  onConfirm: () => Navigator.pop(context),
  isDestructive: false,
)
```

---

### Permissão
```dart
AppDialog(
  title: 'Permissão Necessária',
  content: 'O VCardSmart precisa de acesso à câmera para ler QR Codes.',
  confirmLabel: 'Conceder',
  cancelLabel: 'Agora não',
  onConfirm: () => requestPermission(),
  isDestructive: false,
)
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre confirmar ações destrutivas |
| 2 | Mensagens claras e concisas |
| 3 | Botão de cancelar sempre visível |
| 4 | Ação destrutiva em vermelho |
| 5 | Máximo 1 diálogo por vez |

---

## Documentos Relacionados

- [07_Components.md](./07_Components.md)
- [13_Dialogs.md](./13_Dialogs.md)
