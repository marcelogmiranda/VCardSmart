import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_card.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppCard Golden', () {
    testWidgets('default light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                child: const Text('Card content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppCard),
        matchesGoldenFile('golden_files/components/card_light.png'),
      );
    });

    testWidgets('default dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                child: const Text('Card content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppCard),
        matchesGoldenFile('golden_files/components/card_dark.png'),
      );
    });

    testWidgets('with custom padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                padding: const EdgeInsets.all(32),
                child: const Text('Custom padding'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppCard),
        matchesGoldenFile('golden_files/components/card_custom_padding_light.png'),
      );
    });
  });
}
