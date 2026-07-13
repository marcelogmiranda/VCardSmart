# Typography

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fonte

| Propriedade | Valor |
|-------------|-------|
| **Fonte Principal** | Roboto |
| **Fallback** | System default |
| **Unicode** | Suporte completo |

---

## Escala Tipográfica

| Estilo | Tamanho | Peso | Uso |
|--------|---------|------|-----|
| **Display Large** | 57sp | Bold | Títulos impactantes |
| **Display Medium** | 45sp | Bold | Títulos impactantes |
| **Display Small** | 36sp | Bold | Títulos impactantes |
| **Headline Large** | 32sp | Bold | Títulos de tela |
| **Headline Medium** | 28sp | Bold | Títulos de seção |
| **Headline Small** | 24sp | Bold | Subtítulos |
| **Title Large** | 22sp | Medium | Títulos de componentes |
| **Title Medium** | 16sp | Medium | Títulos de card |
| **Title Small** | 14sp | Medium | Labels importantes |
| **Body Large** | 16sp | Regular | Texto principal |
| **Body Medium** | 14sp | Regular | Texto secundário |
| **Body Small** | 12sp | Regular | Texto auxiliar |
| **Label Large** | 14sp | Medium | Botões |
| **Label Medium** | 12sp | Medium | Badges |
| **Label Small** | 11sp | Medium | Tags |

---

## Uso

### Título de Tela
```dart
Text(
  'Meu Cartão',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

### Texto Principal
```dart
Text(
  'Nome Completo',
  style: Theme.of(context).textTheme.bodyLarge,
)
```

### Label de Botão
```dart
Text(
  'Compartilhar',
  style: Theme.of(context).textTheme.labelLarge,
)
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre usar estilos do tema |
| 2 | Nunca definir tamanho fixo de fonte |
| 3 | Suportar fonte dinâmica do sistema |
| 4 | Contraste adequado em todos os estilos |

---

## Documentos Relacionados

- [02_DesignSystem.md](./02_DesignSystem.md)
- [03_ColorPalette.md](./03_ColorPalette.md)
- [16_Accessibility.md](./16_Accessibility.md)
