import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_status_widget.dart';

void main() {
  group('NFCStatusWidget', () {
    testWidgets('should show available status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCStatusWidget(isAvailable: true),
          ),
        ),
      );

      expect(find.text('NFC disponível'), findsOneWidget);
      expect(find.byIcon(Icons.nfc), findsOneWidget);
    });

    testWidgets('should show unavailable status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCStatusWidget(isAvailable: false),
          ),
        ),
      );

      expect(find.text('NFC indisponível'), findsOneWidget);
      expect(find.byIcon(Icons.nfc_outlined), findsOneWidget);
    });
  });
}
