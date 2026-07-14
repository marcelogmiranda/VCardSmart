import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/settings/presentation/providers/settings_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    // Trigger notifier creation so _load() starts
    container.read(settingsProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  /// Wait for async _load() microtask to complete
  Future<void> waitForLoad() async {
    // Drain microtask queue and let timer events fire
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
  }

  group('SettingsNotifier', () {
    test('should start with default settings', () async {
      await waitForLoad();

      final settings = container.read(settingsProvider);

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, const Locale('pt', 'BR'));
      expect(settings.biometricEnabled, false);
      expect(settings.pinEnabled, false);
      expect(settings.adsEnabled, true);
    });

    test('should update theme', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updateTheme(ThemeMode.dark);

      expect(container.read(settingsProvider).themeMode, ThemeMode.dark);
    });

    test('should update locale', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updateLocale(const Locale('en'));

      expect(container.read(settingsProvider).locale, const Locale('en'));
    });

    test('should update biometric', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updateBiometric(true);

      expect(container.read(settingsProvider).biometricEnabled, true);
    });

    test('should update pin', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updatePin(true);

      expect(container.read(settingsProvider).pinEnabled, true);
    });

    test('should update ads', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updateAds(false);

      expect(container.read(settingsProvider).adsEnabled, false);
    });

    test('should reset to defaults', () async {
      await waitForLoad();

      final notifier = container.read(settingsProvider.notifier);
      await notifier.updateTheme(ThemeMode.dark);
      await notifier.updateAds(false);
      await notifier.reset();

      final settings = container.read(settingsProvider);
      expect(settings.themeMode, ThemeMode.system);
      expect(settings.adsEnabled, true);
    });
  });
}
