import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/qr_code/presentation/widgets/qr_code_widget.dart';

void main() {
  group('QRCodeWidget', () {
    testWidgets('should render QR code with data', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QRCodeWidget(
              data: 'https://example.com',
              size: 200,
            ),
          ),
        ),
      );

      expect(find.byType(QRCodeWidget), findsOneWidget);
    });

    testWidgets('should render with custom size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QRCodeWidget(
              data: 'test data',
              size: 150,
            ),
          ),
        ),
      );

      expect(find.byType(QRCodeWidget), findsOneWidget);
    });

    testWidgets('should render with custom colors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QRCodeWidget(
              data: 'colored',
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.byType(QRCodeWidget), findsOneWidget);
    });
  });
}
