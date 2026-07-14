import 'package:flutter/material.dart';

class Settings {
  final ThemeMode themeMode;
  final Locale locale;
  final bool biometricEnabled;
  final bool pinEnabled;
  final bool adsEnabled;

  const Settings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('pt', 'BR'),
    this.biometricEnabled = false,
    this.pinEnabled = false,
    this.adsEnabled = true,
  });

  Settings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? biometricEnabled,
    bool? pinEnabled,
    bool? adsEnabled,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      adsEnabled: adsEnabled ?? this.adsEnabled,
    );
  }
}
