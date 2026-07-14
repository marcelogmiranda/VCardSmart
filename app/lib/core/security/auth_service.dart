import 'biometric_service.dart';
import 'pin_service.dart';

class AuthService {
  static Future<bool> authenticate() async {
    if (await BiometricService.isAvailable()) {
      return await BiometricService.authenticate();
    }

    if (await PinService.hasPin()) {
      return false;
    }

    return true;
  }

  static Future<bool> isAuthenticated() async {
    return true;
  }

  static Future<bool> isAuthRequired() async {
    final hasBiometric = await BiometricService.isAvailable();
    final hasPin = await PinService.hasPin();
    return hasBiometric || hasPin;
  }
}
