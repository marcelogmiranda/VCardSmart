import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_share_page.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_scan_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_qr_hive__');
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('QRSharePage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRSharePage()),
        ),
      );
      expect(find.text('Meu QR Code'), findsOneWidget);
    });
  });

  group('QRScanPage', () {
    testWidgets('should display initial screen with button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      expect(find.text('Escanear QR Code'), findsOneWidget);
      expect(find.text('Abrir Camera'), findsOneWidget);
    });

    testWidgets('should have scaffold structure', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
