import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/security/encryption_service.dart';

void main() {
  group('EncryptionService', () {
    test('should encrypt and decrypt data', () {
      const original = 'Hello, World!';
      const passphrase = 'my-secret-key';

      final encrypted = EncryptionService.encrypt(original, passphrase);
      final decrypted = EncryptionService.decrypt(encrypted, passphrase);

      expect(encrypted, isNot(equals(original)));
      expect(decrypted, equals(original));
    });

    test('should produce different ciphertext for same data', () {
      const data = 'Same data';
      const passphrase = 'key';

      final encrypted1 = EncryptionService.encrypt(data, passphrase);
      final encrypted2 = EncryptionService.encrypt(data, passphrase);

      expect(encrypted1, isNot(equals(encrypted2)));
    });

    test('should fail with wrong passphrase', () {
      const data = 'Secret data';
      final encrypted = EncryptionService.encrypt(data, 'correct');
      expect(
        () => EncryptionService.decrypt(encrypted, 'wrong'),
        throwsA(anything),
      );
    });

    test('should handle long text', () {
      final data = 'A' * 1000;
      final encrypted = EncryptionService.encrypt(data, 'key');
      final decrypted = EncryptionService.decrypt(encrypted, 'key');
      expect(decrypted, data);
    });

    test('should handle special characters', () {
      const data = 'Áéîõü @!#\$%^&*()';
      final encrypted = EncryptionService.encrypt(data, 'key');
      final decrypted = EncryptionService.decrypt(encrypted, 'key');
      expect(decrypted, data);
    });

    test('should fail with invalid format', () {
      expect(
        () => EncryptionService.decrypt('invalid', 'key'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
