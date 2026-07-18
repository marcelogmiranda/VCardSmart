import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/theme_toggle.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/security_settings.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/privacy_settings.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('ThemeToggle Golden', () {
    testWidgets('light mode selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ThemeToggle(
              themeMode: ThemeMode.light,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ThemeToggle),
        matchesGoldenFile('golden_files/components/theme_toggle_light.png'),
      );
    });

    testWidgets('dark mode selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ThemeToggle(
              themeMode: ThemeMode.dark,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ThemeToggle),
        matchesGoldenFile('golden_files/components/theme_toggle_dark.png'),
      );
    });

    testWidgets('system mode selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ThemeToggle(
              themeMode: ThemeMode.system,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ThemeToggle),
        matchesGoldenFile('golden_files/components/theme_toggle_system.png'),
      );
    });
  });

  group('SecuritySettings Golden', () {
    testWidgets('both enabled light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SecuritySettings(
              biometricEnabled: true,
              pinEnabled: true,
              onBiometricChanged: (_) {},
              onPinChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(SecuritySettings),
        matchesGoldenFile('golden_files/components/security_settings_enabled_light.png'),
      );
    });

    testWidgets('both disabled light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SecuritySettings(
              biometricEnabled: false,
              pinEnabled: false,
              onBiometricChanged: (_) {},
              onPinChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(SecuritySettings),
        matchesGoldenFile('golden_files/components/security_settings_disabled_light.png'),
      );
    });
  });

  group('PrivacySettings Golden', () {
    testWidgets('ads enabled light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: PrivacySettings(
              adsEnabled: true,
              onAdsChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PrivacySettings),
        matchesGoldenFile('golden_files/components/privacy_settings_enabled_light.png'),
      );
    });

    testWidgets('ads disabled light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: PrivacySettings(
              adsEnabled: false,
              onAdsChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PrivacySettings),
        matchesGoldenFile('golden_files/components/privacy_settings_disabled_light.png'),
      );
    });
  });
}
