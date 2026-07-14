# Responsive Design

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Dispositivos Suportados

| Tipo | Tamanho | Prioridade |
|------|---------|------------|
| **Smartphone** | 5" - 6.8" | P0 (Principal) |
| **Tablet** | 7" - 12.9" | P1 (Desejável) |
| **Dobrável** | Variável | P2 (Futuro) |

---

## Orientação

| Orientação | Suporte |
|-----------|---------|
| **Portrait** | ✅ Obrigatório |
| **Landscape** | ✅ Suportado |

---

## Estratégia

### Smartphone (5" - 6.8")
- Layout principal
- Interface utilizável com uma mão
- Navegação inferior
- Máximo 3 toques

### Tablet (7" - 12.9")
- Layout adaptado
- Mais espaço para conteúdo
- Navegação lateral (opcional)
- Colunas adicionais

### Dobrável
- Layout adaptativo
- Transição suave entre estados

---

## Implementação

### Layout Responsivo
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // Layout para tablet
      return TabletLayout();
    } else {
      // Layout para smartphone
      return PhoneLayout();
    }
  },
)
```

### Grid Responsivo
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3 / 4,
    crossAxisSpacing: Spacing.sm,
    mainAxisSpacing: Spacing.sm,
  ),
)
```

---

## Breakpoints

| Breakpoint | Largura | Layout |
|-----------|---------|--------|
| Mobile | < 600dp | Coluna única |
| Tablet | 600dp - 840dp | 2 colunas |
| Desktop | > 840dp | 3+ colunas |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Primário para smartphone (6" - 6.8") |
| 2 | Adaptação para tablets e dobráveis |
| 3 | Interface utilizável com uma mão |
| 4 | Navegação consistente entre plataformas |
| 5 | Nenhuma funcionalidade crítica depende de gestos |

---

## Documentos Relacionados

- [01_UXVision.md](./01_UXVision.md)
- [08_Layouts.md](./08_Layouts.md)
- [06_Spacing.md](./06_Spacing.md)
