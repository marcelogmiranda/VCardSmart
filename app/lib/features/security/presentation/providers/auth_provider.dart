import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/authenticate_usecase.dart';
import '../../domain/usecases/set_pin_usecase.dart';
import '../../domain/usecases/verify_pin_usecase.dart';
import '../../../../core/security/auth_service.dart';
import '../../../settings/domain/entities/settings.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

enum AuthState { unauthenticated, authenticated, checking, error }

class AuthStatus {
  final AuthState state;
  final bool biometricAvailable;
  final bool hasPin;
  final bool needsSetup;
  final int pinLength;
  final String? error;

  const AuthStatus({
    this.state = AuthState.checking,
    this.biometricAvailable = false,
    this.hasPin = false,
    this.needsSetup = false,
    this.pinLength = 6,
    this.error,
  });

  AuthStatus copyWith({
    AuthState? state,
    bool? biometricAvailable,
    bool? hasPin,
    bool? needsSetup,
    int? pinLength,
    String? error,
  }) {
    return AuthStatus(
      state: state ?? this.state,
      biometricAvailable: biometricAvailable ?? this.biometricAvailable,
      hasPin: hasPin ?? this.hasPin,
      needsSetup: needsSetup ?? this.needsSetup,
      pinLength: pinLength ?? this.pinLength,
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

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthenticateUseCase _authenticate;
  final SetPinUseCase _setPin;
  final VerifyPinUseCase _verifyPin;
  final SettingsNotifier? _settingsNotifier;

  int _checkGeneration = 0;

  AuthNotifier(
    this._authenticate,
    this._setPin,
    this._verifyPin, [
    this._settingsNotifier,
  ]) : super(const AuthStatus());

  void _invalidatePendingChecks() {
    _checkGeneration++;
  }

  Future<void> checkAuth(Settings settings) async {
    final generation = ++_checkGeneration;
    state = state.copyWith(state: AuthState.checking);
    try {
      bool biometricEnabled;
      try {
        biometricEnabled = settings.biometricEnabled &&
            await _authenticate.isBiometricAvailable();
      } catch (_) {
        biometricEnabled = false;
      }
      bool hasPin;
      try {
        hasPin = settings.pinEnabled && await _setPin.hasPin();
      } catch (_) {
        hasPin = false;
      }
      var needsSetup = !settings.securitySetupAsked &&
          !biometricEnabled &&
          !hasPin;

      final pinMissing = settings.pinEnabled && !hasPin;
      if (pinMissing && !biometricEnabled) {
        needsSetup = true;
        await _settingsNotifier?.updatePin(false);
      }

      final isAuth = await _authenticate.isCurrentlyAuthenticated() ||
          !(hasPin || biometricEnabled);

      if (generation != _checkGeneration) return;
      state = state.copyWith(
        state: isAuth ? AuthState.authenticated : AuthState.unauthenticated,
        biometricAvailable: biometricEnabled,
        hasPin: hasPin,
        needsSetup: needsSetup,
        pinLength: settings.pinLength,
      );
    } catch (e) {
      if (generation != _checkGeneration) return;
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> authenticate() async {
    _invalidatePendingChecks();
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
    _invalidatePendingChecks();
    state = state.copyWith(state: AuthState.checking);
    try {
      final result = await _verifyPin(pin);
      if (result) {
        AuthService.markAuthenticated();
      }
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

  Future<void> setPin(String pin, {int length = 6}) async {
    _invalidatePendingChecks();
    try {
      await _setPin(pin, length: length);
      state = state.copyWith(hasPin: true, error: null);
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> removePin() async {
    _invalidatePendingChecks();
    try {
      await _setPin.removePin();
      state = state.copyWith(hasPin: false, error: null);
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        error: e.toString(),
      );
    }
  }

  void logout() {
    _invalidatePendingChecks();
    AuthService.logout();
    state = state.copyWith(state: AuthState.unauthenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier(
    ref.read(authenticateUseCaseProvider),
    ref.read(setPinUseCaseProvider),
    ref.read(verifyPinUseCaseProvider),
    ref.read(settingsProvider.notifier),
  );
});
