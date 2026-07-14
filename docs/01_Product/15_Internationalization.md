# Internationalization

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Idiomas Suportados

| # | Idioma | Código | ARB File | Status |
|---|--------|--------|----------|--------|
| 1 | Português | pt | app_pt.arb | A definir |
| 2 | Inglês | en | app_en.arb | A definir |
| 3 | Espanhol | es | app_es.arb | A definir |
| 4 | Francês | fr | app_fr.arb | A definir |
| 5 | Italiano | it | app_it.arb | A definir |
| 6 | Alemão | de | app_de.arb | A definir |
| 7 | Japonês | ja | app_ja.arb | A definir |
| 8 | Chinês | zh | app_zh.arb | A definir |

---

## Princípios

| Princípio | Descrição |
|-----------|-----------|
| **Nenhuma String Fixa** | Todo texto deve estar em arquivos ARB |
| **ARB como Padrão** | Utilizar formato ARB (Application Resource Bundle) |
| **Troca Dinâmica** | Mudança de idioma sem reiniciar o app |
| **Idioma do Sistema** | Detectar e seguir preferência do dispositivo |

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

## Formato ARB

### Exemplo (app_pt.arb)
```json
{
  "@@locale": "pt",
  "appTitle": "VCardSmart",
  "welcomeTitle": "Bem-vindo ao VCardSmart",
  "welcomeMessage": "Seu cartão de visita digital",
  "createProfile": "Criar Perfil",
  "editProfile": "Editar Perfil",
  "shareCard": "Compartilhar Cartão",
  "importCard": "Importar Cartão",
  "settings": "Configurações",
  "theme": "Tema",
  "language": "Idioma",
  "darkMode": "Modo Escuro",
  "lightMode": "Modo Claro",
  "systemMode": "Modo do Sistema"
}
```

### Exemplo (app_en.arb)
```json
{
  "@@locale": "en",
  "appTitle": "VCardSmart",
  "welcomeTitle": "Welcome to VCardSmart",
  "welcomeMessage": "Your digital business card",
  "createProfile": "Create Profile",
  "editProfile": "Edit Profile",
  "shareCard": "Share Card",
  "importCard": "Import Card",
  "settings": "Settings",
  "theme": "Theme",
  "language": "Language",
  "darkMode": "Dark Mode",
  "lightMode": "Light Mode",
  "systemMode": "System Mode"
}
```

---

## Configuração no Flutter

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

## Uso no Código

### Dart
```dart
// Correto
Text(AppLocalizations.of(context)!.welcomeTitle)

// Incorreto (NUNCA fazer)
Text('Bem-vindo')
```

---

## Troca de Idioma

### Fluxo
```
Configurações → Idioma → Selecionar → Aplicar → Interface atualizada
```

### Implementação
```dart
// Detectar idioma do sistema
final locale = WidgetsBinding.instance.platformDispatcher.locale;

// Aplicar idioma selecionado
await context.setLocale(selectedLocale);
```

---

## Validação

### Checklist de Validação
- ✅ Nenhuma string fixa no código
- ✅ Todos os textos em arquivos ARB
- ✅ Todos os 8 idiomas traduzidos
- ✅ Troca dinâmica funcionando
- ✅ Idioma do sistema detectado
- ✅ Formatação de data/hora localizada
- ✅ Formatação de números localizada

---

## Documentos Relacionados

- [10_NonFunctionalRequirements.md](./10_NonFunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
- [16_Accessibility.md](./16_Accessibility.md)
