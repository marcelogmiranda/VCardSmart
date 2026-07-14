# Dark Mode

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Suporte

| Modo | Status |
|------|--------|
| **Modo Claro** | ✅ Suportado |
| **Modo Escuro** | ✅ Suportado |
| **Modo Sistema** | ✅ Suportado |

---

## Paleta de Cores

### Modo Claro
| Elemento | Cor |
|----------|-----|
| Background | #FFFFFF |
| Surface | #F5F5F5 |
| On Surface | #212121 |
| Primary | #1565C0 |
| On Primary | #FFFFFF |
| Secondary | #00C853 |
| Error | #B00020 |

### Modo Escuro
| Elemento | Cor |
|----------|-----|
| Background | #121212 |
| Surface | #1E1E1E |
| On Surface | #E0E0E0 |
| Primary | #90CAF9 |
| On Primary | #000000 |
| Secondary | #69F0AE |
| Error | #CF6679 |

---

## Contraste

| Elemento | Contraste Mínimo |
|----------|-----------------|
| Texto normal | 4.5:1 |
| Texto grande | 3:1 |
| Componentes interativos | 3:1 |
| Ícones | 3:1 |

---

## Implementação

```dart
ThemeData getTheme(ThemeMode mode) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xFF1565C0),
    brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
  );
}
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Todos os componentes devem suportar ambos os modos |
| 2 | Contraste adequado em ambos os modos |
| 3 | Troca imediata sem reiniciar o app |
| 4 | Manter preferência entre sessões |

---

## Documentos Relacionados

- [03_ColorPalette.md](./03_ColorPalette.md)
- [15_DarkMode.md](./15_DarkMode.md)
- [16_Accessibility.md](./16_Accessibility.md)
