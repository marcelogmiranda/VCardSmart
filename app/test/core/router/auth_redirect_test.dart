import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/constants/app_constants.dart';
import 'package:vcardsmart/core/router/app_router.dart';
import 'package:vcardsmart/features/security/presentation/providers/auth_provider.dart';

void main() {
  group('authRedirect', () {
    const checking = AuthStatus(state: AuthState.checking);
    const authenticated = AuthStatus(state: AuthState.authenticated);
    const unauthenticated = AuthStatus(state: AuthState.unauthenticated);
    const error = AuthStatus(state: AuthState.error);

    test('redirects to auth page while checking', () {
      expect(authRedirect(checking, '/'), AppConstants.authRoute);
      expect(authRedirect(checking, '/contacts'), AppConstants.authRoute);
    });

    test('keeps auth page while checking', () {
      expect(authRedirect(checking, AppConstants.authRoute), isNull);
    });

    test('redirects from auth page when authenticated', () {
      expect(
        authRedirect(authenticated, AppConstants.authRoute),
        AppConstants.homeRoute,
      );
    });

    test('keeps app routes when authenticated', () {
      expect(authRedirect(authenticated, '/'), isNull);
      expect(authRedirect(authenticated, '/contacts'), isNull);
    });

    test('redirects to auth page when unauthenticated', () {
      expect(authRedirect(unauthenticated, '/'), AppConstants.authRoute);
      expect(authRedirect(unauthenticated, '/settings'), AppConstants.authRoute);
    });

    test('keeps auth page when unauthenticated', () {
      expect(authRedirect(unauthenticated, AppConstants.authRoute), isNull);
    });

    test('redirects to auth page on error', () {
      expect(authRedirect(error, '/'), AppConstants.authRoute);
    });
  });
}
