import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';
import 'package:vcardsmart/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:vcardsmart/features/settings/domain/usecases/update_settings_usecase.dart';
import 'package:vcardsmart/features/settings/domain/repositories/settings_repository.dart';

void main() {
  late _FakeSettingsRepository repository;

  setUp(() {
    repository = _FakeSettingsRepository();
  });

  group('GetSettingsUseCase', () {
    test('should return default settings', () async {
      final useCase = GetSettingsUseCase(repository);

      final settings = await useCase();

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, const Locale('pt', 'BR'));
    });

    test('should return updated settings', () async {
      await repository.updateSettings(
        const Settings(
          themeMode: ThemeMode.dark,
          locale: Locale('en'),
        ),
      );
      final useCase = GetSettingsUseCase(repository);

      final settings = await useCase();

      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.locale, const Locale('en'));
    });
  });

  group('UpdateSettingsUseCase', () {
    test('should update settings', () async {
      final useCase = UpdateSettingsUseCase(repository);

      await useCase(const Settings(themeMode: ThemeMode.dark));

      final settings = await repository.getSettings();
      expect(settings.themeMode, ThemeMode.dark);
    });

    test('should reset settings', () async {
      await repository.updateSettings(
        const Settings(
          themeMode: ThemeMode.dark,
          adsEnabled: false,
        ),
      );
      final useCase = UpdateSettingsUseCase(repository);

      await useCase.reset();

      final settings = await repository.getSettings();
      expect(settings.themeMode, ThemeMode.system);
      expect(settings.adsEnabled, true);
    });
  });
}

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
