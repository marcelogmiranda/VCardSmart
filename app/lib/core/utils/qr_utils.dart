import 'dart:convert';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/qr_code/data/models/qr_payload.dart';

class QRUtils {
  QRUtils._();

  static String generateVCardString(Profile profile) {
    return QRPayload.encodeVCard(profile);
  }

  static Profile parseVCardString(String vCardString) {
    return QRPayload.decodeVCard(vCardString);
  }

  static String encodeToBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  static String decodeFromBase64(String encoded) {
    return utf8.decode(base64Decode(encoded));
  }
}
