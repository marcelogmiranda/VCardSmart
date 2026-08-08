import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../../../core/database/hive_service.dart';

class LocalSettingsRepository implements SettingsRepository {
  static const String _themeModeKey = 'themeMode';
  static const String _localeKey = 'locale';
  static const String _localeCountryKey = 'localeCountry';
  static const String _biometricKey = 'biometricEnabled';
  static const String _pinKey = 'pinEnabled';
  static const String _adsKey = 'adsEnabled';
  static const String _securityAskedKey = 'securitySetupAsked';
  static const String _pinLengthKey = 'pinLength';

  Box get _box => HiveService.settingsBox;

  @override
  Future<Settings> getSettings() async {
    final themeIndex = _box.get(_themeModeKey, defaultValue: 0) as int;
    final localeCode = _box.get(_localeKey, defaultValue: 'pt') as String;
    final countryCode = _box.get(_localeCountryKey, defaultValue: 'BR') as String;
    final biometric = _box.get(_biometricKey, defaultValue: false) as bool;
    final pin = _box.get(_pinKey, defaultValue: false) as bool;
    final ads = _box.get(_adsKey, defaultValue: true) as bool;
    final securityAsked = _box.get(_securityAskedKey, defaultValue: false) as bool;
    final pinLength = _box.get(_pinLengthKey, defaultValue: 6) as int;

    return Settings(
      themeMode: ThemeMode.values[themeIndex],
      locale: Locale(localeCode, countryCode.isEmpty ? null : countryCode),
      biometricEnabled: biometric,
      pinEnabled: pin,
      adsEnabled: ads,
      securitySetupAsked: securityAsked,
      pinLength: pinLength,
    );
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    await _box.put(_themeModeKey, settings.themeMode.index);
    await _box.put(_localeKey, settings.locale.languageCode);
    await _box.put(_localeCountryKey, settings.locale.countryCode ?? '');
    await _box.put(_biometricKey, settings.biometricEnabled);
    await _box.put(_pinKey, settings.pinEnabled);
    await _box.put(_adsKey, settings.adsEnabled);
    await _box.put(_securityAskedKey, settings.securitySetupAsked);
    await _box.put(_pinLengthKey, settings.pinLength);
  }

  @override
  Future<void> resetSettings() async {
    await _box.clear();
  }
}
