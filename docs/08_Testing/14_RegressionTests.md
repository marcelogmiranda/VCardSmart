# Testes de Regressão — VCardSmart

## Objetivo

Garantir que funcionalidades que já funcionavam continuem funcionando após mudanças no código.

## Quando Executar

- **Antes de cada Release**
- **Após cada merge na main**
- **Após atualização de dependências**
- **Após correção de bugs**

## Suite de Regressão

### Funcionalidades Críticas

| ID | Funcionalidade | Prioridade | Testes |
|----|----------------|------------|--------|
| R-01 | Criar perfil | P0 | unit, widget, integration |
| R-02 | Editar perfil | P0 | unit, widget, integration |
| R-03 | Gerar QR Code | P0 | unit, widget, integration |
| R-04 | Escanear QR Code | P0 | unit, widget, integration |
| R-05 | Ler NFC | P0 | unit, widget, integration |
| R-06 | Escrever NFC | P0 | unit, widget, integration |
| R-07 | Gerar vCard | P0 | unit, widget, integration |
| R-08 | Importar vCard | P1 | unit, widget, integration |
| R-09 | Exportar para agenda | P1 | unit, widget, integration |
| R-10 | Autenticação biométrica | P0 | unit, widget, integration |
| R-11 | PIN | P0 | unit, widget, integration |
| R-12 | Criptografia | P0 | unit |
| R-13 | Alterar tema | P1 | widget |
| R-14 | Alterar idioma | P1 | widget |
| R-15 | Modo offline | P0 | integration |

### Estrutura

```
test/regression/
├── profile_regression_test.dart
├── qrcode_regression_test.dart
├── nfc_regression_test.dart
├── vcard_regression_test.dart
├── settings_regression_test.dart
├── security_regression_test.dart
├── offline_regression_test.dart
└── helpers/
    └── regression_helper.dart
```

## Casos de Teste

### R-01: Criar Perfil

```dart
void main() {
  group('Regression: Create Profile', () {
    testWidgets('should create profile with all fields', ($) async {
      await $.pumpApp(CreateProfileScreen());
      
      // Preencher todos os campos
      await $.enterText(find.byKey(Key('name_field')), 'João Silva');
      await $.enterText(find.byKey(Key('email_field')), 'joao@email.com');
      await $.enterText(find.byKey(Key('phone_field')), '+5511999999999');
      await $.enterText(find.byKey(Key('company_field')), 'Empresa LTDA');
      await $.enterText(find.byKey(Key('website_field')), 'https://empresa.com');
      await $.enterText(find.byKey(Key('address_field')), 'Rua A, 123');
      
      // Salvar
      await $.tap(find.byKey(Key('save_button')));
      await $.pumpAndSettle();
      
      // Verificar criação
      expect(find.text('Perfil criado com sucesso'), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('should validate required fields', ($) async {
      await $.pumpApp(CreateProfileScreen());
      
      // Tentar salvar sem preencher
      await $.tap(find.byKey(Key('save_button')));
      await $.pumpAndSettle();
      
      // Verificar validação
      expect(find.text('Nome é obrigatório'), findsOneWidget);
      expect(find.text('Email é obrigatório'), findsOneWidget);
    });

    testWidgets('should save profile offline', ($) async {
      await mockOfflineMode();
      await $.pumpApp(CreateProfileScreen());
      
      await $.enterText(find.byKey(Key('name_field')), 'João Silva');
      await $.enterText(find.byKey(Key('email_field')), 'joao@email.com');
      await $.enterText(find.byKey(Key('phone_field')), '+5511999999999');
      
      await $.tap(find.byKey(Key('save_button')));
      await $.pumpAndSettle();
      
      // Verificar que salvou offline
      expect(find.text('Perfil salvo offline'), findsOneWidget);
    });
  });
}
```

### R-03: Gerar QR Code

```dart
group('Regression: QR Code', () {
  testWidgets('should generate QR from profile', ($) async {
    await $.pumpApp(HomeScreen());
    
    await $.tap(find.byKey(Key('qrcode_button')));
    await $.pumpAndSettle();
    
    // Verificar QR gerado
    expect(find.byType(QrImage), findsOneWidget);
  });

  testWidgets('should share QR as image', ($) async {
    await $.pumpApp(QRCodeScreen());
    
    await $.tap(find.byKey(Key('share_image_button')));
    await $.pumpAndSettle();
    
    expect(find.text('Imagem salva'), findsOneWidget);
  });
});
```

### R-05: Ler NFC

```dart
group('Regression: NFC', () {
  testWidgets('should read NFC tag', ($) async {
    await $.pumpApp(NfcReadScreen());
    
    await mockNfcTag($, NfcDataFixture.valid());
    await $.pumpAndSettle();
    
    expect(find.byType(ContactPreview), findsOneWidget);
  });

  testWidgets('should handle invalid NFC data', ($) async {
    await $.pumpApp(NfcReadScreen());
    
    await mockNfcTag($, NfcDataFixture.invalid());
    await $.pumpAndSettle();
    
    expect(find.text('Dados NFC inválidos'), findsOneWidget);
  });
});
```

### R-10: Biometria

```dart
group('Regression: Biometric', () {
  testWidgets('should authenticate with biometric', ($) async {
    await $.pumpApp(LockScreen());
    
    await mockBiometric(true);
    await $.tap(find.byKey(Key('biometric_button')));
    await $.pumpAndSettle();
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('should fallback to PIN', ($) async {
    await $.pumpApp(LockScreen());
    
    await mockBiometric(false);
    await $.tap(find.byKey(Key('biometric_button')));
    await $.pumpAndSettle();
    
    expect(find.byType(PinScreen), findsOneWidget);
  });
});
```

### R-15: Modo Offline

```dart
group('Regression: Offline', () {
  testWidgets('should work without network', ($) async {
    await mockOfflineMode();
    await $.pumpApp(HomeScreen());
    
    // Criar perfil
    await $.tap(find.byKey(Key('create_profile_button')));
    await $.pumpAndSettle();
    
    await $.enterText(find.byKey(Key('name_field')), 'João Silva');
    await $.enterText(find.byKey(Key('email_field')), 'joao@email.com');
    await $.tap(find.byKey(Key('save_button')));
    await $.pumpAndSettle();
    
    expect(find.text('Perfil salvo offline'), findsOneWidget);
  });

  testWidgets('should sync when online', ($) async {
    // Criar offline
    await mockOfflineMode();
    await createProfile();
    
    // Ficar online
    await mockOnlineMode();
    await $.pumpAndSettle();
    
    // Verificar sincronização
    expect(find.text('Dados sincronizados'), findsOneWidget);
  });
});
```

## Execução

```bash
# Rodar suite completa de regressão
flutter test test/regression/

# Rodar regressão específica
flutter test test/regression/profile_regression_test.dart

# Rodar com relatório
flutter test --reporter expanded test/regression/
```

## Processo

1. **Pré-release** — Executar suite completa
2. **Analisar resultados** — Verificar falhas
3. **Corrigir** — Tratar bugs encontrados
4. **Reteste** — Validar correções
5. **Aprovar** — Quality Gate

## Métricas

| Métrica | Meta |
|---------|------|
| Funcionalidades cobertas | 100% |
| Testes passando | 100% |
| Tempo de execução | < 5min |
| Bugs encontrados | < 5 por release |
