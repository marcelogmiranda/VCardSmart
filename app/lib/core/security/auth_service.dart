import 'biometric_service.dart';
import 'pin_service.dart';

class AuthService {
  static bool _isAuthenticated = false;

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
    return _isAuthenticated;
  }

  static Future<bool> isAuthRequired() async {
    final hasBiometric = await BiometricService.isAvailable();
    final hasPin = await PinService.hasPin();
    return hasBiometric || hasPin;
  }

  static void markAuthenticated() {
    _isAuthenticated = true;
  }

  static void logout() {
    _isAuthenticated = false;
  }
}
