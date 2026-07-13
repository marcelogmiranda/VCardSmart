# Components

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Componentes Reutilizáveis

### PrimaryButton

```dart
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
}
```

| Estado | Descrição |
|--------|-----------|
| Normal | Azul (#1565C0) com texto branco |
| Disabled | Cinza, sem interação |
| Loading | Indicador de progresso |
| Error | Vermelho (após falha) |

---

### SecondaryButton

```dart
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
}
```

| Estado | Descrição |
|--------|-----------|
| Normal | Borda azul, texto azul |
| Disabled | Borda cinza, texto cinza |
| Loading | Indicador de progresso |

---

### ProfileCard

```dart
class ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onTap;
  final bool showActions;
}
```

| Propriedade | Descrição |
|-------------|-----------|
| Foto | Avatar com fallback |
| Nome | Nome completo |
| Cargo | Cargo + Empresa |
| E-mail | E-mail |
| Redes | Ícones das redes sociais |

---

### SocialCard

```dart
class SocialCard extends StatelessWidget {
  final SocialNetwork social;
  final VoidCallback? onTap;
  final bool showActions;
}
```

---

### PhoneTile

```dart
class PhoneTile extends StatelessWidget {
  final Phone phone;
  final VoidCallback? onCall;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onShare;
}
```

---

### SectionHeader

```dart
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAction;
  final String? actionLabel;
}
```

---

### AppDialog

```dart
class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;
}
```

---

### LoadingIndicator

```dart
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double? size;
}
```

---

### EmptyState

```dart
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
}
```

---

### ErrorState

```dart
class ErrorState extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
}
```

---

### AppSnackbar

```dart
class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    String? actionLabel,
    VoidCallback? onAction,
  });
}
```

---

## Estados por Componente

| Componente | Normal | Disabled | Loading | Error |
|-----------|--------|----------|---------|-------|
| PrimaryButton | ✅ | ✅ | ✅ | ✅ |
| SecondaryButton | ✅ | ✅ | ✅ | ✅ |
| ProfileCard | ✅ | ❌ | ✅ | ✅ |
| AppDialog | ✅ | ❌ | ✅ | ✅ |
| EmptyState | ✅ | ❌ | ❌ | ❌ |
| ErrorState | ✅ | ❌ | ❌ | ❌ |

---

## Documentos Relacionados

- [02_DesignSystem.md](./02_DesignSystem.md)
- [12_States.md](./12_States.md)
- [13_Dialogs.md](./13_Dialogs.md)
