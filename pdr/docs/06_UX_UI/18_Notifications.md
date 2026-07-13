# Notifications

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Tipos

| Tipo | Descrição | Status |
|------|-----------|--------|
| **Push Notifications** | Notificações remotas | ❌ Não utilizado |
| **Locais** | Notificações do app | ✅ Utilizado |

---

## Notificações Locais

### Quando Utilizar

| Evento | Notificação |
|--------|-------------|
| Atualização disponível | Banner discreto na tela inicial |
| Lembrete opcional | Configurável pelo usuário |

### Regras

| # | Regra |
|---|-------|
| 1 | Sem push notifications |
| 2 | Somente notificações locais |
| 3 | Atualização disponível: banner discreto |
| 4 | Sem notificações durante compartilhamento |
| 5 | Sem notificações durante biometria |
| 6 | Configurável pelo usuário |

---

## Implementação

### Verificar Disponibilidade
```dart
final isAvailable = await flutterLocalNotificationsPlugin.initialize();
```

### Mostrar Notificação
```dart
await flutterLocalNotificationsPlugin.show(
  0,
  'Atualização Disponível',
  'Uma nova versão está disponível',
  NotificationDetails(
    android: AndroidNotificationDetails(
      'updates',
      'Atualizações',
      channelDescription: 'Notificações de atualização',
    ),
    iOS: DarwinNotificationDetails(),
  ),
);
```

---

## Documentos Relacionados

- [18_Notifications.md](./18_Notifications.md)
- [13_Privacy.md](../03_Product/13_Privacy.md)
