# Hive Boxes

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Boxes

| Box | Conteúdo | Chave |
|-----|----------|-------|
| `user_profile` | Perfil principal | `profile` |
| `settings` | Configurações gerais | Chaves fixas |
| `received_cards` | Cartões importados | UUID |
| `history` | Histórico de ações | UUID |
| `preferences` | Preferências detalhadas | Chaves fixas |
| `logs` | Logs locais | Timestamp |

---

## user_profile

### Configuração Principal
| Chave | Tipo | Descrição |
|-------|------|-----------|
| `profile` | UserProfileModel | Perfil do usuário |

### Acesso
```dart
final box = Hive.box('user_profile');
final profile = box.get('profile');
```

---

## settings

### Preferências
| Chave | Tipo | Padrão | Descrição |
|-------|------|--------|-----------|
| `theme` | String | `system` | Tema do app |
| `language` | String | `pt` | Idioma |
| `biometricEnabled` | bool | `false` | Biometria ativa |
| `pinEnabled` | bool | `false` | PIN ativo |
| `pin` | String | `null` | PIN hasheado |
| `autoLock` | bool | `true` | Bloqueio automático |
| `lockTimeout` | int | `300` | Timeout (segundos) |
| `shareConfirmation` | bool | `true` | Confirmação ao compartilhar |
| `importConfirmation` | bool | `true` | Confirmação ao importar |

### Acesso
```dart
final box = Hive.box('settings');
final theme = box.get('theme', defaultValue: 'system');
```

---

## received_cards

### Cartões Importados
| Chave | Tipo | Descrição |
|-------|------|-----------|
| UUID | ReceivedCardModel | Cartão recebido |

### Acesso
```dart
final box = Hive.box('received_cards');
final cards = box.values.toList();
final card = box.get('uuid');
```

---

## history

### Histórico
| Chave | Tipo | Descrição |
|-------|------|-----------|
| UUID | HistoryModel | Registro de ação |

### Estrutura
```json
{
  "id": "uuid",
  "action": "share",
  "method": "nfc",
  "timestamp": "2026-07-13T00:00:00Z",
  "target": "uuid-do-cartao"
}
```

---

## preferences

### Preferências Detalhadas
| Chave | Tipo | Descrição |
|-------|------|-----------|
| `notifications` | bool | Notificações |
| `hapticFeedback` | bool | Feedback tátil |
| `animations` | bool | Animações |

---

## logs

### Logs Locais (Debug)
| Chave | Tipo | Descrição |
|-------|------|-----------|
| Timestamp | LogModel | Log registrado |

### Acesso
```dart
final box = Hive.box('logs');
final logs = box.values.toList();
```

---

## Inicialização

```dart
await Hive.openBox('user_profile');
await Hive.openBox('settings');
await Hive.openBox('received_cards');
await Hive.openBox('history');
await Hive.openBox('preferences');
await Hive.openBox('logs');
```

---

## Documentos Relacionados

- [02_HiveArchitecture.md](./02_HiveArchitecture.md)
- [07_DatabaseArchitecture.md](../04_Architecture/07_DatabaseArchitecture.md)
