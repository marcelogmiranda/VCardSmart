import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/nfc/data/models/nfc_payload.dart';

class NFCUtils {
  NFCUtils._();

  static String encodeProfilePayload(Profile profile) {
    return NFCPayload.encodeProfile(profile);
  }

  static Profile decodeProfilePayload(String payload) {
    return NFCPayload.decodeProfile(payload);
  }

  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  static String decodeBase64(String encoded) {
    return utf8.decode(base64Decode(encoded));
  }

  static Future<bool> isNFCAvailable() async {
    try {
      await const MethodChannel('plugins.flutter.io/nfc_manager')
          .invokeMethod('isAvailable');
      return true;
    } catch (e) {
      return false;
    }
  }
}
