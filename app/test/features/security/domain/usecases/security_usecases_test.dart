import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/security/auth_service.dart';
import 'package:vcardsmart/features/security/domain/usecases/set_pin_usecase.dart';
import 'package:vcardsmart/features/security/domain/usecases/authenticate_usecase.dart';

void main() {
  group('SetPinUseCase', () {
    test('should reject PIN shorter than 4 digits', () async {
      final useCase = SetPinUseCase();
      expect(() => useCase('123'), throwsA(isA<Exception>()));
    });

    test('should reject empty PIN', () async {
      final useCase = SetPinUseCase();
      expect(() => useCase(''), throwsA(isA<Exception>()));
    });

    test('should reject 3-digit PIN', () async {
      final useCase = SetPinUseCase();
      expect(() => useCase('123'), throwsA(isA<Exception>()));
    });
  });

  group('AuthenticateUseCase', () {
    setUp(() {
      AuthService.logout();
    });

    test('isCurrentlyAuthenticated should return false by default', () async {
      final useCase = AuthenticateUseCase();
      final result = await useCase.isCurrentlyAuthenticated();
      expect(result, false);
    });
  });
}
