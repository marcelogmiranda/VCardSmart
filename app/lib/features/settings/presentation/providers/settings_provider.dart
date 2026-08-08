import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../data/repositories/local_settings_repository.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return LocalSettingsRepository();
});

final getSettingsUseCaseProvider = Provider((ref) {
  return GetSettingsUseCase(ref.read(settingsRepositoryProvider));
});

final updateSettingsUseCaseProvider = Provider((ref) {
  return UpdateSettingsUseCase(ref.read(settingsRepositoryProvider));
});

class SettingsNotifier extends StateNotifier<Settings> {
  final GetSettingsUseCase _getSettings;
  final UpdateSettingsUseCase _updateSettings;

  SettingsNotifier(this._getSettings, this._updateSettings)
      : super(const Settings()) {
    _load();
  }

  Future<void> _load() async {
    state = await _getSettings();
  }

  Future<void> updateTheme(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _updateSettings(state);
  }

  Future<void> updateLocale(Locale locale) async {
    state = state.copyWith(locale: locale);
    await _updateSettings(state);
  }

  Future<void> updateBiometric(bool enabled) async {
    state = state.copyWith(biometricEnabled: enabled);
    await _updateSettings(state);
  }

  Future<void> updatePin(bool enabled) async {
    state = state.copyWith(pinEnabled: enabled);
    await _updateSettings(state);
  }

  Future<void> updatePinLength(int length) async {
    state = state.copyWith(pinLength: length);
    await _updateSettings(state);
  }

  Future<void> markSecurityAsked() async {
    state = state.copyWith(securitySetupAsked: true);
    await _updateSettings(state);
  }

  Future<void> updateAds(bool enabled) async {
    state = state.copyWith(adsEnabled: enabled);
    await _updateSettings(state);
  }

  Future<void> reset() async {
    await _updateSettings.reset();
    state = const Settings();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier(
    ref.read(getSettingsUseCaseProvider),
    ref.read(updateSettingsUseCaseProvider),
  );
});
