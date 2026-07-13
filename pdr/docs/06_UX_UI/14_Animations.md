# Animations

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Tipos de Animação

| Tipo | Uso | Duração |
|------|-----|---------|
| **Fade** | Entrada/saída de elementos | 200ms |
| **Scale** | Detalhes de cartão | 250ms |
| **Hero** | Transição entre telas | 300ms |
| **Slide** | Navegação entre telas | 300ms |
| **Ripple** | Feedback de toque | 150ms |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sem animações longas |
| 2 | Máximo 300ms para qualquer animação |
| 3 | Animações opcionais (respeitar preferência do sistema) |
| 4 | Sem animações que atrapalhem a usabilidade |
| 5 | Sem animações em loops |

---

## Implementação

### Fade
```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 200),
  child: child,
)
```

### Scale
```dart
AnimatedScale(
  scale: isExpanded ? 1.0 : 0.8,
  duration: Duration(milliseconds: 250),
  child: child,
)
```

### Hero
```dart
Hero(
  tag: 'profile-image',
  child: CircleAvatar(),
)
```

### Slide
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  ),
)
```

---

## Respeitar Preferência do Sistema

```dart
// Verificar se o usuário prefere menos animações
final reduceMotion = MediaQuery.of(context).disableAnimations;

if (reduceMotion) {
  // Sem animação
  return child;
} else {
  // Com animação
  return AnimatedWidget(child: child);
}
```

---

## Documentos Relacionados

- [01_UXVision.md](./01_UXVision.md)
- [14_Animations.md](./14_Animations.md)
