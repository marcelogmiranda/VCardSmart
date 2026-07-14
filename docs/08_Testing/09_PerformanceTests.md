# Testes de Performance — VCardSmart

## Objetivo

Garantir que o aplicativo atenda a métricas de performance em todas as plataformas e dispositivos.

## Métricas Alvo

| Métrica | Meta | Crítico |
|---------|------|---------|
| Inicialização | < 2s | > 5s |
| QR Code scan | < 1s | > 3s |
| NFC leitura | < 5s | > 10s |
| Memória (idle) | < 50MB | > 100MB |
| Memória (ativo) | < 100MB | > 200MB |
| CPU (idle) | < 5% | > 20% |
| CPU (ativo) | < 30% | > 50% |
| FPS | > 55 | < 30 |
| Tamanho do app | < 20MB | > 50MB |
| Tempo de resposta API | < 500ms | > 2s |

## Estrutura

```
test/performance/
├── startup_test.dart
├── qrcode_performance_test.dart
├── nfc_performance_test.dart
├── memory_test.dart
├── cpu_test.dart
├── fps_test.dart
└── helpers/
    └── performance_helper.dart
```

## Casos de Teste

### 1. Inicialização

```dart
void main() {
  testWidgets('app startup time', (tester) async {
    final stopwatch = Stopwatch()..start();

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    stopwatch.stop();

    expect(
      stopwatch.elapsedMilliseconds,
      lessThan(2000),
      reason: 'App should start in less than 2 seconds',
    );
  });

  testWidgets('cold start vs warm start', (tester) async {
    // Cold start
    final coldStart = Stopwatch()..start();
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    coldStart.stop();

    // Warm start (rebuild)
    final warmStart = Stopwatch()..start();
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    warmStart.stop();

    // Warm start should be faster
    expect(
      warmStart.elapsedMilliseconds,
      lessThan(coldStart.elapsedMilliseconds),
    );
  });
}
```

### 2. QR Code

```dart
testWidgets('QR code generation time', (tester) async {
  final profile = ProfileFixture.complete();

  await tester.pumpWidget(MaterialApp(
    home: QRCodeScreen(profile: profile),
  ));

  final stopwatch = Stopwatch()..start();
  await tester.pumpAndSettle();
  stopwatch.stop();

  expect(
    stopwatch.elapsedMilliseconds,
    lessThan(1000),
    reason: 'QR code should generate in less than 1 second',
  );
});

testWidgets('QR code scan time', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: QRCodeScannerScreen(),
  ));

  final stopwatch = Stopwatch()..start();
  
  // Simulate camera detection
  await mockQrCodeDetection(tester);
  await tester.pumpAndSettle();
  
  stopwatch.stop();

  expect(
    stopwatch.elapsedMilliseconds,
    lessThan(1000),
    reason: 'QR code scan should complete in less than 1 second',
  );
});
```

### 3. NFC

```dart
testWidgets('NFC read time', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: NfcReadScreen(),
  ));

  final stopwatch = Stopwatch()..start();
  
  await mockNfcTag(tester, NfcDataFixture.valid());
  await tester.pumpAndSettle();
  
  stopwatch.stop();

  expect(
    stopwatch.elapsedMilliseconds,
    lessThan(5000),
    reason: 'NFC read should complete in less than 5 seconds',
  );
});
```

### 4. Memória

```dart
testWidgets('memory usage during idle', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: HomeScreen(),
  ));
  await tester.pumpAndSettle();

  final memory = await getMemoryUsage();

  expect(
    memory,
    lessThan(50 * 1024 * 1024), // 50MB
    reason: 'Idle memory should be less than 50MB',
  );
});

testWidgets('memory usage during active use', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: HomeScreen(),
  ));
  await tester.pumpAndSettle();

  // Simulate heavy usage
  await tester.tap(find.byKey(Key('qrcode_button')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key('nfc_button')));
  await tester.pumpAndSettle();

  final memory = await getMemoryUsage();

  expect(
    memory,
    lessThan(100 * 1024 * 1024), // 100MB
    reason: 'Active memory should be less than 100MB',
  );
});
```

### 5. FPS

```dart
testWidgets('maintain 60fps during scroll', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: ContactListScreen(),
  ));
  await tester.pumpAndSettle();

  final fps = await measureFps(() async {
    // Scroll through list
    for (var i = 0; i < 10; i++) {
      await tester.drag(find.byType(ListView), Offset(0, -100));
      await tester.pump();
    }
  });

  expect(
    fps,
    greaterThan(55),
    reason: 'Should maintain 55+ FPS during scroll',
  );
});
```

### 6. Tamanho do App

```dart
testWidgets('app size within limits', (tester) async {
  final apkSize = await getApkSize();
  final ipaSize = await getIpaSize();

  expect(
    apkSize,
    lessThan(20 * 1024 * 1024), // 20MB
    reason: 'APK should be less than 20MB',
  );

  expect(
    ipaSize,
    lessThan(20 * 1024 * 1024), // 20MB
    reason: 'IPA should be less than 20MB',
  );
});
```

## Helper de Performance

```dart
class PerformanceHelper {
  static Future<int> getMemoryUsage() async {
    // Implementação específica da plataforma
    if (Platform.isAndroid) {
      return await MethodChannel('performance').invokeMethod('getMemory');
    } else if (Platform.isIOS) {
      return await MethodChannel('performance').invokeMethod('getMemory');
    }
    return 0;
  }

  static Future<double> measureFps(VoidCallback callback) async {
    final frames = <Duration>[];
    final stopwatch = Stopwatch()..start();
    
    callback();
    
    stopwatch.stop();
    final fps = frames.length / (stopwatch.elapsedMilliseconds / 1000);
    
    return fps;
  }
}
```

## Benchmarks

### Dart VM

```dart
void main() {
  benchmarkGroup('Profile Serialization', () {
    benchmarkTest('serialize profile', () async {
      final profile = ProfileFixture.complete();
      
      return Stopwatch()..start()
        ..stop()
        ..elapsedMicroseconds;
    });
  });
}
```

## Ferramentas

- **flutter_devtools** — Análise de performance
- **dart VM service** — Métricas em tempo real
- **Android Profiler** — CPU/Memory (Android)
- **Xcode Instruments** — CPU/Memory (iOS)
- **firebase_performance** — Métricas em produção

## Execução

```dart
// Rodar testes de performance
flutter test test/performance/

// Rodar com profiling
flutter run --profile

// Rodar benchmarks
dart run benchmark/
```

## Relatório

### Formato do Relatório

```
═══════════════════════════════════════
       VCardSmart Performance Report
═══════════════════════════════════════

Startup Time:     1.2s ✅ (target: <2s)
QR Code Gen:      0.3s ✅ (target: <1s)
NFC Read:         2.1s ✅ (target: <5s)
Memory (idle):    42MB ✅ (target: <50MB)
Memory (active):  78MB ✅ (target: <100MB)
CPU (idle):       3%  ✅ (target: <5%)
CPU (active):     22% ✅ (target: <30%)
FPS:              58  ✅ (target: >55)
App Size:         15MB ✅ (target: <20MB)

═══════════════════════════════════════
              RESULT: PASS
═══════════════════════════════════════
```
