# Sprint 11 — Settings

## Objetivo

Implementar tela de configurações.

## Pré-requisitos

- Sprint 10 concluída
- Security implementado

## Documentos Obrigatórios

- Architecture.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── features/
│   └── settings/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── settings_datasource.dart
│       │   └── models/
│       │       └── settings_model.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── settings.dart
│       │   ├── repositories/
│       │   │   └── settings_repository.dart
│       │   └── usecases/
│       │       ├── get_settings_usecase.dart
│       │       └── update_settings_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   └── settings_page.dart
│           ├── widgets/
│           │   ├── theme_toggle.dart
│           │   ├── language_selector.dart
│           │   ├── security_settings.dart
│           │   └── privacy_settings.dart
│           └── providers/
│               └── settings_provider.dart
```

### Arquivos Alterados

- lib/core/router/app_router.dart

## Modelos

### settings.dart

```dart
class Settings {
  final ThemeMode themeMode;
  final Locale locale;
  final bool biometricEnabled;
  final bool pinEnabled;
  final bool adsEnabled;
  
  const Settings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('pt', 'BR'),
    this.biometricEnabled = false,
    this.pinEnabled = false,
    this.adsEnabled = true,
  });
}
```

### settings_repository.dart

```dart
abstract class SettingsRepository {
  Future<Settings> getSettings();
  Future<void> updateSettings(Settings settings);
  Future<void> resetSettings();
}
```

### settings_page.dart

```dart
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: settingsAsync.when(
        data: (settings) => ListView(
          children: [
            ThemeToggle(
              themeMode: settings.themeMode,
              onChanged: (mode) {
                ref.read(settingsProvider.notifier).updateTheme(mode);
              },
            ),
            LanguageSelector(
              locale: settings.locale,
              onChanged: (locale) {
                ref.read(settingsProvider.notifier).updateLocale(locale);
              },
            ),
            SecuritySettings(
              biometricEnabled: settings.biometricEnabled,
              pinEnabled: settings.pinEnabled,
              onBiometricChanged: (enabled) {
                ref.read(settingsProvider.notifier).updateBiometric(enabled);
              },
              onPinChanged: (enabled) {
                ref.read(settingsProvider.notifier).updatePin(enabled);
              },
            ),
            PrivacySettings(
              adsEnabled: settings.adsEnabled,
              onAdsChanged: (enabled) {
                ref.read(settingsProvider.notifier).updateAds(enabled);
              },
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
```

### theme_toggle.dart

```dart
class ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onChanged;
  
  const ThemeToggle({
    super.key,
    required this.themeMode,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Tema'),
      trailing: SegmentedButton<ThemeMode>(
        segments: const [
          ButtonSegment(
            value: ThemeMode.light,
            icon: Icon(Icons.light_mode),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            icon: Icon(Icons.dark_mode),
          ),
          ButtonSegment(
            value: ThemeMode.system,
            icon: Icon(Icons.settings_brightness),
          ),
        ],
        selected: {themeMode},
        onSelectionChanged: (selected) {
          onChanged(selected.first);
        },
      ),
    );
  }
}
```

### language_selector.dart

```dart
class LanguageSelector extends StatelessWidget {
  final Locale locale;
  final Function(Locale) onChanged;
  
  const LanguageSelector({
    super.key,
    required this.locale,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Idioma'),
      trailing: DropdownButton<Locale>(
        value: locale,
        items: const [
          DropdownMenuItem(
            value: Locale('pt', 'BR'),
            child: Text('Português'),
          ),
          DropdownMenuItem(
            value: Locale('en'),
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: Locale('es'),
            child: Text('Español'),
          ),
        ],
        onChanged: (newLocale) {
          if (newLocale != null) {
            onChanged(newLocale);
          }
        },
      ),
    );
  }
}
```

## Critérios de Aceitação

- [x] Tela de configurações criada
- [x] Tema funcionando
- [x] Idioma funcionando
- [x] Biometria configurável
- [x] PIN configurável
- [x] Anúncios configurável
- [x] Salvamento automático
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Tela de configurações criada
- [x] Tema funcionando
- [x] Idioma funcionando
- [x] Biometria configurável
- [x] PIN configurável
- [x] Anúncios configurável
- [x] Salvamento automático
- [x] Build funcionando
- [x] Testes passando (362/362)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (80.0%)
- [x] CHANGELOG atualizado (v1.9.0)

## Próxima Sprint

Sprint 12 — Multilanguage
