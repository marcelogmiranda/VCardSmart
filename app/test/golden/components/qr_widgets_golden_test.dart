import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/presentation/widgets/qr_code_widget.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('QRCodeWidget Golden', () {
    testWidgets('default size light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: QRCodeWidget(
                data: 'BEGIN:VCARD\nVERSION:3.0\nFN:João Silva\nEND:VCARD',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(QRCodeWidget),
        matchesGoldenFile('golden_files/components/qr_code_light.png'),
      );
    });

    testWidgets('default size dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(
              child: QRCodeWidget(
                data: 'BEGIN:VCARD\nVERSION:3.0\nFN:João Silva\nEND:VCARD',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(QRCodeWidget),
        matchesGoldenFile('golden_files/components/qr_code_dark.png'),
      );
    });

    testWidgets('custom size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: QRCodeWidget(
                data: 'BEGIN:VCARD\nVERSION:3.0\nFN:João Silva\nEND:VCARD',
                size: 300,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(QRCodeWidget),
        matchesGoldenFile('golden_files/components/qr_code_large_light.png'),
      );
    });
  });
}
