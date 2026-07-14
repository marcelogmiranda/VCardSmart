import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/shared/widgets/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('should display label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Test',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('should show loading when isLoading is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Test',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Test',
              onPressed: () {},
              icon: Icons.add,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should render secondary button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Secondary',
              type: ButtonType.secondary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Secondary'), findsOneWidget);
    });

    testWidgets('should render outline button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Outline',
              type: ButtonType.outline,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outline'), findsOneWidget);
    });

    testWidgets('should render text button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Text',
              type: ButtonType.text,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Text'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Tap',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });
  });
}
