import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/authenticate_usecase.dart';
import '../../domain/usecases/set_pin_usecase.dart';
import '../../domain/usecases/verify_pin_usecase.dart';
import '../../../../core/security/biometric_service.dart';

enum AuthState { unauthenticated, authenticated, checking, error }

class AuthStatus {
  final AuthState state;
  final bool biometricAvailable;
  final bool hasPin;
  final String? error;

  const AuthStatus({
    this.state = AuthState.checking,
    this.biometricAvailable = false,
    this.hasPin = false,
    this.error,
  });

  AuthStatus copyWith({
    AuthState? state,
    bool? biometricAvailable,
    bool? hasPin,
    String? error,
  }) {
    return AuthStatus(
      state: state ?? this.state,
      biometricAvailable: biometricAvailable ?? this.biometricAvailable,
      hasPin: hasPin ?? this.hasPin,
      error: error,
    );
  }
}

final authenticateUseCaseProvider = Provider((ref) {
  return AuthenticateUseCase();
});

final setPinUseCaseProvider = Provider((ref) {
  return SetPinUseCase();
});

final verifyPinUseCaseProvider = Provider((ref) {
  return VerifyPinUseCase();
});

final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final useCase = ref.read(authenticateUseCaseProvider);
  return await useCase.isCurrentlyAuthenticated();
});

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthenticateUseCase _authenticate;
  final SetPinUseCase _setPin;
  final VerifyPinUseCase _verifyPin;

  AuthNotifier(this._authenticate, this._setPin, this._verifyPin)
      : super(const AuthStatus());

  Future<void> checkAuth() async {
    state = state.copyWith(state: AuthState.checking);
    try {
      final biometricAvailable = await BiometricService.isAvailable();
      final hasPin = await _authenticate.isRequired();
      final isAuth = await _authenticate.isCurrentlyAuthenticated();

      state = state.copyWith(
        state: isAuth ? AuthState.authenticated : AuthState.unauthenticated,
        biometricAvailable: biometricAvailable,
        hasPin: hasPin,
      );
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> authenticate() async {
    state = state.copyWith(state: AuthState.checking);
    try {
      final result = await _authenticate();
      state = state.copyWith(
        state: result ? AuthState.authenticated : AuthState.unauthenticated,
      );
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> verifyPin(String pin) async {
    state = state.copyWith(state: AuthState.checking);
    try {
      final result = await _verifyPin(pin);
      state = state.copyWith(
        state: result ? AuthState.authenticated : AuthState.unauthenticated,
      );
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> setPin(String pin) async {
    try {
      await _setPin(pin);
      await checkAuth();
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(
    ref.read(authenticateUseCaseProvider),
    ref.read(setPinUseCaseProvider),
    ref.read(verifyPinUseCaseProvider),
  )..checkAuth();
});
