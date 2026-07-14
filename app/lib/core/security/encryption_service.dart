import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static const _ivLength = 16;

  static String encrypt(String data, String passphrase) {
    final keyBytes = _deriveKey(passphrase);
    final iv = _generateIV();

    final encrypter = Encrypter(AES(Key(keyBytes)));
    final encrypted = encrypter.encrypt(data, iv: iv);

    return '${iv.base64}:${encrypted.base64}';
  }

  static String decrypt(String encryptedData, String passphrase) {
    final parts = encryptedData.split(':');
    if (parts.length != 2) {
      throw const FormatException('Invalid encrypted data format');
    }

    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    final keyBytes = _deriveKey(passphrase);

    final encrypter = Encrypter(AES(Key(keyBytes)));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static Uint8List _deriveKey(String passphrase) {
    final bytes = utf8.encode(passphrase);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  static IV _generateIV() {
    final random = Random.secure();
    final ivBytes = List<int>.generate(_ivLength, (_) => random.nextInt(256));
    return IV(Uint8List.fromList(ivBytes));
  }
}
