import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/settings/data/repositories/local_settings_repository.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

void main() {
  late LocalSettingsRepository repository;

  setUp(() {
    repository = LocalSettingsRepository();
  });

  group('getSettings', () {
    test('should return default settings', () async {
      final settings = await repository.getSettings();

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, const Locale('pt', 'BR'));
      expect(settings.biometricEnabled, false);
      expect(settings.pinEnabled, false);
      expect(settings.adsEnabled, true);
    });
  });

  group('updateSettings', () {
    test('should update settings', () async {
      await repository.updateSettings(
        const Settings(
          themeMode: ThemeMode.dark,
          locale: Locale('en'),
          biometricEnabled: true,
          adsEnabled: false,
        ),
      );

      final settings = await repository.getSettings();
      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.locale, const Locale('en'));
      expect(settings.biometricEnabled, true);
      expect(settings.adsEnabled, false);
    });

    test('should persist updates', () async {
      await repository.updateSettings(const Settings(pinEnabled: true));

      var settings = await repository.getSettings();
      expect(settings.pinEnabled, true);

      await repository.updateSettings(const Settings(adsEnabled: false));

      settings = await repository.getSettings();
      expect(settings.adsEnabled, false);
    });
  });

  group('resetSettings', () {
    test('should reset to defaults', () async {
      await repository.updateSettings(
        const Settings(
          themeMode: ThemeMode.dark,
          biometricEnabled: true,
          adsEnabled: false,
        ),
      );

      await repository.resetSettings();

      final settings = await repository.getSettings();
      expect(settings.themeMode, ThemeMode.system);
      expect(settings.biometricEnabled, false);
      expect(settings.adsEnabled, true);
    });
  });
}
