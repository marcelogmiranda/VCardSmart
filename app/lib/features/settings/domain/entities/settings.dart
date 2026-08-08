import 'package:flutter/material.dart';

class Settings {
  final ThemeMode themeMode;
  final Locale locale;
  final bool biometricEnabled;
  final bool pinEnabled;
  final bool adsEnabled;
  final bool securitySetupAsked;
  final int pinLength;

  const Settings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('pt', 'BR'),
    this.biometricEnabled = false,
    this.pinEnabled = false,
    this.adsEnabled = true,
    this.securitySetupAsked = false,
    this.pinLength = 6,
  });

  Settings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? biometricEnabled,
    bool? pinEnabled,
    bool? adsEnabled,
    bool? securitySetupAsked,
    int? pinLength,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      adsEnabled: adsEnabled ?? this.adsEnabled,
      securitySetupAsked: securitySetupAsked ?? this.securitySetupAsked,
      pinLength: pinLength ?? this.pinLength,
    );
  }
}
