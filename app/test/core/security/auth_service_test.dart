import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/security/auth_service.dart';

void main() {
  group('AuthService session', () {
    setUp(() {
      AuthService.logout();
    });

    tearDown(() {
      AuthService.logout();
    });

    test('should not be authenticated by default', () async {
      expect(await AuthService.isAuthenticated(), false);
    });

    test('should be authenticated after markAuthenticated', () async {
      AuthService.markAuthenticated();
      expect(await AuthService.isAuthenticated(), true);
    });

    test('should clear session after logout', () async {
      AuthService.markAuthenticated();
      AuthService.logout();
      expect(await AuthService.isAuthenticated(), false);
    });
  });
}
