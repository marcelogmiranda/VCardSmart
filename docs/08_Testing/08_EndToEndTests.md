# Testes End-to-End — VCardSmart

## Objetivo

Testar fluxos completos do usuário em设备 real ou emulador, simulando interações reais.

## Cobertura Mínima

- **100% dos fluxos críticos do negócio**
- **Caminho feliz e caminhos de erro**
- **Multitarefa e orientação**

## Fluxos Críticos

### 1. Primeira Utilização

```dart
void main() {
  patrolTest('first use - create profile', ($) async {
    await $.pumpApp(HomeScreen());

    // App inicia vazio
    expect($('Crie seu perfil'), findsOneWidget);

    // Criar perfil
    await $.tap(find.byKey(Key('create_profile_button')));
    await $.pumpAndSettle();

    // Preencher formulário
    await $.enterText(find.byKey(Key('name_field')), 'João Silva');
    await $.enterText(find.byKey(Key('email_field')), 'joao@email.com');
    await $.enterText(find.byKey(Key('phone_field')), '+5511999999999');
    await $.enterText(find.byKey(Key('company_field')), 'Empresa LTDA');

    // Salvar
    await $.tap(find.byKey(Key('save_button')));
    await $.pumpAndSettle();

    // Verificar perfil criado
    expect($('João Silva'), findsOneWidget);
    expect($('joao@email.com'), findsOneWidget);
  });
}
```

### 2. Criar e Compartilhar Perfil

```dart
patrolTest('create and share profile via QR', ($) async {
  await $.pumpApp(HomeScreen());

  // Criar perfil
  await $.tap(find.byKey(Key('create_profile_button')));
  await $.pumpAndSettle();
  await $.enterText(find.byKey(Key('name_field')), 'Maria Santos');
  await $.enterText(find.byKey(Key('email_field')), 'maria@email.com');
  await $.enterText(find.byKey(Key('phone_field')), '+5511888888888');
  await $.tap(find.byKey(Key('save_button')));
  await $.pumpAndSettle();

  // Gerar QR Code
  await $.tap(find.byKey(Key('share_qrcode_button')));
  await $.pumpAndSettle();

  // Verificar QR gerado
  expect(find.byType(QrImage), findsOneWidget);

  // Compartilhar
  await $.tap(find.byKey(Key('share_button')));
  await $.pumpAndSettle();

  // Verificar opções
  expect($('Salvar Imagem'), findsOneWidget);
});
```

### 3. Ler NFC e Salvar Contato

```dart
patrolTest('read NFC and save contact', ($) async {
  await $.pumpApp(HomeScreen());

  // Iniciar leitura NFC
  await $.tap(find.byKey(Key('nfc_button')));
  await $.pumpAndSettle();

  // Simular detecção de tag
  await mockNfcTag($, NfcDataFixture.valid());
  await $.pumpAndSettle();

  // Verificar dados lidos
  expect($('João Silva'), findsOneWidget);

  // Salvar contato
  await $.tap(find.byKey(Key('save_contact_button')));
  await $.pumpAndSettle();

  // Verificar sucesso
  expect($('Contato salvo com sucesso'), findsOneWidget);
});
```

### 4. Importar Contato da Agenda

```dart
patrolTest('import contact from agenda', ($) async {
  await $.pumpApp(HomeScreen());

  // Importar contato
  await $.tap(find.byKey(Key('import_button')));
  await $.pumpAndSettle();

  // Conceder permissão
  await mockPermission($, Permission.contacts);
  await $.pumpAndSettle();

  // Selecionar contato
  await $.tap(find.byKey(Key('contact_joao')));
  await $.pumpAndSettle();

  // Verificar importação
  expect($('Contato importado'), findsOneWidget);
});
```

### 5. Alterar Configurações

```dart
patrolTest('change theme and language', ($) async {
  await $.pumpApp(HomeScreen());

  // Abrir configurações
  await $.tap(find.byKey(Key('settings_button')));
  await $.pumpAndSettle();

  // Alterar tema
  await $.tap(find.byKey(Key('theme_option')));
  await $.pumpAndSettle();
  await $.tap(find.byKey(Key('dark_theme')));
  await $.pumpAndSettle();

  // Alterar idioma
  await $.tap(find.byKey(Key('language_option')));
  await $.pumpAndSettle();
  await $.tap(find.byKey(Key('english')));
  await $.pumpAndSettle();

  // Verificar mudanças
  expect($('Settings'), findsOneWidget);
});
```

### 6. Compartilhar vCard

```dart
patrolTest('share vCard via多种方式', ($) async {
  await $.pumpApp(HomeScreen());

  // Gerar vCard
  await $.tap(find.byKey(Key('vcard_button')));
  await $.pumpAndSettle();

  // Compartilhar
  await $.tap(find.byKey(Key('share_vcard_button')));
  await $.pumpAndSettle();

  // Verificar opções
  expect($('Email'), findsOneWidget);
  expect($('WhatsApp'), findsOneWidget);
  expect($('Salvar Arquivo'), findsOneWidget);
});
```

## Configuração

### patrol_config.yaml

```yaml
targets:
  - test/integration/e2e/

devices:
  - android:
      - Pixel 6
      - Samsung Galaxy S22
  - ios:
      - iPhone 14
      - iPad Air

timeouts:
  tap: 5000ms
  settle: 10000ms
  test: 60000ms
```

## Execução

```dart
// Rodar todos os E2E tests
patrol test

// Rodar em device específico
patrol test --device "Pixel 6"

// Rodar teste específico
patrol test --name "first use"

// Rodar com verbose
patrol test --verbose
```

## Métricas

| Métrica | Meta |
|---------|------|
| Fluxos críticos cobertos | 100% |
| Taxa de passagem | ≥ 95% |
| Tempo médio por teste | < 30s |
| Flaky tests | < 5% |
