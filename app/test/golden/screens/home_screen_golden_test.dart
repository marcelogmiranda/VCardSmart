import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/home/presentation/pages/home_page.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('HomePage Golden', () {
    testWidgets('light theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const HomePage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('golden_files/screens/home_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const HomePage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('golden_files/screens/home_dark.png'),
      );
    });
  });
}
