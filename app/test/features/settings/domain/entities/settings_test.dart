import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

void main() {
  group('Settings', () {
    test('should have default values', () {
      const settings = Settings();

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, const Locale('pt', 'BR'));
      expect(settings.biometricEnabled, false);
      expect(settings.pinEnabled, false);
      expect(settings.adsEnabled, true);
    });

    test('copyWith should create new instance', () {
      const original = Settings();
      final updated = original.copyWith(
        themeMode: ThemeMode.dark,
        locale: const Locale('en'),
      );

      expect(updated.themeMode, ThemeMode.dark);
      expect(updated.locale, const Locale('en'));
      expect(updated.biometricEnabled, false);
    });

    test('copyWith should keep existing values when not provided', () {
      const original = Settings(
        themeMode: ThemeMode.dark,
        biometricEnabled: true,
        adsEnabled: false,
      );
      final copy = original.copyWith();

      expect(copy.themeMode, ThemeMode.dark);
      expect(copy.biometricEnabled, true);
      expect(copy.adsEnabled, false);
      expect(copy.locale, const Locale('pt', 'BR'));
    });

    test('copyWith should update biometric', () {
      const original = Settings();
      final updated = original.copyWith(biometricEnabled: true);

      expect(updated.biometricEnabled, true);
      expect(updated.pinEnabled, false);
    });

    test('copyWith should update pin', () {
      const original = Settings();
      final updated = original.copyWith(pinEnabled: true);

      expect(updated.pinEnabled, true);
    });

    test('copyWith should update ads', () {
      const original = Settings();
      final updated = original.copyWith(adsEnabled: false);

      expect(updated.adsEnabled, false);
    });
  });
}
