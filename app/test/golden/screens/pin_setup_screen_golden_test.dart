import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/security/presentation/pages/pin_setup_page.dart';
import 'package:vcardsmart/features/security/presentation/providers/auth_provider.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';
import 'package:vcardsmart/features/settings/domain/repositories/settings_repository.dart';
import 'package:vcardsmart/features/settings/presentation/providers/settings_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

class _FakeSettingsRepository implements SettingsRepository {
  Settings _settings = const Settings();

  @override
  Future<Settings> getSettings() async => _settings;

  @override
  Future<void> updateSettings(Settings settings) async {
    _settings = settings;
  }

  @override
  Future<void> resetSettings() async {
    _settings = const Settings();
  }
}

void main() {
  group('PinSetupPage Golden', () {
    testWidgets('light theme - initial state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                ref.read(authenticateUseCaseProvider),
                ref.read(setPinUseCaseProvider),
                ref.read(verifyPinUseCaseProvider),
              ),
            ),
            settingsRepositoryProvider.overrideWithValue(
              _FakeSettingsRepository(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const PinSetupPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PinSetupPage),
        matchesGoldenFile('golden_files/screens/pin_setup_light.png'),
      );
    });

    testWidgets('dark theme - initial state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                ref.read(authenticateUseCaseProvider),
                ref.read(setPinUseCaseProvider),
                ref.read(verifyPinUseCaseProvider),
              ),
            ),
            settingsRepositoryProvider.overrideWithValue(
              _FakeSettingsRepository(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const PinSetupPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PinSetupPage),
        matchesGoldenFile('golden_files/screens/pin_setup_dark.png'),
      );
    });
  });
}
