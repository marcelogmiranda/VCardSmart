# Testes de Integração — VCardSmart

## Objetivo

Testar fluxos que envolvem múltiplos módulos trabalhando juntos, incluindo integração com APIs nativas e persistência de dados.

## Cobertura Mínima

- **100% dos fluxos críticos**
- **Circuitos de dados completos**
- **Integração com APIs nativas**

## Estrutura

```
test/integration/
├── flows/
│   ├── profile_flow_test.dart
│   ├── qrcode_flow_test.dart
│   ├── nfc_flow_test.dart
│   ├── vcard_flow_test.dart
│   ├── agenda_flow_test.dart
│   └── settings_flow_test.dart
├── e2e/
│   ├── first_use_test.dart
│   ├── create_and_share_test.dart
│   └── settings_change_test.dart
└── helpers/
    ├── integration_test_helper.dart
    └── test_app.dart
```

## Fluxos de Teste

### 1. Fluxo de Perfil

```dart
void main() {
  group('Profile Flow', () {
    testWidgets('create, edit, and view profile', (tester) async {
      await tester.pumpWidget(TestApp());

      // Criar perfil
      await tester.tap(find.text('Criar Perfil'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('name')), 'João Silva');
      await tester.enterText(find.byKey(Key('email')), 'joao@email.com');
      await tester.enterText(find.byKey(Key('phone')), '+5511999999999');
      await tester.enterText(find.byKey(Key('company')), 'Empresa LTDA');

      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();

      // Verificar perfil criado
      expect(find.text('João Silva'), findsOneWidget);

      // Editar perfil
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('name')), 'João Silva Santos');
      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();

      // Verificar alteração
      expect(find.text('João Silva Santos'), findsOneWidget);
    });
  });
}
```

### 2. Fluxo QR Code

```dart
group('QR Code Flow', () {
  testWidgets('generate and scan QR code', (tester) async {
    await tester.pumpWidget(TestApp());

    // Gerar QR Code
    await tester.tap(find.text('Gerar QR Code'));
    await tester.pumpAndSettle();

    // Verificar QR gerado
    expect(find.byType(QrImage), findsOneWidget);

    // Compartilhar
    await tester.tap(find.byIcon(Icons.share));
    await tester.pumpAndSettle();

    // Verificar opções de compartilhamento
    expect(find.text('Salvar Imagem'), findsOneWidget);
    expect(find.text('Compartilhar'), findsOneWidget);
  });
});
```

### 3. Fluxo NFC

```dart
group('NFC Flow', () {
  testWidgets('read NFC tag with valid data', (tester) async {
    await tester.pumpWidget(TestApp());

    // Iniciar leitura NFC
    await tester.tap(find.text('Ler NFC'));
    await tester.pumpAndSettle();

    // Simular detecção de tag
    await mockNfcTag(tester, NfcDataFixture.valid());
    await tester.pumpAndSettle();

    // Verificar dados lidos
    expect(find.text('João Silva'), findsOneWidget);
    expect(find.text('Salvar Contato'), findsOneWidget);
  });

  testWidgets('handle NFC read error', (tester) async {
    await tester.pumpWidget(TestApp());

    await tester.tap(find.text('Ler NFC'));
    await tester.pumpAndSettle();

    // Simular erro
    await mockNfcError(tester, 'Tag corrompida');
    await tester.pumpAndSettle();

    // Verificar mensagem de erro
    expect(find.text('Erro ao ler NFC'), findsOneWidget);
  });
});
```

### 4. Fluxo vCard

```dart
group('vCard Flow', () {
  testWidgets('generate and import vCard', (tester) async {
    await tester.pumpWidget(TestApp());

    // Gerar vCard
    await tester.tap(find.text('Gerar vCard'));
    await tester.pumpAndSettle();

    // Verificar vCard gerada
    expect(find.text('vCard criada com sucesso'), findsOneWidget);

    // Importar vCard
    await tester.tap(find.text('Importar vCard'));
    await tester.pumpAndSettle();

    // Selecionar arquivo
    await mockFilePicker(tester, VCardFixture.valid());
    await tester.pumpAndSettle();

    // Verificar contato importado
    expect(find.text('Contato importado'), findsOneWidget);
  });
});
```

### 5. Fluxo Agenda

```dart
group('Agenda Flow', () {
  testWidgets('export contacts to agenda', (tester) async {
    await tester.pumpWidget(TestApp());

    // Selecionar contatos
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Exportar para agenda
    await tester.tap(find.text('Exportar para Agenda'));
    await tester.pumpAndSettle();

    // Conceder permissão
    await mockPermission(tester, Permission.contacts);
    await tester.pumpAndSettle();

    // Verificar sucesso
    expect(find.text('Contatos exportados'), findsOneWidget);
  });
});
```

### 6. Fluxo Configurações

```dart
group('Settings Flow', () {
  testWidgets('change theme and language', (tester) async {
    await tester.pumpWidget(TestApp());

    // Abrir configurações
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Alterar tema
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Escuro'));
    await tester.pumpAndSettle();

    // Verificar tema aplicado
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).theme,
      darkTheme,
    );

    // Alterar idioma
    await tester.tap(find.text('Idioma'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Verificar idioma aplicado
    expect(find.text('Settings'), findsOneWidget);
  });
});
```

## Helper de Integração

```dart
class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => getIt<ProfileBloc>(),
        child: HomeScreen(),
      ),
    );
  }
}

Future<void> mockNfcTag(WidgetTester tester, NfcData data) async {
  // Simula detecção de tag NFC
  final nfcService = getIt<NfcService>();
  (nfcService as MockNfcService).mockRead(data);
}
```

## Execução

```dart
// Rodar todos os testes de integração
flutter test test/integration/

// Rodar com device real
flutter test integration_test/

// Rodar fluxo específico
flutter test test/integration/flows/profile_flow_test.dart
```

## Métricas

| Métrica | Meta |
|---------|------|
| Fluxos críticos cobertos | 100% |
| Testes passando | 100% |
| Tempo total | < 5min |
| Flaky tests | 0% |
