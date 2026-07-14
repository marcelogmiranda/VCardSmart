# Testes de Internacionalização — VCardSmart

## Objetivo

Garantir que o aplicativo funcione corretamente em todos os idiomas suportados, com traduções corretas e layout adaptado.

## Idiomas Suportados

| Código | Idioma | Status |
|--------|--------|--------|
| pt | Português (Brasil) | ✅ Padrão |
| en | Inglês | ✅ |
| es | Espanhol | ✅ |
| fr | Francês | ✅ |
| it | Italiano | ✅ |
| de | Alemão | ✅ |
| ja | Japonês | ✅ |
| zh | Chinês (Simplificado) | ✅ |

## Estrutura

```
test/i18n/
├── translations/
│   ├── pt_test.dart
│   ├── en_test.dart
│   ├── es_test.dart
│   ├── fr_test.dart
│   ├── it_test.dart
│   ├── de_test.dart
│   ├── ja_test.dart
│   └── zh_test.dart
├── layout/
│   ├── text_expansion_test.dart
│   ├── rtl_test.dart
│   └── date_format_test.dart
└── helpers/
    └── i18n_helper.dart
```

## Casos de Teste

### 1. Traduções Completas

```dart
void main() {
  group('Translations', () {
    test('should have all keys for Portuguese', () {
      final translations = ptTranslations;
      final requiredKeys = getRequiredKeys();
      
      for (final key in requiredKeys) {
        expect(
          translations.containsKey(key),
          isTrue,
          reason: 'Missing key: $key in pt',
        );
      }
    });

    test('should have all keys for English', () {
      final translations = enTranslations;
      final requiredKeys = getRequiredKeys();
      
      for (final key in requiredKeys) {
        expect(
          translations.containsKey(key),
          isTrue,
          reason: 'Missing key: $key in en',
        );
      }
    });

    test('should have no empty translations', () {
      for (final locale in supportedLocales) {
        final translations = getTranslations(locale);
        
        for (final entry in translations.entries) {
          expect(
            entry.value,
            isNotEmpty,
            reason: 'Empty translation: ${entry.key} in $locale',
          );
        }
      }
    });

    test('should have no duplicate keys', () {
      for (final locale in supportedLocales) {
        final translations = getTranslations(locale);
        final keys = translations.keys.toList();
        
        expect(
          keys.length,
          equals(keys.toSet().length),
          reason: 'Duplicate keys in $locale',
        );
      }
    });
  });
}
```

### 2. Sem Strings Fixas

```dart
group('No Hardcoded Strings', () {
  testWidgets('should use translated strings in UI', ($) async {
    await $.pumpApp(MaterialApp(
      locale: Locale('pt'),
      home: HomeScreen(),
    ));
    
    // Verificar que não há strings hardcoded
    expect(find.text('Home'), findsNothing); // Hardcoded
    expect(find.text('Início'), findsOneWidget); // Translated
  });

  test('should not contain hardcoded strings in code', () {
    final sourceFiles = getSourceFiles();
    
    for (final file in sourceFiles) {
      final content = file.readAsStringSync();
      
      // Verificar padrões de strings hardcoded
      expect(
        content,
        isNot(contains(RegExp(r"'[A-Z][a-z]+\s[a-z]+'"))),
        reason: 'Hardcoded string in ${file.path}',
      );
    }
  });
});
```

### 3. Layout com Textos Longos

```dart
group('Text Expansion', () {
  testWidgets('should handle German text expansion', ($) async {
    await $.pumpApp(MaterialApp(
      locale: Locale('de'),
      home: HomeScreen(),
    ));
    
    // Alemão tende a ser 30% maior
    expect(find.byType(HomeScreen), findsOneWidget);
    
    // Verificar overflow
    expect(
      find.byType(OverflowBox),
      findsNothing,
    );
  });

  testWidgets('should handle French text expansion', ($) async {
    await $.pumpApp(MaterialApp(
      locale: Locale('fr'),
      home: HomeScreen(),
    ));
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });
});
```

### 4. Formatação de Datas e Números

```dart
group('Date and Number Format', () {
  test('should format dates correctly per locale', () {
    final date = DateTime(2024, 3, 15);
    
    expect(
      formatDate(date, Locale('pt')),
      equals('15/03/2024'),
    );
    
    expect(
      formatDate(date, Locale('en')),
      equals('03/15/2024'),
    );
    
    expect(
      formatDate(date, Locale('de')),
      equals('15.03.2024'),
    );
  });

  test('should format numbers correctly per locale', () {
    final number = 1234.56;
    
    expect(
      formatNumber(number, Locale('pt')),
      equals('1.234,56'),
    );
    
    expect(
      formatNumber(number, Locale('en')),
      equals('1,234.56'),
    );
    
    expect(
      formatNumber(number, Locale('de')),
      equals('1.234,56'),
    );
  });

  test('should format currency correctly per locale', () {
    final amount = 1234.56;
    
    expect(
      formatCurrency(amount, Locale('pt')),
      equals('R\$ 1.234,56'),
    );
    
    expect(
      formatCurrency(amount, Locale('en')),
      equals('\$1,234.56'),
    );
  });
});
```

### 5. RTL (Right-to-Left)

```dart
group('RTL Support', () {
  testWidgets('should layout RTL for Arabic', ($) async {
    await $.pumpApp(MaterialApp(
      locale: Locale('ar'),
      home: HomeScreen(),
    ));
    
    // Verificar direção do layout
    expect(
      Directionality.of($.context),
      equals(TextDirection.rtl),
    );
  });
});
```

### 6. Troca de Idioma

```dart
group('Language Switching', () {
  testWidgets('should change language dynamically', ($) async {
    await $.pumpApp(MaterialApp(
      locale: Locale('pt'),
      home: HomeScreen(),
    ));
    
    // Verificar idioma inicial
    expect(find.text('Início'), findsOneWidget);
    
    // Mudar idioma
    await $.tap(find.byKey(Key('settings_button')));
    await $.pumpAndSettle();
    await $.tap(find.byKey(Key('language_button')));
    await $.pumpAndSettle();
    await $.tap(find.byKey(Key('english')));
    await $.pumpAndSettle();
    
    // Verificar idioma alterado
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('should persist language preference', ($) async {
    // Mudar idioma
    await changeLanguage('en');
    
    // Reiniciar app
    await $.pumpApp(MaterialApp(
      home: HomeScreen(),
    ));
    
    // Verificar persistência
    expect(find.text('Home'), findsOneWidget);
  });
});
```

## Chaves Obrigatórias

```dart
const requiredKeys = [
  // Navigation
  'nav.home',
  'nav.profile',
  'nav.qrcode',
  'nav.nfc',
  'nav.settings',
  
  // Actions
  'action.save',
  'action.cancel',
  'action.delete',
  'action.edit',
  'action.share',
  'action.import',
  'action.export',
  
  // Profile
  'profile.name',
  'profile.email',
  'profile.phone',
  'profile.company',
  'profile.website',
  'profile.address',
  
  // Messages
  'message.success',
  'message.error',
  'message.loading',
  'message.empty',
  
  // Settings
  'settings.theme',
  'settings.language',
  'settings.biometric',
  'settings.pin',
  
  // Errors
  'error.required',
  'error.invalid_email',
  'error.invalid_phone',
  'error.network',
  'error.permission',
];
```

## Comandos

```bash
# Verificar traduções
flutter pub run intl_utils:generate

# Rodar testes de i18n
flutter test test/i18n/

# Verificar strings hardcoded
dart analyze --no-fatal-infos lib/

# Gerar relatório de traduções
flutter pub run translations_report
```

## Métricas

| Métrica | Meta |
|---------|------|
| Idiomas suportados | 8 |
| Chaves traduzidas | 100% |
| Strings hardcoded | 0 |
| Layout para textos longos | 100% |
| Formatação de datas/números | 100% |
