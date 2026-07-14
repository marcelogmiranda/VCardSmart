import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/core/utils/locale_utils.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';

void main() {
  group('LocaleUtils', () {
    group('supportedLocales', () {
      test('should contain 8 locales', () {
        expect(LocaleUtils.supportedLocales.length, 8);
      });

      test('should include Portuguese (BR)', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('pt', 'BR')),
        );
      });

      test('should include English', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('en')),
        );
      });

      test('should include Spanish', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('es')),
        );
      });

      test('should include French', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('fr')),
        );
      });

      test('should include Italian', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('it')),
        );
      });

      test('should include German', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('de')),
        );
      });

      test('should include Japanese', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('ja')),
        );
      });

      test('should include Chinese', () {
        expect(
          LocaleUtils.supportedLocales,
          contains(const Locale('zh')),
        );
      });
    });

    group('getLanguageName', () {
      test('should return Português for pt', () {
        expect(LocaleUtils.getLanguageName(const Locale('pt', 'BR')), 'Português');
      });

      test('should return English for en', () {
        expect(LocaleUtils.getLanguageName(const Locale('en')), 'English');
      });

      test('should return Español for es', () {
        expect(LocaleUtils.getLanguageName(const Locale('es')), 'Español');
      });

      test('should return Français for fr', () {
        expect(LocaleUtils.getLanguageName(const Locale('fr')), 'Français');
      });

      test('should return Italiano for it', () {
        expect(LocaleUtils.getLanguageName(const Locale('it')), 'Italiano');
      });

      test('should return Deutsch for de', () {
        expect(LocaleUtils.getLanguageName(const Locale('de')), 'Deutsch');
      });

      test('should return 日本語 for ja', () {
        expect(LocaleUtils.getLanguageName(const Locale('ja')), '日本語');
      });

      test('should return 中文 for zh', () {
        expect(LocaleUtils.getLanguageName(const Locale('zh')), '中文');
      });

      test('should return Português for unknown locale', () {
        expect(LocaleUtils.getLanguageName(const Locale('xx')), 'Português');
      });
    });
  });

  group('AppLocalizations', () {
    test('should provide translations for pt-BR', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('pt', 'BR'));
      expect(localizations, isA<AppLocalizations>());
    });

    test('should provide translations for en', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('en'));
      expect(localizations, isA<AppLocalizations>());
    });

    test('should have correct pt-BR translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('pt', 'BR'));
      expect(localizations.settingsTitle, 'Configurações');
      expect(localizations.appearanceSection, 'Aparência');
      expect(localizations.securitySection, 'Segurança');
      expect(localizations.privacySection, 'Privacidade');
      expect(localizations.biometricLabel, 'Biometria');
      expect(localizations.adsLabel, 'Anúncios');
      expect(localizations.saveButton, 'Salvar');
      expect(localizations.cancelButton, 'Cancelar');
    });

    test('should have correct en translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('en'));
      expect(localizations.settingsTitle, 'Settings');
      expect(localizations.appearanceSection, 'Appearance');
      expect(localizations.securitySection, 'Security');
      expect(localizations.privacySection, 'Privacy');
      expect(localizations.biometricLabel, 'Biometric');
      expect(localizations.adsLabel, 'Ads');
      expect(localizations.saveButton, 'Save');
      expect(localizations.cancelButton, 'Cancel');
    });

    test('should have correct es translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('es'));
      expect(localizations.settingsTitle, 'Configuración');
      expect(localizations.appearanceSection, 'Apariencia');
    });

    test('should have correct fr translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('fr'));
      expect(localizations.settingsTitle, 'Paramètres');
      expect(localizations.appearanceSection, 'Apparence');
    });

    test('should have correct de translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('de'));
      expect(localizations.settingsTitle, 'Einstellungen');
      expect(localizations.appearanceSection, 'Erscheinungsbild');
    });

    test('should have correct ja translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('ja'));
      expect(localizations.settingsTitle, '設定');
      expect(localizations.appearanceSection, '外観');
    });

    test('should have correct zh translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('zh'));
      expect(localizations.settingsTitle, '设置');
      expect(localizations.appearanceSection, '外观');
    });

    test('should have correct it translations', () async {
      final localizations = await AppLocalizations.delegate.load(const Locale('it'));
      expect(localizations.settingsTitle, 'Impostazioni');
      expect(localizations.appearanceSection, 'Aspetto');
    });
  });
}
