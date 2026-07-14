# Testes de Acessibilidade — VCardSmart

## Objetivo

Garantir que o aplicativo seja utilizável por pessoas com diferentes necessidades, seguindo WCAG 2.1 AA e diretrizes de acessibilidade de cada plataforma.

## Padrões

- **WCAG 2.1 AA** — Padrão web
- **Material Design Accessibility** — Android
- **Apple HIG Accessibility** — iOS

## Estrutura

```
test/accessibility/
├── talkback/
│   ├── navigation_test.dart
│   ├── labels_test.dart
│   └── focus_test.dart
├── voiceover/
│   ├── navigation_test.dart
│   ├── labels_test.dart
│   └── rotor_test.dart
├── contrast/
│   ├── light_theme_test.dart
│   └── dark_theme_test.dart
├── font_scale/
│   ├── small_test.dart
│   ├── default_test.dart
│   └── large_test.dart
├── keyboard/
│   ├── tab_navigation_test.dart
│   └── shortcuts_test.dart
└── helpers/
    └── accessibility_helper.dart
```

## Casos de Teste

### 1. TalkBack (Android)

```dart
void main() {
  group('TalkBack', () {
    testWidgets('should announce button labels', ($) async {
      await $.pumpApp(HomeScreen());
      
      // Verificar labels dos botões
      expect(
        find.bySemanticsLabel('Criar Perfil'),
        findsOneWidget,
      );
      
      expect(
        find.bySemanticsLabel('Configurações'),
        findsOneWidget,
      );
    });

    testWidgets('should navigate in logical order', ($) async {
      await $.pumpApp(HomeScreen());
      
      // Verificar ordem de navegação
      final semantics = await $.tester.getSemantics(
        find.byType(Scaffold),
      );
      
      // Verificar hierarquia
      expect(semantics.label, isNotNull);
    });

    testWidgets('should announce state changes', ($) async {
      await $.pumpApp(CreateProfileScreen());
      
      await $.enterText(find.byKey(Key('name_field')), 'João');
      await $.pump();
      
      // Verificar anúncio de mudança
      expect(
        find.bySemanticsLabel('Campo de nome preenchido'),
        findsOneWidget,
      );
    });

    testWidgets('should announce errors', ($) async {
      await $.pumpApp(CreateProfileScreen());
      
      await $.tap(find.byKey(Key('save_button')));
      await $.pumpAndSettle();
      
      // Verificar anúncio de erro
      expect(
        find.bySemanticsLabel('Erro: Nome é obrigatório'),
        findsOneWidget,
      );
    });
  });
}
```

### 2. VoiceOver (iOS)

```dart
group('VoiceOver', () {
  testWidgets('should announce elements', ($) async {
    await $.pumpApp(HomeScreen());
    
    expect(
      find.bySemanticsLabel('Perfil'),
      findsOneWidget,
    );
  });

  testWidgets('should support rotor navigation', ($) async {
    await $.pumpApp(ContactListScreen());
    
    // Verificar suporte a rotor
    final semantics = await $.tester.getSemantics(
      find.byType(ListView),
    );
    
    expect(semantics.hasFlag(SemanticsFlag.isHeader), isTrue);
  });

  testWidgets('should group related elements', ($) async {
    await $.pumpApp(ProfileCard());
    
    // Verificar grupo semântico
    expect(
      find.bySemanticsLabel(RegExp(r'Perfil de .*')),
      findsOneWidget,
    );
  });
});
```

### 3. Contraste

```dart
group('Color Contrast', () {
  testWidgets('light theme meets contrast ratio', ($) async {
    await $.pumpApp(MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
    ));
    
    // Verificar contraste de cores
    final contrast = await checkContrast(
      foreground: Colors.black,
      background: lightTheme.colorScheme.surface,
    );
    
    expect(
      contrast,
      greaterThanOrEqualTo(4.5), // WCAG AA
    );
  });

  testWidgets('dark theme meets contrast ratio', ($) async {
    await $.pumpApp(MaterialApp(
      theme: darkTheme,
      home: HomeScreen(),
    ));
    
    final contrast = await checkContrast(
      foreground: Colors.white,
      background: darkTheme.colorScheme.surface,
    );
    
    expect(contrast, greaterThanOrEqualTo(4.5));
  });

  testWidgets('buttons have sufficient contrast', ($) async {
    await $.pumpApp(MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        body: PrimaryButton(
          text: 'Salvar',
          onPressed: () {},
        ),
      ),
    ));
    
    final contrast = await checkButtonContrast();
    expect(contrast, greaterThanOrEqualTo(4.5));
  });
});
```

### 4. Escala de Fonte

```dart
group('Font Scale', () {
  testWidgets('should support small font (0.85x)', ($) async {
    await $.pumpApp(MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 0.85,
        ),
        child: child!,
      ),
    ));
    
    // Verificar que texto não está truncado
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('should support large font (1.5x)', ($) async {
    await $.pumpApp(MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.5,
        ),
        child: child!,
      ),
    ));
    
    // Verificar que texto não está truncado
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('should support extra large font (2.0x)', ($) async {
    await $.pumpApp(MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 2.0,
        ),
        child: child!,
      ),
    ));
    
    // Verificar que texto não está truncado
    expect(find.byType(HomeScreen), findsOneWidget);
  });
});
```

### 5. Navegação por Teclado

```dart
group('Keyboard Navigation', () {
  testWidgets('should support tab navigation', ($) async {
    await $.pumpApp(CreateProfileScreen());
    
    // Simular Tab
    await $.sendKeyEvent(LogicalKeyboardKey.tab);
    await $.pump();
    
    // Verificar foco
    expect(
      find.byType(FocusNode),
      findsWidgets,
    );
  });

  testWidgets('should support enter to activate', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Focar no botão
    await $.sendKeyEvent(LogicalKeyboardKey.tab);
    await $.pump();
    
    // Ativar com Enter
    await $.sendKeyEvent(LogicalKeyboardKey.enter);
    await $.pumpAndSettle();
    
    // Verificar ação executada
    expect(find.byType(CreateProfileScreen), findsOneWidget);
  });

  testWidgets('should trap focus in modal', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Abrir modal
    await $.tap(find.byKey(Key('delete_button')));
    await $.pumpAndSettle();
    
    // Tentar sair com Tab
    for (var i = 0; i < 10; i++) {
      await $.sendKeyEvent(LogicalKeyboardKey.tab);
      await $.pump();
    }
    
    // Foco deve permanecer no modal
    expect(find.byType(AlertDialog), findsOneWidget);
  });
});
```

### 6. Foco

```dart
group('Focus Management', () {
  testWidgets('should have visible focus indicator', ($) async {
    await $.pumpApp(CreateProfileScreen());
    
    await $.sendKeyEvent(LogicalKeyboardKey.tab);
    await $.pump();
    
    // Verificar indicador de foco
    expect(
      find.byType(Focus),
      findsWidgets,
    );
  });

  testWidgets('should restore focus after navigation', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Focar no botão
    final button = find.byKey(Key('profile_button'));
    await $.tap(button);
    await $.pumpAndSettle();
    
    // Voltar
    await $.sendKeyEvent(LogicalKeyboardKey.escape);
    await $.pumpAndSettle();
    
    // Verificar foco restaurado
    expect(
      find.byKey(Key('profile_button')),
      findsOneWidget,
    );
  });
});
```

## Helper de Acessibilidade

```dart
class AccessibilityHelper {
  static Future<double> checkContrast({
    required Color foreground,
    required Color background,
  }) async {
    final l1 = _relativeLuminance(background);
    final l2 = _relativeLuminance(foreground);
    
    final lighter = max(l1, l2);
    final darker = min(l1, l2);
    
    return (lighter + 0.05) / (darker + 0.05);
  }

  static double _relativeLuminance(Color color) {
    final rs = color.red / 255;
    final gs = color.green / 255;
    final bs = color.blue / 255;
    
    final r = rs <= 0.03928 ? rs / 12.92 : pow((rs + 0.055) / 1.055, 2.4);
    final g = gs <= 0.03928 ? gs / 12.92 : pow((gs + 0.055) / 1.055, 2.4);
    final b = bs <= 0.03928 ? bs / 12.92 : pow((bs + 0.055) / 1.055, 2.4);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }
}
```

## Checklist de Acessibilidade

- [ ] Todos os elementos têm labels semânticos
- [ ] Ordem de navegação é lógica
- [ ] Contraste ≥ 4.5:1 (texto normal)
- [ ] Contraste ≥ 3:1 (texto grande)
- [ ] Fonte escala até 200%
- [ ] Foco é visível
- [ ] Navegação por teclado funciona
- [ ] Estados são anunciados
- [ ] Erros são anunciados
- [ ] Modais trapam foco
- [ ] Touch targets ≥ 48x48
- [ ] Sem dependência de cor
- [ ] Animações podem ser pausadas

## Execução

```bash
# Rodar testes de acessibilidade
flutter test test/accessibility/

# Verificar com ferramentas nativas
# Android: Accessibility Scanner
# iOS: Accessibility Inspector
```

## Métricas

| Métrica | Meta |
|---------|------|
| WCAG 2.1 AA | 100% |
| Labels semânticos | 100% |
| Contraste mínimo | 4.5:1 |
| Touch targets | ≥ 48x48 |
| Navegação por teclado | 100% |
