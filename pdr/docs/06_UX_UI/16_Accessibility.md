# Accessibility

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Suporte

| Ferramenta | Plataforma | Status |
|-----------|-----------|--------|
| **TalkBack** | Android | ✅ Suportado |
| **VoiceOver** | iOS | ✅ Suportado |
| **Font Scaling** | Ambos | ✅ Suportado |
| **High Contrast** | Ambos | ✅ Suportado |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sem informação apenas por cor |
| 2 | Área mínima de toque: 48dp |
| 3 | Labels em todos os componentes interativos |
| 4 | Contraste mínimo WCAG 2.1 AA (4.5:1) |
| 5 | Suporte a fonte dinâmica |
| 6 | Navegação por teclado (quando aplicável) |

---

## Implementação

### Labels para Leitor de Tela
```dart
Semantics(
  label: 'Botão de compartilhar cartão',
  child: IconButton(
    icon: Icon(Icons.share),
    onPressed: () {},
  ),
)
```

### Contraste
```dart
// Verificar contraste
final luminance = color.computeLuminance();
final contrast = (luminance + 0.05) / (0.05);
// Deve ser >= 4.5 para texto normal
```

### Touch Targets
```dart
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(
    icon: Icon(Icons.share),
    onPressed: () {},
  ),
)
```

---

## Testes

| Teste | Ferramenta |
|-------|-----------|
| TalkBack | Android |
| VoiceOver | iOS |
| Contraste | Accessibility Scanner |
| Touch | Accessibility Scanner |

---

## Documentos Relacionados

- [16_Accessibility.md](./16_Accessibility.md)
- [03_ColorPalette.md](./03_ColorPalette.md)
- [04_Typography.md](./04_Typography.md)
