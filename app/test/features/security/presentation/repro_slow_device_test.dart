import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/app.dart';
import 'package:vcardsmart/core/security/auth_service.dart';
import 'package:vcardsmart/core/security/biometric_service.dart';
import 'package:vcardsmart/core/security/pin_service.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';
import 'package:vcardsmart/features/settings/domain/repositories/settings_repository.dart';
import 'package:vcardsmart/features/settings/presentation/providers/settings_provider.dart';

class _SlowSettingsRepository implements SettingsRepository {
  Settings settings;
  final Duration delay;

  _SlowSettingsRepository(this.settings, this.delay);

  Future<void> _wait() async {
    if (delay > Duration.zero) {
      final c = Completer<void>();
      Timer(delay, c.complete);
      await c.future;
    }
  }

  @override
  Future<Settings> getSettings() async {
    await _wait();
    return settings;
  }

  @override
  Future<void> updateSettings(Settings updated) async {
    await _wait();
    settings = updated;
  }

  @override
  Future<void> resetSettings() async {
    await _wait();
    settings = const Settings();
  }
}

class _FakePinStorage {
  String? pin;
  final Duration delay;

  _FakePinStorage(this.delay);

  Future<void> _wait() async {
    if (delay > Duration.zero) {
      final c = Completer<void>();
      Timer(delay, c.complete);
      await c.future;
    }
  }

  Future<void> setPin(String value) async {
    await _wait();
    pin = value;
  }

  Future<bool> verifyPin(String value) async {
    await _wait();
    return pin != null && value == pin;
  }

  Future<bool> hasPin() async {
    await _wait();
    return pin != null;
  }

  Future<void> removePin() async {
    await _wait();
    pin = null;
  }
}

class _TestEnv {
  final Duration delay;
  late final _FakePinStorage pinStorage;
  bool isAuthenticated = false;
  bool biometricAvailable = false;
  bool biometricAuthenticateResult = true;

  _TestEnv(this.delay) {
    pinStorage = _FakePinStorage(delay);
  }

  void installDebugOverrides() {
    PinService.debugSetPinOverride = (pin) => pinStorage.setPin(pin);
    PinService.debugVerifyPinOverride = (pin) => pinStorage.verifyPin(pin);
    PinService.debugHasPinOverride = () => pinStorage.hasPin();
    PinService.debugRemovePinOverride = () => pinStorage.removePin();

    BiometricService.debugIsAvailableOverride = () async => biometricAvailable;
    BiometricService.debugAuthenticateOverride =
        () async => biometricAuthenticateResult;

    AuthService.debugIsAuthenticatedOverride = () async => isAuthenticated;
    AuthService.debugMarkAuthenticatedOverride = () {
      isAuthenticated = true;
    };
    AuthService.debugLogoutOverride = () {
      isAuthenticated = false;
    };
  }
}

void _clearDebugOverrides() {
  PinService.debugSetPinOverride = null;
  PinService.debugVerifyPinOverride = null;
  PinService.debugHasPinOverride = null;
  PinService.debugRemovePinOverride = null;
  BiometricService.debugIsAvailableOverride = null;
  BiometricService.debugAuthenticateOverride = null;
  AuthService.debugIsAuthenticatedOverride = null;
  AuthService.debugMarkAuthenticatedOverride = null;
  AuthService.debugLogoutOverride = null;
}

Future<void> _pumpApp(
  WidgetTester tester,
  Settings initial,
  Duration delay,
) async {
  final repo = _SlowSettingsRepository(initial, delay);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(repo),
      ],
      child: const VCardSmartApp(),
    ),
  );
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 50));
    if (finder.evaluate().isNotEmpty) {
      await tester.pumpAndSettle();
      return;
    }
  }
  fail('Timeout waiting for: $finder');
}

Future<void> _enterPin(WidgetTester tester, String pin) async {
  for (var i = 0; i < pin.length; i++) {
    await tester.enterText(find.byType(TextField).at(i), pin[i]);
    await tester.pump();
  }
}

void main() {
  late _TestEnv env;

  for (final delayMs in [0, 20, 80, 150]) {
    setUp(() {
      env = _TestEnv(Duration(milliseconds: delayMs));
      env.installDebugOverrides();
    });
    tearDown(_clearDebugOverrides);

    testWidgets('slow device ($delayMs ms): PIN setup ends on auth page',
        (tester) async {
      await _pumpApp(
        tester,
        const Settings(adsEnabled: false),
        Duration(milliseconds: delayMs),
      );

      await _pumpUntilFound(tester, find.text('Definir um PIN'));
      await tester.tap(find.text('Definir um PIN'));
      await _pumpUntilFound(tester, find.text('Digite o PIN'));

      await _enterPin(tester, '123456');
      await _pumpUntilFound(tester, find.text('Confirme o PIN'));
      await _enterPin(tester, '123456');

      await _pumpUntilFound(
        tester,
        find.text('Autentique-se para continuar'),
      );
      expect(find.text('Meu Cartão'), findsNothing);
    });
  }
}
