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

class _InMemorySettingsRepository implements SettingsRepository {
  Settings settings;

  _InMemorySettingsRepository(this.settings);

  @override
  Future<Settings> getSettings() async => settings;

  @override
  Future<void> updateSettings(Settings updated) async {
    settings = updated;
  }

  @override
  Future<void> resetSettings() async {
    settings = const Settings();
  }
}

class _FakePinStorage {
  String? pin;

  Future<void> setPin(String value) async => pin = value;

  Future<bool> verifyPin(String value) async => pin != null && value == pin;

  Future<bool> hasPin() async => pin != null;

  Future<void> removePin() async => pin = null;
}

class _TestEnv {
  final _FakePinStorage pinStorage = _FakePinStorage();
  bool isAuthenticated = false;
  bool biometricAvailable = false;
  bool biometricAuthenticateResult = true;

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

Settings _secureSettings() => const Settings(
      securitySetupAsked: true,
      adsEnabled: false,
    );

Future<void> _pumpApp(WidgetTester tester, Settings initial) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider
            .overrideWithValue(_InMemorySettingsRepository(initial)),
      ],
      child: const VCardSmartApp(),
    ),
  );
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
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

  setUp(() {
    env = _TestEnv();
    env.installDebugOverrides();
  });
  tearDown(_clearDebugOverrides);

  group('Security setup flow', () {
    testWidgets('first launch shows security setup page', (tester) async {
      await _pumpApp(tester, const Settings(adsEnabled: false));

      await _pumpUntilFound(tester, find.text('Agora não'));
      expect(find.text('Definir um PIN'), findsOneWidget);
      expect(find.text('Proteja seu app para começar'), findsOneWidget);
    });

    testWidgets('"Agora não" goes to home and does not lock again',
        (tester) async {
      await _pumpApp(tester, const Settings(adsEnabled: false));

      await _pumpUntilFound(tester, find.text('Agora não'));
      await tester.tap(find.text('Agora não'));
      await _pumpUntilFound(tester, find.text('Meu Cartão'));

      expect(find.text('Agora não'), findsNothing);
    });

    testWidgets('"Definir um PIN" opens PIN page and locks the app',
        (tester) async {
      await _pumpApp(tester, const Settings(adsEnabled: false));

      await _pumpUntilFound(tester, find.text('Definir um PIN'));
      await tester.tap(find.text('Definir um PIN'));
      await _pumpUntilFound(tester, find.text('Digite o PIN'));

      await _enterPin(tester, '123456');
      await _pumpUntilFound(tester, find.text('Confirme o PIN'));
      await _enterPin(tester, '123456');

      await _pumpUntilFound(tester, find.text('Autentique-se para continuar'));
      expect(find.text('Meu Cartão'), findsNothing);
    });

    testWidgets('after PIN setup, entering the PIN unlocks home',
        (tester) async {
      await _pumpApp(tester, const Settings(adsEnabled: false));

      await _pumpUntilFound(tester, find.text('Definir um PIN'));
      await tester.tap(find.text('Definir um PIN'));
      await _pumpUntilFound(tester, find.text('Digite o PIN'));

      await _enterPin(tester, '123456');
      await _pumpUntilFound(tester, find.text('Confirme o PIN'));
      await _enterPin(tester, '123456');

      await _pumpUntilFound(tester, find.text('Autentique-se para continuar'));
      await _enterPin(tester, '123456');
      await _pumpUntilFound(tester, find.text('Meu Cartão'));

      expect(find.text('Autentique-se para continuar'), findsNothing);
    });
  });

  group('Locked app restart', () {
    testWidgets('restart with PIN configured shows auth page', (tester) async {
      env.pinStorage.pin = '123456';

      await _pumpApp(tester, _secureSettings().copyWith(pinEnabled: true));

      await _pumpUntilFound(
        tester,
        find.text('Autentique-se para continuar'),
      );
      expect(find.text('Meu Cartão'), findsNothing);
    });

    testWidgets('wrong PIN keeps app locked', (tester) async {
      env.pinStorage.pin = '123456';

      await _pumpApp(tester, _secureSettings().copyWith(pinEnabled: true));

      await _pumpUntilFound(
        tester,
        find.text('Autentique-se para continuar'),
      );
      await _enterPin(tester, '000000');

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Meu Cartão'), findsNothing);
      expect(find.text('Autentique-se para continuar'), findsOneWidget);
    });

    testWidgets('correct PIN unlocks home', (tester) async {
      env.pinStorage.pin = '123456';

      await _pumpApp(tester, _secureSettings().copyWith(pinEnabled: true));

      await _pumpUntilFound(
        tester,
        find.text('Autentique-se para continuar'),
      );
      await _enterPin(tester, '123456');

      await _pumpUntilFound(tester, find.text('Meu Cartão'));
    });

    testWidgets('biometric auth button unlocks home when configured',
        (tester) async {
      env.biometricAvailable = true;
      env.biometricAuthenticateResult = true;

      await _pumpApp(
        tester,
        _secureSettings().copyWith(biometricEnabled: true),
      );

      await _pumpUntilFound(
        tester,
        find.text('Autenticar com Biometria'),
      );
      await tester.tap(find.text('Autenticar com Biometria'));

      await _pumpUntilFound(tester, find.text('Meu Cartão'));
    });
  });

  group('PIN storage recovery', () {
    testWidgets('settings claim PIN but storage is missing shows setup again',
        (tester) async {
      await _pumpApp(
        tester,
        _secureSettings().copyWith(pinEnabled: true),
      );

      await _pumpUntilFound(tester, find.text('Definir um PIN'));
      expect(find.text('Autentique-se para continuar'), findsNothing);
      expect(find.text('Meu Cartão'), findsNothing);
    });

    testWidgets('new PIN can be registered after recovery', (tester) async {
      await _pumpApp(
        tester,
        _secureSettings().copyWith(pinEnabled: true),
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
    });

    testWidgets('biometric unlock still works when PIN storage is missing',
        (tester) async {
      env.biometricAvailable = true;
      env.biometricAuthenticateResult = true;

      await _pumpApp(
        tester,
        _secureSettings().copyWith(pinEnabled: true, biometricEnabled: true),
      );

      await _pumpUntilFound(
        tester,
        find.text('Autenticar com Biometria'),
      );
      expect(find.text('Definir um PIN'), findsNothing);
    });
  });
}
