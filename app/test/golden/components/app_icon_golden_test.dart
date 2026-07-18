import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_icon.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppIcon Golden', () {
    testWidgets('default icon light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppIcon(
                icon: Icons.star,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppIcon),
        matchesGoldenFile('golden_files/components/icon_light.png'),
      );
    });

    testWidgets('large icon light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppIcon(
                icon: Icons.star,
                size: 48,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppIcon),
        matchesGoldenFile('golden_files/components/icon_large_light.png'),
      );
    });

    testWidgets('icon dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(
              child: AppIcon(
                icon: Icons.star,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppIcon),
        matchesGoldenFile('golden_files/components/icon_dark.png'),
      );
    });
  });

  group('AppStatusIcon Golden', () {
    testWidgets('success status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppStatusIcon(
                icon: Icons.check,
                type: StatusType.success,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppStatusIcon),
        matchesGoldenFile('golden_files/components/status_icon_success_light.png'),
      );
    });

    testWidgets('error status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppStatusIcon(
                icon: Icons.error,
                type: StatusType.error,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppStatusIcon),
        matchesGoldenFile('golden_files/components/status_icon_error_light.png'),
      );
    });

    testWidgets('warning status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppStatusIcon(
                icon: Icons.warning,
                type: StatusType.warning,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppStatusIcon),
        matchesGoldenFile('golden_files/components/status_icon_warning_light.png'),
      );
    });

    testWidgets('info status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppStatusIcon(
                icon: Icons.info,
                type: StatusType.info,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppStatusIcon),
        matchesGoldenFile('golden_files/components/status_icon_info_light.png'),
      );
    });
  });
}
