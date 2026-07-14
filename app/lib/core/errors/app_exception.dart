abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException($code): $message';
}

class ProfileNotFoundException extends AppException {
  ProfileNotFoundException(String id)
      : super('Profile not found: $id', 'PROFILE_NOT_FOUND');
}

class DatabaseException extends AppException {
  DatabaseException(String message)
      : super(message, 'DATABASE_ERROR');
}

class CacheException extends AppException {
  CacheException(String message)
      : super(message, 'CACHE_ERROR');
}

class ValidationException extends AppException {
  ValidationException(String message)
      : super(message, 'VALIDATION_ERROR');
}

class PermissionException extends AppException {
  PermissionException(String message)
      : super(message, 'PERMISSION_ERROR');
}

class QRException extends AppException {
  QRException(String message)
      : super(message, 'QR_ERROR');
}
