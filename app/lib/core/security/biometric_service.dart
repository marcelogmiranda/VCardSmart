import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  @visibleForTesting
  static Future<bool> Function()? debugIsAvailableOverride;

  @visibleForTesting
  static Future<bool> Function()? debugAuthenticateOverride;

  static Future<bool> isAvailable() async {
    if (debugIsAvailableOverride != null) {
      return await debugIsAvailableOverride!();
    }
    try {
      return await _auth.isDeviceSupported() && await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    if (debugAuthenticateOverride != null) {
      return await debugAuthenticateOverride!();
    }
    try {
      return await _auth.authenticate(
        localizedReason: 'Autentique-se para acessar',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }
}
