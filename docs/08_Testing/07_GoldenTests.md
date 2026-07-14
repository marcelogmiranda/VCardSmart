# Testes Golden — VCardSmart

## Objetivo

Garantir consistência visual entre versões, comparando renders de componentes com arquivos de referência (golden files).

## Cobertura Mínima

- **100% dos componentes reutilizáveis**
- **100% das telas principais**
- **Todos os temas**: Claro, Escuro
- **Todos os tamanhos**: Smartphone, Tablet
- **Acessibilidade**: Alto contraste, fonte grande

## Estrutura

```
test/golden/
├── components/
│   ├── buttons/
│   │   ├── primary_button_golden_test.dart
│   │   └── icon_button_golden_test.dart
│   ├── inputs/
│   │   ├── text_field_golden_test.dart
│   │   └── masked_input_golden_test.dart
│   ├── cards/
│   │   ├── profile_card_golden_test.dart
│   │   └── contact_card_golden_test.dart
│   └── dialogs/
│       ├── confirm_dialog_golden_test.dart
│       └── error_dialog_golden_test.dart
├── screens/
│   ├── home/
│   │   └── home_screen_golden_test.dart
│   ├── profile/
│   │   └── profile_screen_golden_test.dart
│   ├── qrcode/
│   │   └── qrcode_screen_golden_test.dart
│   ├── nfc/
│   │   └── nfc_screen_golden_test.dart
│   └── settings/
│       └── settings_screen_golden_test.dart
└── golden_files/
    ├── components/
    │   ├── primary_button_light.png
    │   ├── primary_button_dark.png
    │   └── ...
    └── screens/
        ├── home_light.png
        ├── home_dark.png
        └── ...
```

## Padrão de Teste

### Golden Test Básico

```dart
void main() {
  group('PrimaryButton Golden', () {
    testWidgets('light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: PrimaryButton(
              text: 'Salvar',
              onPressed: () {},
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PrimaryButton),
        matchesGoldenFile('golden_files/components/primary_button_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: darkTheme,
          home: Scaffold(
            body: PrimaryButton(
              text: 'Salvar',
              onPressed: () {},
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PrimaryButton),
        matchesGoldenFile('golden_files/components/primary_button_dark.png'),
      );
    });
  });
}
```

### Golden Test com Estado

```dart
testWidgets('primary button disabled', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        body: PrimaryButton(
          text: 'Salvar',
          onPressed: null, // Desabilitado
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(PrimaryButton),
    matchesGoldenFile('golden_files/components/primary_button_disabled.png'),
  );
});
```

### Golden Test de Tela

```dart
testWidgets('home screen light theme', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
    ),
  );
  await tester.pumpAndSettle();

  await expectLater(
    find.byType(HomeScreen),
    matchesGoldenFile('golden_files/screens/home_light.png'),
  );
});
```

### Golden Test com Tamanho de Tela

```dart
testWidgets('home screen tablet', (tester) async {
  tester.view.physicalSize = Size(1024, 768);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
    ),
  );
  await tester.pumpAndSettle();

  await expectLater(
    find.byType(HomeScreen),
    matchesGoldenFile('golden_files/screens/home_tablet.png'),
  );

  tester.view.resetPhysicalSize();
});
```

## Temas Testados

| Tema | Descrição |
|------|-----------|
| light | Tema claro padrão |
| dark | Tema escuro |
| highContrast | Alto contraste (acessibilidade) |

## Dispositivos Testados

| Dispositivo | Largura | Altura |
|-------------|---------|--------|
| iPhone SE | 375 | 667 |
| iPhone 14 | 390 | 844 |
| iPad | 768 | 1024 |
| Tablet Android | 800 | 1280 |

## Comandos

```dart
// Rodar todos os golden tests
flutter test test/golden/

// Atualizar golden files
flutter test --update-goldens test/golden/

// Rodar golden específico
flutter test test/golden/components/buttons/primary_button_golden_test.dart

// Verificar diferenças
flutter test --reporter expanded test/golden/
```

## Fluxo de Trabalho

1. **Criar teste** — Definir widget e cenário
2. **Gerar golden** — Rodar com `--update-goldens`
3. **Revisar** — Verificar se a imagem está correta
4. **Commit** — Versionar golden files
5. **CI** — Verificar consistência a cada PR

## Quando Atualizar Goldens

- Mudança intencional de design
- Correção de bug visual
- Atualização de dependência que afeta UI
- Novo tema adicionado

## Métricas

| Métrica | Meta |
|---------|------|
| Componentes cobertos | 100% |
| Telas cobertas | 100% |
| Temas cobertos | 100% |
| Testes passando | 100% |
| Golden files versionados | 100% |
