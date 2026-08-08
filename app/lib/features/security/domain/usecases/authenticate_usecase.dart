import '../../../../core/security/auth_service.dart';
import '../../../settings/domain/entities/settings.dart';

class AuthenticateUseCase {
  Future<bool> call() async {
    return await AuthService.authenticate();
  }

  Future<bool> isRequired(Settings settings) async {
    return await AuthService.isAuthRequired(settings);
  }

  Future<bool> isCurrentlyAuthenticated() async {
    return await AuthService.isAuthenticated();
  }
}
