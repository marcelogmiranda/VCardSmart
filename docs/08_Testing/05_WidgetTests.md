# Testes de Widget — VCardSmart

## Objetivo

Testar todos os componentes e telas da UI, validando estados, interações e navegação.

## Cobertura Mínima

- **100% das telas**
- **100% dos componentes reutilizáveis**
- **Todos os estados**: Loading, Erro, Vazio, Sucesso

## Estrutura

```
test/widget/
├── screens/
│   ├── profile/
│   │   ├── create_profile_screen_test.dart
│   │   ├── edit_profile_screen_test.dart
│   │   └── view_profile_screen_test.dart
│   ├── qrcode/
│   │   ├── qrcode_generator_screen_test.dart
│   │   └── qrcode_scanner_screen_test.dart
│   ├── nfc/
│   │   ├── nfc_read_screen_test.dart
│   │   └── nfc_write_screen_test.dart
│   ├── settings/
│   │   ├── settings_screen_test.dart
│   │   ├── theme_screen_test.dart
│   │   └── language_screen_test.dart
│   └── home/
│       └── home_screen_test.dart
├── components/
│   ├── buttons/
│   │   ├── primary_button_test.dart
│   │   └── icon_button_test.dart
│   ├── inputs/
│   │   ├── text_field_test.dart
│   │   └── masked_input_test.dart
│   ├── dialogs/
│   │   ├── confirm_dialog_test.dart
│   │   └── error_dialog_test.dart
│   └── cards/
│       ├── profile_card_test.dart
│       └── contact_card_test.dart
└── golden/
    └── golden_test.dart
```

## Padrão de Teste

### Widget Test Básico

```dart
void main() {
  group('CreateProfileScreen', () {
    testWidgets('should render form fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CreateProfileScreen(),
        ),
      );

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show error for empty name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CreateProfileScreen(),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Nome é obrigatório'), findsOneWidget);
    });
  });
}
```

### Teste com Mock/Provider

```dart
void main() {
  group('HomeScreen', () {
    testWidgets('should display profile when loaded', (tester) async {
      final mockProfile = ProfileFixture.valid();

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => ProfileBloc()..add(LoadProfile()),
            child: HomeScreen(),
          ),
        ),
      );

      // Simula carregamento
      when(() => mockRepository.getProfile())
          .thenAnswer((_) async => mockProfile);
      await tester.pumpAndSettle();

      expect(find.text(mockProfile.name), findsOneWidget);
    });
  });
}
```

## Estados por Tela

### HomeScreen

| Estado | Descrição | Teste |
|--------|-----------|-------|
| Loading | Carregando perfil | CircularProgressIndicator visível |
| Empty | Sem perfil | Mensagem "Crie seu perfil" |
| Error | Erro ao carregar | Mensagem de erro + retry |
| Success | Perfil carregado | Dados do perfil visíveis |

### ProfileScreen

| Estado | Descrição | Teste |
|--------|-----------|-------|
| Loading | Salvando | Botão desabilitado |
| Error | Erro ao salvar | SnackBar de erro |
| Success | Perfil salvo | Navegação para Home |

### QRCodeScreen

| Estado | Descrição | Teste |
|--------|-----------|-------|
| Generating | Gerando QR | Loading visível |
| Ready | QR pronto | Imagem QR visível |
| Error | Erro ao gerar | Mensagem de erro |

### NFCScreen

| Estado | Descrição | Teste |
|--------|-----------|-------|
| Scanning | Procurando NFC | Animação de scanning |
| Reading | Lendo tag | Loading |
| Ready | Dados prontos | Botão compartilhar |
| Error | Erro leitura | Mensagem de erro |
| No NFC | Dispositivo sem NFC | Mensagem alternativa |

## Interações Testadas

### Navegação

```dart
testWidgets('should navigate to settings on tap', (tester) async {
  await tester.pumpWidget(MaterialApp(home: HomeScreen()));
  
  await tester.tap(find.byIcon(Icons.settings));
  await tester.pumpAndSettle();
  
  expect(find.byType(SettingsScreen), findsOneWidget);
});
```

### Formulários

```dart
testWidgets('should validate email format', (tester) async {
  await tester.pumpWidget(MaterialApp(home: CreateProfileScreen()));
  
  await tester.enterText(
    find.byKey(Key('email_field')),
    'invalid-email',
  );
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();
  
  expect(find.text('Email inválido'), findsOneWidget);
});
```

### Diálogos

```dart
testWidgets('should show confirm dialog on delete', (tester) async {
  await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
  
  await tester.tap(find.byIcon(Icons.delete));
  await tester.pumpAndSettle();
  
  expect(find.byType(AlertDialog), findsOneWidget);
  expect(find.text('Confirmar exclusão?'), findsOneWidget);
});
```

## Cobertura Visual (Golden)

```dart
testWidgets('HomeScreen light theme', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: lightTheme,
      home: HomeScreen(),
    ),
  );
  await expectLater(
    find.byType(HomeScreen),
    matchesGoldenFile('golden/home_screen_light.png'),
  );
});
```

## Execução

```dart
// Rodar todos os testes de widget
flutter test test/widget/

// Rodar com cobertura
flutter test --coverage test/widget/

// Rodar teste específico
flutter test test/widget/screens/profile/create_profile_screen_test.dart

// Atualizar goldens
flutter test --update-goldens
```

## Métricas

| Métrica | Meta |
|---------|------|
| Cobertura de telas | 100% |
| Cobertura de componentes | 100% |
| Testes passando | 100% |
| Tempo total | < 60s |
| Golden files atualizados | 100% |
