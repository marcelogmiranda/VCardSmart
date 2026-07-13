# Spacing

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Grid

| Propriedade | Valor |
|-------------|-------|
| **Base** | 8dp |
| **Múltiplos** | Sim |

---

## Espaçamentos

| Token | Valor | Uso |
|-------|-------|-----|
| `spacingXxs` | 2dp | Espaçamento mínimo |
| `spacingXs` | 4dp | Entre ícones |
| `spacingSm` | 8dp | Entre elementos próximos |
| `spacingMd` | 12dp | Entre seções |
| `spacingLg` | 16dp | Padding de cards |
| `spacingXl` | 24dp | Entre seções |
| `spacingXxl` | 32dp | Margem de tela |
| `spacingXxxl` | 48dp | Espaçamento grande |
| `spacingHuge` | 64dp | Espaçamento muito grande |

---

## Uso

### Padding de Tela
```dart
Padding(
  padding: EdgeInsets.all(Spacing.lg),
  child: Column(
    children: [
      Text('Título'),
      SizedBox(height: Spacing.sm),
      Text('Conteúdo'),
    ],
  ),
)
```

### Espaçamento Entre Cards
```dart
ListView.separated(
  itemBuilder: (context, index) => Card(),
  separatorBuilder: (context, index) => SizedBox(height: Spacing.sm),
)
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre usar múltiplos de 8dp |
| 2 | Nunca usar valores arbitrários |
| 3 | Consistência em todas as telas |
| 4 | Responsividade: adaptar em telas maiores |

---

## Documentos Relacionados

- [02_DesignSystem.md](./02_DesignSystem.md)
- [08_Layouts.md](./08_Layouts.md)
- [17_ResponsiveDesign.md](./17_ResponsiveDesign.md)
