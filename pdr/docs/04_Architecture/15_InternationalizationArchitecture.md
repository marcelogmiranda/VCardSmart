# Internationalization Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack

| Componente | Papel |
|-----------|-------|
| **ARB** | Formato de tradução |
| **Flutter Intl** | Geração automática |
| **flutter_localizations** | Suporte nativo |

---

## Idiomas

| # | Idioma | Código | ARB File |
|---|--------|--------|----------|
| 1 | Português | pt | app_pt.arb |
| 2 | Inglês | en | app_en.arb |
| 3 | Espanhol | es | app_es.arb |
| 4 | Francês | fr | app_fr.arb |
| 5 | Italiano | it | app_it.arb |
| 6 | Alemão | de | app_de.arb |
| 7 | Japonês | ja | app_ja.arb |
| 8 | Chinês | zh | app_zh.arb |

---

## Estrutura de Diretórios

```
lib/
├── l10n/
│   ├── app.arb
│   ├── app_pt.arb
│   ├── app_en.arb
│   ├── app_es.arb
│   ├── app_fr.arb
│   ├── app_it.arb
│   ├── app_de.arb
│   ├── app_ja.arb
│   └── app_zh.arb
```

---

## Configuração

### pubspec.yaml
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app.arb
output-localization-file: app_localizations.dart
```

---

## Uso

### Correto
```dart
Text(AppLocalizations.of(context)!.welcomeTitle)
```

### Incorreto
```dart
Text('Bem-vindo') // NUNCA fazer
```

---

## Troca de Idioma

```dart
// Detectar idioma do sistema
final locale = WidgetsBinding.instance.platformDispatcher.locale;

// Aplicar idioma selecionado
await context.setLocale(selectedLocale);
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Nenhuma string fixa no código |
| 2 | Todas as strings em ARB |
| 3 | Troca dinâmica sem reiniciar |
| 4 | Seguir idioma do sistema |
| 5 | 8 idiomas obrigatórios |

---

## Documentos Relacionados

- [15_InternationalizationArchitecture.md](./15_InternationalizationArchitecture.md)
- [15_Internationalization.md](../03_Product/15_Internationalization.md)
