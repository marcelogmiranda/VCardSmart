import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'secure_storage_service.dart';

class PinService {
  static const _pinKey = 'app_pin';

  static Future<void> setPin(String pin) async {
    final hashed = _hashPin(pin);
    await SecureStorageService.write(_pinKey, hashed);
  }

  static Future<bool> verifyPin(String pin) async {
    final stored = await SecureStorageService.read(_pinKey);
    if (stored == null) return false;

    final hashed = _hashPin(pin);
    return hashed == stored;
  }

  static Future<bool> hasPin() async {
    return await SecureStorageService.containsKey(_pinKey);
  }

  static Future<void> removePin() async {
    await SecureStorageService.delete(_pinKey);
  }

  static String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
