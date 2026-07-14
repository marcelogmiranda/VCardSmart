import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/shared/widgets/app_card.dart';

void main() {
  group('AppCard', () {
    testWidgets('should display child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('should respond to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              onTap: () => tapped = true,
              child: const Text('Card'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppCard));
      expect(tapped, true);
    });
  });
}
