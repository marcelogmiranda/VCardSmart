import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_divider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppDivider Golden', () {
    testWidgets('default light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                Text('Item 1'),
                AppDivider(),
                Text('Item 2'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppDivider),
        matchesGoldenFile('golden_files/components/divider_light.png'),
      );
    });

    testWidgets('default dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Column(
              children: [
                Text('Item 1'),
                AppDivider(),
                Text('Item 2'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppDivider),
        matchesGoldenFile('golden_files/components/divider_dark.png'),
      );
    });
  });
}
