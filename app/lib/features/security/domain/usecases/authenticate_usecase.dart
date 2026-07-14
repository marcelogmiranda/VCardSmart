import '../../../../core/security/auth_service.dart';

class AuthenticateUseCase {
  Future<bool> call() async {
    return await AuthService.authenticate();
  }

  Future<bool> isRequired() async {
    return await AuthService.isAuthRequired();
  }

  Future<bool> isCurrentlyAuthenticated() async {
    return await AuthService.isAuthenticated();
  }
}
