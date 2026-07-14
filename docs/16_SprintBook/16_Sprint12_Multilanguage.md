# Sprint 12 — Multilanguage

## Objetivo

Implementar suporte a 8 idiomas.

## Pré-requisitos

- Sprint 11 concluída
- Settings implementado

## Documentos Obrigatórios

- Architecture.md
- MultilingualStoreTexts.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── l10n/
│   ├── app_pt.arb
│   ├── app_en.arb
│   ├── app_es.arb
│   ├── app_fr.arb
│   ├── app_it.arb
│   ├── app_de.arb
│   ├── app_ja.arb
│   └── app_zh.arb
├── core/
│   └── utils/
│       └── locale_utils.dart
```

### Arquivos Alterados

- pubspec.yaml

## Modelos

### app_pt.arb

```json
{
  "@@locale": "pt",
  "appTitle": "VCardSmart",
  "homeTitle": "Início",
  "profileTitle": "Meu Perfil",
  "shareTitle": "Compartilhar",
  "importTitle": "Importar",
  "settingsTitle": "Configurações",
  "save": "Salvar",
  "cancel": "Cancelar",
  "delete": "Excluir",
  "edit": "Editar",
  "share": "Compartilhar",
  "success": "Sucesso!",
  "error": "Erro",
  "loading": "Carregando...",
  "noData": "Sem dados"
}
```

### app_en.arb

```json
{
  "@@locale": "en",
  "appTitle": "VCardSmart",
  "homeTitle": "Home",
  "profileTitle": "My Profile",
  "shareTitle": "Share",
  "importTitle": "Import",
  "settingsTitle": "Settings",
  "save": "Save",
  "cancel": "Cancel",
  "delete": "Delete",
  "edit": "Edit",
  "share": "Share",
  "success": "Success!",
  "error": "Error",
  "loading": "Loading...",
  "noData": "No data"
}
```

### locale_utils.dart

```dart
class LocaleUtils {
  static const supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('de'),
    Locale('ja'),
    Locale('zh'),
  ];
  
  static Locale getDeviceLocale() {
    final deviceLocale = WidgetsBinding.instance.platformLocale;
    
    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale?.languageCode) {
        return locale;
      }
    }
    
    return const Locale('pt', 'BR');
  }
}
```

## Critérios de Aceitação

- [x] 8 idiomas suportados
- [x] Traduções completas
- [x] Detecção automática de idioma
- [x] Alternância manual
- [x] Salvamento de preferência
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Idiomas

| Código | Idioma |
|--------|--------|
| pt-BR | Português (Brasil) |
| en | English |
| es | Español |
| fr | Français |
| it | Italiano |
| de | Deutsch |
| ja | 日本語 |
| zh | 中文 |

## Checklist

- [x] 8 idiomas suportados
- [x] Traduções completas
- [x] Detecção automática de idioma
- [x] Alternância manual
- [x] Salvamento de preferência
- [x] Build funcionando
- [x] Testes passando
- [x] Lints OK
- [x] Cobertura > 80%
- [x] CHANGELOG atualizado

## Próxima Sprint

Sprint 13 — Ads
