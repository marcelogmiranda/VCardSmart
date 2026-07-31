import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';
import 'package:vcardsmart/core/constants/app_constants.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/theme_toggle.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/language_selector.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/security_settings.dart';
import 'package:vcardsmart/features/settings/presentation/widgets/privacy_settings.dart';
import 'package:vcardsmart/features/settings/presentation/pages/settings_page.dart';
import 'package:vcardsmart/features/settings/presentation/providers/settings_provider.dart';
import 'package:vcardsmart/features/settings/domain/repositories/settings_repository.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

class _FakeSettingsRepository implements SettingsRepository {
  Settings _settings = const Settings();

  @override
  Future<Settings> getSettings() async => _settings;

  @override
  Future<void> updateSettings(Settings settings) async => _settings = settings;

  @override
  Future<void> resetSettings() async => _settings = const Settings();
}

final _settingsOverrides = [
  settingsRepositoryProvider.overrideWith((ref) => _FakeSettingsRepository()),
];

MaterialApp testApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

const _localizationDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

void main() {
  group('ThemeToggle', () {
    testWidgets('should display theme title', (tester) async {
      await tester.pumpWidget(
        testApp(
          ThemeToggle(
            themeMode: ThemeMode.system,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Tema'), findsOneWidget);
      expect(find.byIcon(Icons.palette), findsOneWidget);
    });
  });

  group('LanguageSelector', () {
    testWidgets('should display language title', (tester) async {
      await tester.pumpWidget(
        testApp(
          LanguageSelector(
            locale: const Locale('pt', 'BR'),
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Idioma'), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
    });
  });

  group('SecuritySettings', () {
    testWidgets('should display biometric toggle', (tester) async {
      await tester.pumpWidget(
        testApp(
          SecuritySettings(
            biometricEnabled: false,
            pinEnabled: false,
            onBiometricChanged: (_) {},
            onPinChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Biometria'), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
    });

    testWidgets('should display pin toggle', (tester) async {
      await tester.pumpWidget(
        testApp(
          SecuritySettings(
            biometricEnabled: false,
            pinEnabled: false,
            onBiometricChanged: (_) {},
            onPinChanged: (_) {},
          ),
        ),
      );

      expect(find.text('PIN'), findsOneWidget);
      expect(find.byIcon(Icons.pin), findsOneWidget);
    });
  });

  group('PrivacySettings', () {
    testWidgets('should display ads toggle', (tester) async {
      await tester.pumpWidget(
        testApp(
          PrivacySettings(
            adsEnabled: true,
            onAdsChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Anúncios'), findsOneWidget);
      expect(find.byIcon(Icons.ads_click), findsOneWidget);
    });
  });

  group('SettingsPage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _settingsOverrides,
          child: const MaterialApp(
            locale: Locale('pt', 'BR'),
            localizationsDelegates: _localizationDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsPage(),
          ),
        ),
      );

      expect(find.text('Configurações'), findsOneWidget);
    });

    testWidgets('should display section headers', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _settingsOverrides,
          child: const MaterialApp(
            locale: Locale('pt', 'BR'),
            localizationsDelegates: _localizationDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsPage(),
          ),
        ),
      );

      expect(find.text('Aparência'), findsOneWidget);
      expect(find.text('Segurança'), findsOneWidget);
      expect(find.text('Privacidade'), findsOneWidget);
    });

    testWidgets('should display all settings widgets', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _settingsOverrides,
          child: const MaterialApp(
            localizationsDelegates: _localizationDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsPage(),
          ),
        ),
      );

      expect(find.byIcon(Icons.palette), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
      expect(find.byIcon(Icons.pin), findsOneWidget);
      expect(find.byIcon(Icons.ads_click), findsOneWidget);
    });

    testWidgets('should toggle biometric switch', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _settingsOverrides,
          child: const MaterialApp(
            localizationsDelegates: _localizationDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsPage(),
          ),
        ),
      );

      final biometricSwitch = find.byType(SwitchListTile).first;
      expect(biometricSwitch, findsOneWidget);

      await tester.tap(biometricSwitch);
      await tester.pumpAndSettle();
    });

    testWidgets('should toggle pin switch', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _settingsOverrides,
          child: MaterialApp.router(
            localizationsDelegates: _localizationDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: GoRouter(
              initialLocation: '/',
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const SettingsPage(),
                ),
                GoRoute(
                  path: AppConstants.pinSetupRoute,
                  builder: (context, state) =>
                      const Scaffold(body: Text('Configurar PIN')),
                ),
              ],
            ),
          ),
        ),
      );

      final pinSwitch = find.widgetWithText(SwitchListTile, 'PIN');
      expect(pinSwitch, findsOneWidget);

      await tester.tap(pinSwitch);
      await tester.pumpAndSettle();
      expect(find.text('Configurar PIN'), findsOneWidget);
    });
  });
}
