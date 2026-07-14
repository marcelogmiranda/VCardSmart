# Testes de Segurança — VCardSmart

## Objetivo

Garantir que todos os dados do usuário estejam protegidos contra acesso não autorizado e que o aplicativo siga melhores práticas de segurança.

## Áreas de Teste

### 1. Autenticação Biometria

```dart
void main() {
  group('Biometric Authentication', () {
    testWidgets('should authenticate with valid biometric', ($) async {
      await $.pumpApp(SettingsScreen());
      
      await mockBiometric(true); // Simula biometria válida
      await $.tap(find.byKey(Key('biometric_toggle')));
      await $.pumpAndSettle();
      
      expect(find.text('Biometria ativada'), findsOneWidget);
    });

    testWidgets('should reject invalid biometric', ($) async {
      await $.pumpApp(SettingsScreen());
      
      await mockBiometric(false); // Simula biometria inválida
      await $.tap(find.byKey(Key('biometric_toggle')));
      await $.pumpAndSettle();
      
      expect(find.text('Biometria não reconhecida'), findsOneWidget);
    });

    testWidgets('should fallback to PIN after 3 failures', ($) async {
      await $.pumpApp(LockScreen());
      
      // 3 tentativas inválidas
      for (var i = 0; i < 3; i++) {
        await mockBiometric(false);
        await $.tap(find.byKey(Key('retry_biometric')));
        await $.pumpAndSettle();
      }
      
      // Deve solicitar PIN
      expect(find.byType(PinInput), findsOneWidget);
    });
  });
}
```

### 2. PIN

```dart
group('PIN Authentication', () {
  testWidgets('should accept correct PIN', ($) async {
    await $.pumpApp(PinScreen());
    
    await $.enterText(find.byType(PinInput), '1234');
    await $.pumpAndSettle();
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('should reject incorrect PIN', ($) async {
    await $.pumpApp(PinScreen());
    
    await $.enterText(find.byType(PinInput), '0000');
    await $.pumpAndSettle();
    
    expect(find.text('PIN incorreto'), findsOneWidget);
  });

  testWidgets('should lock after 5 failed attempts', ($) async {
    await $.pumpApp(PinScreen());
    
    for (var i = 0; i < 5; i++) {
      await $.enterText(find.byType(PinInput), '0000');
      await $.pumpAndSettle();
    }
    
    expect(find.text('Conta bloqueada por 5 minutos'), findsOneWidget);
  });

  testWidgets('should require PIN on app resume', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Simular suspensão
    await sendAppToBackground();
    await resumeApp();
    
    expect(find.byType(PinScreen), findsOneWidget);
  });
});
```

### 3. Criptografia Hive

```dart
group('Hive Encryption', () {
  test('should encrypt data at rest', () async {
    final service = HiveService();
    final profile = ProfileFixture.valid();
    
    await service.saveProfile(profile);
    
    // Verificar dados criptografados no disco
    final rawData = await readRawHiveData('profiles');
    expect(rawData, isNot(contains('João Silva')));
    
    // Verificar dados descriptografados em memória
    final loaded = await service.getProfile();
    expect(loaded.name, equals('João Silva'));
  });

  test('should not decrypt without key', () async {
    final service = HiveService();
    
    // Tentar ler sem chave
    expect(
      () => service.getRawData('profiles'),
      throwsA(isA<EncryptionException>()),
    );
  });
});
```

### 4. Secure Storage

```dart
group('Secure Storage', () {
  test('should store PIN securely', () async {
    final storage = SecureStorageService();
    
    await storage.savePin('1234');
    
    // Verificar que não está em texto plano
    final raw = await readRawSecureStorage('pin');
    expect(raw, isNot(equals('1234')));
  });

  test('should not expose PIN in logs', () async {
    final storage = SecureStorageService();
    
    // Capturar logs
    final logs = await captureLogs(() async {
      await storage.savePin('1234');
    });
    
    expect(logs, isNot(contains('1234')));
  });
});
```

### 5. Validação de Input

```dart
group('Input Validation', () {
  testWidgets('should sanitize SQL injection', ($) async {
    await $.pumpApp(CreateProfileScreen());
    
    await $.enterText(
      find.byKey(Key('name_field')),
      "'; DROP TABLE profiles; --",
    );
    await $.tap(find.byKey(Key('save_button')));
    await $.pumpAndSettle();
    
    // Dados devem ser salvos de forma segura
    expect(find.text('Perfil salvo'), findsOneWidget);
  });

  testWidgets('should prevent XSS in display', ($) async {
    await $.pumpApp(ProfileScreen());
    
    final profile = Profile(
      name: '<script>alert("xss")</script>',
    );
    
    await loadProfile(profile);
    await $.pumpAndSettle();
    
    // Script não deve ser executado
    expect(find.text('<script>'), findsOneWidget);
  });

  testWidgets('should validate URL format', ($) async {
    await $.pumpApp(CreateProfileScreen());
    
    await $.enterText(
      find.byKey(Key('website_field')),
      'javascript:alert(1)',
    );
    await $.tap(find.byKey(Key('save_button')));
    await $.pumpAndSettle();
    
    expect(find.text('URL inválida'), findsOneWidget);
  });
});
```

### 6. Permissões

```dart
group('Permissions', () {
  testWidgets('should handle denied camera permission', ($) async {
    await $.pumpApp(QRCodeScannerScreen());
    
    await mockPermission(Permission.camera, false);
    await $.pumpAndSettle();
    
    expect(
      find.text('Permissão de câmera necessária'),
      findsOneWidget,
    );
  });

  testWidgets('should handle denied NFC permission', ($) async {
    await $.pumpApp(NfcReadScreen());
    
    await mockNfcPermission(false);
    await $.pumpAndSettle();
    
    expect(
      find.text('NFC não disponível'),
      findsOneWidget,
    );
  });
});
```

### 7. Timeout e Lock

```dart
group('Timeout and Lock', () {
  testWidgets('should lock after inactivity', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Simular inatividade de 5 minutos
    await advanceTime(Duration(minutes: 5));
    await $.pumpAndSettle();
    
    expect(find.byType(LockScreen), findsOneWidget);
  });

  testWidgets('should clear sensitive data on lock', ($) async {
    await $.pumpApp(HomeScreen());
    
    await advanceTime(Duration(minutes: 5));
    await $.pumpAndSettle();
    
    // Dados sensíveis não devem estar em memória
    expect(getSensitiveDataInMemory(), isEmpty);
  });
});
```

### 8. Compartilhamento Seguro

```dart
group('Secure Sharing', () {
  testWidgets('should not share PIN via NFC', ($) async {
    await $.pumpApp(HomeScreen());
    
    await $.tap(find.byKey(Key('nfc_button')));
    await $.pumpAndSettle();
    
    // Verificar que PIN não está nos dados NFC
    final nfcData = await captureNfcData();
    expect(nfcData, isNot(contains('pin')));
  });

  testWidgets('should encrypt vCard data', ($) async {
    await $.pumpApp(HomeScreen());
    
    await $.tap(find.byKey(Key('vcard_button')));
    await $.pumpAndSettle();
    
    final vcard = await getGeneratedVCard();
    
    // Verificar que dados sensíveis estão ofuscados
    expect(vcard, isNot(contains('password')));
  });
});
```

## Checklist de Segurança

- [ ] Biometria funciona corretamente
- [ ] PIN é validado com hash
- [ ] Hive está criptografado
- [ ] Secure Storage não expõe dados
- [ ] Input é sanitizado
- [ ] Permissões são tratadas
- [ ] Timeout está funcionando
- [ ] Lock automático está ativo
- [ ] Dados sensíveis são limpos da memória
- [ ] Compartilhamento é seguro
- [ ] Logs não contêm dados sensíveis
- [ ] Certificado SSL é validado
- [ ] API keys não estão no código

## Execução

```dart
// Rodar testes de segurança
flutter test test/security/

// Rodar com cobertura de segurança
flutter test --coverage test/security/

// Rodar teste específico
flutter test test/security/biometric_test.dart
```

## Métricas

| Métrica | Meta |
|---------|------|
| Vulnerabilidades críticas | 0 |
| Vulnerabilidades altas | 0 |
| Vulnerabilidades médias | < 3 |
| Cenários testados | 100% |
| Checklist completo | 100% |
