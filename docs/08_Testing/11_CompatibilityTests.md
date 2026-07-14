# Testes de Compatibilidade — VCardSmart

## Objetivo

Garantir que o aplicativo funcione corretamente em todas as plataformas, versões e dispositivos suportados.

## Plataformas Suportadas

### Android

| API | Versão | Nome | Suporte |
|-----|--------|------|---------|
| 21 | 5.0 | Lollipop | Mínimo |
| 23 | 6.0 | Marshmallow | ✅ |
| 26 | 8.0 | Oreo | ✅ |
| 28 | 9.0 | Pie | ✅ |
| 29 | 10 | Q | ✅ |
| 30 | 11 | R | ✅ |
| 31 | 12 | S | ✅ |
| 33 | 13 | Tiramisu | ✅ |
| 34 | 14 | Upside Down Cake | Alvo |

### iOS

| Versão | Dispositivo | Suporte |
|--------|-------------|---------|
| 12.0 | iPhone 5s+ | Mínimo |
| 13.0 | iPhone 6+ | ✅ |
| 14.0 | iPhone 8+ | ✅ |
| 15.0 | iPhone 12+ | ✅ |
| 16.0 | iPhone 14+ | ✅ |
| 17.0 | iPhone 15+ | Alvo |

### iPad

| Versão | Modelo | Suporte |
|--------|--------|---------|
| 12.0+ | iPad Air 2+ | ✅ |
| 13.0+ | iPad Pro | ✅ |
| 14.0+ | iPad Mini 4+ | ✅ |
| 15.0+ | iPad 9th gen+ | ✅ |

### Dobráveis

| Dispositivo | Status | Notas |
|-------------|--------|-------|
| Samsung Galaxy Fold | ✅ | Testar transição |
| Samsung Galaxy Flip | ✅ | Testar transição |
| Google Pixel Fold | ✅ | Testar transição |
| Huawei Mate X | ⚠️ | Limitado |

## Estrutura

```
test/compatibility/
├── android/
│   ├── api_21_test.dart
│   ├── api_26_test.dart
│   ├── api_30_test.dart
│   └── api_34_test.dart
├── ios/
│   ├── ios_12_test.dart
│   ├── ios_15_test.dart
│   └── ios_17_test.dart
├── devices/
│   ├── tablet_test.dart
│   ├── foldable_test.dart
│   └── small_screen_test.dart
└── orientation/
    ├── portrait_test.dart
    └── landscape_test.dart
```

## Casos de Teste

### Android

```dart
void main() {
  group('Android Compatibility', () {
    testWidgets('API 21 - Lollipop', ($) async {
      // Configurar emulador API 21
      await $.pumpApp(HomeScreen());
      
      // Verificar funcionalidade básica
      expect(find.byType(HomeScreen), findsOneWidget);
      
      // Verificar recursos nativos
      expect(await checkNfcSupport(), isNotNull);
    });

    testWidgets('API 34 - Latest', ($) async {
      // Configurar emulador API 34
      await $.pumpApp(HomeScreen());
      
      // Verificar todas as funcionalidades
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
```

### iOS

```dart
group('iOS Compatibility', () {
  testWidgets('iOS 12 - Minimum', ($) async {
    // Configurar simulador iOS 12
    await $.pumpApp(HomeScreen());
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('iOS 17 - Latest', ($) async {
    // Configurar simulador iOS 17
    await $.pumpApp(HomeScreen());
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });
});
```

### Tablet

```dart
group('Tablet Compatibility', () {
  testWidgets('iPad layout', ($) async {
    tester.view.physicalSize = Size(1024, 768);
    
    await $.pumpApp(HomeScreen());
    await $.pumpAndSettle();
    
    // Verificar layout adaptado
    expect(find.byType(TwoColumnLayout), findsOneWidget);
  });

  testWidgets('Android tablet layout', ($) async {
    tester.view.physicalSize = Size(800, 1280);
    
    await $.pumpApp(HomeScreen());
    await $.pumpAndSettle();
    
    expect(find.byType(TwoColumnLayout), findsOneWidget);
  });
});
```

### Dobráveis

```dart
group('Foldable Compatibility', () {
  testWidgets('transition when unfolding', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Dobrado
    tester.view.physicalSize = Size(360, 800);
    await $.pump();
    
    // Desdobrado
    tester.view.physicalSize = Size(720, 800);
    await $.pumpAndSettle();
    
    // Verificar transição suave
    expect(find.byType(HomeScreen), findsOneWidget);
  });
});
```

### Orientação

```dart
group('Orientation', () {
  testWidgets('portrait mode', ($) async {
    tester.view.physicalSize = Size(390, 844);
    
    await $.pumpApp(HomeScreen());
    await $.pumpAndSettle();
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('landscape mode', ($) async {
    tester.view.physicalSize = Size(844, 390);
    
    await $.pumpApp(HomeScreen());
    await $.pumpAndSettle();
    
    // Verificar layout adaptado
    expect(find.byType(LandscapeLayout), findsOneWidget);
  });
});
```

## Dispositivos de Teste

### Android Emuladores

| Dispositivo | API | Resolução |
|-------------|-----|-----------|
| Nexus 5 | 21 | 1080x1920 |
| Pixel 2 | 28 | 1080x1920 |
| Pixel 6 | 33 | 1080x2400 |
| Galaxy S22 | 33 | 1080x2340 |
| Pixel Tablet | 33 | 1600x2560 |

### iOS Simulators

| Dispositivo | iOS | Resolução |
|-------------|-----|-----------|
| iPhone SE | 15 | 375x667 |
| iPhone 14 | 16 | 390x844 |
| iPhone 14 Pro Max | 16 | 430x932 |
| iPad Air | 16 | 820x1180 |
| iPad Pro 12.9" | 16 | 1024x1366 |

## Comandos de Teste

```bash
# Android API 21
flutter test --device emulator-5554 --flavor dev

# Android API 34
flutter test --device emulator-5556 --flavor dev

# iOS iPhone 14
flutter test --device iPhone\ 14 --flavor dev

# iOS iPad
flutter test --device iPad\ Air --flavor dev

# Todos os dispositivos
flutter test --all-platforms
```

## Matriz de Compatibilidade

| Funcionalidade | Android 21+ | Android 34 | iOS 12+ | iOS 17 | Tablet | Dobrável |
|----------------|-------------|------------|---------|--------|--------|----------|
| Perfil | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| QR Code | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| NFC | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| vCard | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Agenda | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Biometria | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Tema | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Idioma | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

## Métricas

| Métrica | Meta |
|---------|------|
| Plataformas suportadas | Android 21+, iOS 12+ |
| Dispositivos testados | 10+ |
| Funcionalidades por dispositivo | 100% |
| Bugs de compatibilidade | 0 |
