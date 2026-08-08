import 'package:flutter/foundation.dart';
import '../../features/settings/domain/entities/settings.dart';
import 'biometric_service.dart';
import 'pin_service.dart';

class AuthService {
  static bool _isAuthenticated = false;

  @visibleForTesting
  static Future<bool> Function()? debugIsAuthenticatedOverride;

  @visibleForTesting
  static void Function()? debugMarkAuthenticatedOverride;

  @visibleForTesting
  static void Function()? debugLogoutOverride;

  static Future<bool> authenticate() async {
    if (await BiometricService.isAvailable()) {
      final ok = await BiometricService.authenticate();
      if (ok) {
        _isAuthenticated = true;
      }
      return ok;
    }

    if (await PinService.hasPin()) {
      return false;
    }

    _isAuthenticated = true;
    return true;
  }

  static Future<bool> isAuthenticated() async {
    if (debugIsAuthenticatedOverride != null) {
      return await debugIsAuthenticatedOverride!();
    }
    return _isAuthenticated;
  }

  /// A trava deve ser exigida apenas pelo que o usuário realmente
  /// configurou (toggles de Settings), não pela capacidade do aparelho.
  static Future<bool> isAuthRequired(Settings settings) async {
    final hasPin = settings.pinEnabled && await PinService.hasPin();
    final hasBiometric =
        settings.biometricEnabled && await BiometricService.isAvailable();
    return hasPin || hasBiometric;
  }

  static void markAuthenticated() {
    if (debugMarkAuthenticatedOverride != null) {
      debugMarkAuthenticatedOverride!();
      return;
    }
    _isAuthenticated = true;
  }

  static void logout() {
    if (debugLogoutOverride != null) {
      debugLogoutOverride!();
      return;
    }
    _isAuthenticated = false;
  }
}
