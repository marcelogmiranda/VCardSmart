import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/vcard/presentation/widgets/vcard_preview.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';

void main() {
  group('VCardPreview', () {
    testWidgets('should display full name', (tester) async {
      const data = VCardData(firstName: 'João', lastName: 'Silva');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('João Silva'), findsOneWidget);
    });

    testWidgets('should display email', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        email: 'test@email.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('test@email.com'), findsOneWidget);
    });

    testWidgets('should display phone', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        phone: '+5511999999999',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('+5511999999999'), findsOneWidget);
    });

    testWidgets('should display organization and title', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        organization: 'Tech Corp',
        title: 'Developer',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('Tech Corp'), findsOneWidget);
      expect(find.text('Developer'), findsOneWidget);
    });

    testWidgets('should display website', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        website: 'https://test.com',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('https://test.com'), findsOneWidget);
    });

    testWidgets('should display address', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        address: 'São Paulo, BR',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('São Paulo, BR'), findsOneWidget);
    });

    testWidgets('should display note', (tester) async {
      const data = VCardData(
        firstName: 'Test',
        note: 'Important contact',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VCardPreview(data: data),
          ),
        ),
      );

      expect(find.text('Important contact'), findsOneWidget);
    });
  });
}
