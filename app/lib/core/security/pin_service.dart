import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'secure_storage_service.dart';

class PinService {
  static const _pinKey = 'app_pin';

  @visibleForTesting
  static Future<void> Function(String pin)? debugSetPinOverride;

  @visibleForTesting
  static Future<bool> Function(String pin)? debugVerifyPinOverride;

  @visibleForTesting
  static Future<bool> Function()? debugHasPinOverride;

  @visibleForTesting
  static Future<void> Function()? debugRemovePinOverride;

  static Future<void> setPin(String pin) async {
    if (debugSetPinOverride != null) {
      return debugSetPinOverride!(pin);
    }
    final hashed = _hashPin(pin);
    await SecureStorageService.write(_pinKey, hashed);
  }

  static Future<bool> verifyPin(String pin) async {
    if (debugVerifyPinOverride != null) {
      return debugVerifyPinOverride!(pin);
    }
    final stored = await SecureStorageService.read(_pinKey);
    if (stored == null) return false;

    final hashed = _hashPin(pin);
    return hashed == stored;
  }

  static Future<bool> hasPin() async {
    if (debugHasPinOverride != null) {
      return debugHasPinOverride!();
    }
    return await SecureStorageService.containsKey(_pinKey);
  }

  static Future<void> removePin() async {
    if (debugRemovePinOverride != null) {
      return debugRemovePinOverride!();
    }
    await SecureStorageService.delete(_pinKey);
  }

  static String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
