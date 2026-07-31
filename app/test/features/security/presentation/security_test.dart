import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/security/presentation/providers/auth_provider.dart';
import 'package:vcardsmart/features/security/presentation/pages/auth_page.dart';
import 'package:vcardsmart/features/security/presentation/pages/pin_setup_page.dart';
import 'package:vcardsmart/features/security/presentation/widgets/biometric_button.dart';
import 'package:vcardsmart/features/security/presentation/widgets/pin_input.dart';
import 'package:vcardsmart/features/security/domain/usecases/authenticate_usecase.dart';
import 'package:vcardsmart/features/security/domain/usecases/set_pin_usecase.dart';
import 'package:vcardsmart/features/security/domain/usecases/verify_pin_usecase.dart';

void main() {
  group('AuthStatus', () {
    test('should have default values', () {
      const status = AuthStatus();
      expect(status.state, AuthState.checking);
      expect(status.biometricAvailable, false);
      expect(status.hasPin, false);
      expect(status.error, isNull);
    });

    test('copyWith should create new state', () {
      const status = AuthStatus();
      final updated = status.copyWith(
        state: AuthState.authenticated,
        biometricAvailable: true,
        hasPin: true,
      );

      expect(updated.state, AuthState.authenticated);
      expect(updated.biometricAvailable, true);
      expect(updated.hasPin, true);
    });

    test('copyWith should clear error', () {
      const status = AuthStatus(error: 'old error');
      final updated = status.copyWith();
      expect(updated.error, isNull);
    });

    test('copyWith should keep values when not specified', () {
      const status = AuthStatus(
        state: AuthState.authenticated,
        biometricAvailable: true,
        hasPin: true,
        error: 'some error',
      );
      final updated = status.copyWith();

      expect(updated.state, AuthState.authenticated);
      expect(updated.biometricAvailable, true);
      expect(updated.hasPin, true);
      expect(updated.error, isNull);
    });
  });

  group('AuthNotifier', () {
    late AuthNotifier notifier;
    late _FakeAuthenticateUseCase fakeAuth;
    late _FakeSetPinUseCase fakeSetPin;
    late _FakeVerifyPinUseCase fakeVerifyPin;

    setUp(() {
      fakeAuth = _FakeAuthenticateUseCase();
      fakeSetPin = _FakeSetPinUseCase();
      fakeVerifyPin = _FakeVerifyPinUseCase();
      notifier = AuthNotifier(fakeAuth, fakeSetPin, fakeVerifyPin);
    });

    test('should start with checking state', () {
      expect(notifier.state.state, AuthState.checking);
    });

    test('should authenticate successfully', () async {
      await notifier.authenticate();
      expect(notifier.state.state, AuthState.authenticated);
    });

    test('should handle authenticate failure', () async {
      fakeAuth.returnAuth = false;
      await notifier.authenticate();
      expect(notifier.state.state, AuthState.unauthenticated);
    });

    test('should handle authenticate exception', () async {
      fakeAuth.throwOnAuth = true;
      await notifier.authenticate();
      expect(notifier.state.state, AuthState.error);
      expect(notifier.state.error, isNotNull);
    });

    test('should verify pin successfully', () async {
      await notifier.verifyPin('1234');
      expect(notifier.state.state, AuthState.authenticated);
    });

    test('should handle verify pin failure', () async {
      fakeVerifyPin.returnValue = false;
      await notifier.verifyPin('0000');
      expect(notifier.state.state, AuthState.unauthenticated);
    });

    test('should handle verify pin exception', () async {
      fakeVerifyPin.throwOnVerify = true;
      await notifier.verifyPin('1234');
      expect(notifier.state.state, AuthState.error);
    });

    test('should set pin and mark hasPin', () async {
      await notifier.setPin('1234');
      expect(notifier.state.hasPin, true);
      expect(notifier.state.error, isNull);
    });

    test('should handle set pin exception', () async {
      fakeSetPin.throwOnSet = true;
      await notifier.setPin('1234');
      expect(notifier.state.state, AuthState.error);
    });
  });

  group('AuthPage', () {
    AuthNotifier unauthNotifier(Ref ref) {
      final notifier = AuthNotifier(
        ref.read(authenticateUseCaseProvider),
        ref.read(setPinUseCaseProvider),
        ref.read(verifyPinUseCaseProvider),
      );
      notifier.state = const AuthStatus(state: AuthState.unauthenticated);
      return notifier;
    }

    testWidgets('should display app title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authProvider.overrideWith(unauthNotifier)],
          child: const MaterialApp(home: AuthPage()),
        ),
      );
      expect(find.text('VCardSmart'), findsOneWidget);
    });

    testWidgets('should display subtitle', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authProvider.overrideWith(unauthNotifier)],
          child: const MaterialApp(home: AuthPage()),
        ),
      );
      expect(find.text('Autentique-se para continuar'), findsOneWidget);
    });

    testWidgets('should display logo icon', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authProvider.overrideWith(unauthNotifier)],
          child: const MaterialApp(home: AuthPage()),
        ),
      );
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });
  });

  group('PinSetupPage', () {
    testWidgets('should display title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: PinSetupPage()),
        ),
      );
      expect(find.text('Configurar PIN'), findsOneWidget);
    });

    testWidgets('should display PIN input', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: PinSetupPage()),
        ),
      );
      expect(find.text('Digite o PIN'), findsOneWidget);
    });

    testWidgets('should display PIN icon', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: PinSetupPage()),
        ),
      );
      expect(find.byIcon(Icons.pin_outlined), findsOneWidget);
    });
  });

  group('BiometricButton', () {
    testWidgets('should display button text', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: BiometricButton()),
          ),
        ),
      );
      expect(find.text('Autenticar com Biometria'), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
    });
  });

  group('PinInput', () {
    testWidgets('should display correct number of fields', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PinInput(onCompleted: (pin) {}, length: 4),
        ),
      ),);

      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('should call onCompleted when all fields filled', (tester) async {
      String? completedPin;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PinInput(
            onCompleted: (pin) => completedPin = pin,
            length: 4,
          ),
        ),
      ),);

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '1');
      await tester.enterText(fields.at(1), '2');
      await tester.enterText(fields.at(2), '3');
      await tester.enterText(fields.at(3), '4');
      await tester.pump();

      expect(completedPin, '1234');
    });

    testWidgets('should support custom length', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PinInput(onCompleted: (pin) {}, length: 6),
        ),
      ),);

      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('should handle backspace by clearing field', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PinInput(onCompleted: (pin) {}, length: 4),
        ),
      ),);

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '1');
      await tester.pump();

      await tester.enterText(fields.at(0), '');
      await tester.pump();
    });
  });
}

class _FakeAuthenticateUseCase extends AuthenticateUseCase {
  bool returnAuth = true;
  bool throwOnAuth = false;

  @override
  Future<bool> call() async {
    if (throwOnAuth) throw Exception('Auth failed');
    return returnAuth;
  }

  @override
  Future<bool> isRequired() async => true;

  @override
  Future<bool> isCurrentlyAuthenticated() async => true;
}

class _FakeSetPinUseCase extends SetPinUseCase {
  bool throwOnSet = false;

  @override
  Future<void> call(String pin) async {
    if (throwOnSet) throw Exception('Set pin failed');
  }

  @override
  Future<bool> hasPin() async => true;

  @override
  Future<void> removePin() async {}
}

class _FakeVerifyPinUseCase extends VerifyPinUseCase {
  bool returnValue = true;
  bool throwOnVerify = false;

  @override
  Future<bool> call(String pin) async {
    if (throwOnVerify) throw Exception('Verify failed');
    return returnValue;
  }
}
