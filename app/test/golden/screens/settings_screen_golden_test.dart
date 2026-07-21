import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/features/settings/presentation/pages/settings_page.dart';
import 'package:vcardsmart/features/settings/presentation/providers/settings_provider.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_settings_golden_hive__');
    await Hive.openBox(HiveBoxes.settings);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('SettingsPage Golden', () {
    testWidgets('light theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWith(
              (ref) => SettingsNotifier(
                ref.read(getSettingsUseCaseProvider),
                ref.read(updateSettingsUseCaseProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SettingsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(SettingsPage),
        matchesGoldenFile('golden_files/screens/settings_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWith(
              (ref) => SettingsNotifier(
                ref.read(getSettingsUseCaseProvider),
                ref.read(updateSettingsUseCaseProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SettingsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(SettingsPage),
        matchesGoldenFile('golden_files/screens/settings_dark.png'),
      );
    });
  });
}
