import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_avatar.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppAvatar Golden', () {
    testWidgets('initials default light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppAvatar(
                initials: 'JS',
                size: 80,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppAvatar),
        matchesGoldenFile('golden_files/components/avatar_initials_light.png'),
      );
    });

    testWidgets('initials dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(
              child: AppAvatar(
                initials: 'JS',
                size: 80,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppAvatar),
        matchesGoldenFile('golden_files/components/avatar_initials_dark.png'),
      );
    });

    testWidgets('small size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppAvatar(
                initials: 'AB',
                size: 40,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppAvatar),
        matchesGoldenFile('golden_files/components/avatar_small_light.png'),
      );
    });

    testWidgets('large size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppAvatar(
                initials: 'CD',
                size: 120,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppAvatar),
        matchesGoldenFile('golden_files/components/avatar_large_light.png'),
      );
    });

    testWidgets('no initials', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppAvatar(
                size: 80,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppAvatar),
        matchesGoldenFile('golden_files/components/avatar_no_initials_light.png'),
      );
    });
  });
}
