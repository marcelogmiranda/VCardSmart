import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/errors/app_exception.dart';

void main() {
  group('AppException', () {
    test('ProfileNotFoundException should have correct message and code', () {
      final exception = ProfileNotFoundException('1');
      expect(exception.message, 'Profile not found: 1');
      expect(exception.code, 'PROFILE_NOT_FOUND');
    });

    test('DatabaseException should have correct message and code', () {
      final exception = DatabaseException('DB error');
      expect(exception.message, 'DB error');
      expect(exception.code, 'DATABASE_ERROR');
    });

    test('CacheException should have correct message and code', () {
      final exception = CacheException('Cache error');
      expect(exception.message, 'Cache error');
      expect(exception.code, 'CACHE_ERROR');
    });

    test('ValidationException should have correct message and code', () {
      final exception = ValidationException('Invalid input');
      expect(exception.message, 'Invalid input');
      expect(exception.code, 'VALIDATION_ERROR');
    });

    test('PermissionException should have correct message and code', () {
      final exception = PermissionException('No permission');
      expect(exception.message, 'No permission');
      expect(exception.code, 'PERMISSION_ERROR');
    });

    test('QRException should have correct message and code', () {
      final exception = QRException('QR error');
      expect(exception.message, 'QR error');
      expect(exception.code, 'QR_ERROR');
    });

    test('AppException toString should include code and message', () {
      final exception = DatabaseException('test msg');
      expect(exception.toString(), contains('DATABASE_ERROR'));
      expect(exception.toString(), contains('test msg'));
    });
  });
}
