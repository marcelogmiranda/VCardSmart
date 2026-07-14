import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';

void main() {
  final locales = <String, Locale>{
    'pt': const Locale('pt', 'BR'),
    'en': const Locale('en'),
    'es': const Locale('es'),
    'fr': const Locale('fr'),
    'it': const Locale('it'),
    'de': const Locale('de'),
    'ja': const Locale('ja'),
    'zh': const Locale('zh'),
  };

  for (final entry in locales.entries) {
    final code = entry.key;
    final locale = entry.value;

    group('AppLocalizations[$code]', () {
      late AppLocalizations loc;

      setUp(() async {
        loc = await AppLocalizations.delegate.load(locale);
      });

      test('should load for locale $code', () {
        expect(loc, isA<AppLocalizations>());
      });

      test('should return non-empty for all translation keys', () {
        expect(loc.appTitle.isNotEmpty, isTrue);
        expect(loc.appSubtitle.isNotEmpty, isTrue);
        expect(loc.homeTitle.isNotEmpty, isTrue);
        expect(loc.profileTitle.isNotEmpty, isTrue);
        expect(loc.shareTitle.isNotEmpty, isTrue);
        expect(loc.importTitle.isNotEmpty, isTrue);
        expect(loc.settingsTitle.isNotEmpty, isTrue);
        expect(loc.contactsTitle.isNotEmpty, isTrue);
        expect(loc.saveButton.isNotEmpty, isTrue);
        expect(loc.cancelButton.isNotEmpty, isTrue);
        expect(loc.deleteButton.isNotEmpty, isTrue);
        expect(loc.editButton.isNotEmpty, isTrue);
        expect(loc.shareButton.isNotEmpty, isTrue);
        expect(loc.confirmButton.isNotEmpty, isTrue);
        expect(loc.scanButton.isNotEmpty, isTrue);
        expect(loc.nfcButton.isNotEmpty, isTrue);
        expect(loc.createButton.isNotEmpty, isTrue);
        expect(loc.loading.isNotEmpty, isTrue);
        expect(loc.error.isNotEmpty, isTrue);
        expect(loc.noData.isNotEmpty, isTrue);
        expect(loc.emptyState.isNotEmpty, isTrue);
        expect(loc.success.isNotEmpty, isTrue);
        expect(loc.warning.isNotEmpty, isTrue);
        expect(loc.info.isNotEmpty, isTrue);
        expect(loc.appearanceSection.isNotEmpty, isTrue);
        expect(loc.securitySection.isNotEmpty, isTrue);
        expect(loc.privacySection.isNotEmpty, isTrue);
        expect(loc.themeLabel.isNotEmpty, isTrue);
        expect(loc.languageLabel.isNotEmpty, isTrue);
        expect(loc.biometricLabel.isNotEmpty, isTrue);
        expect(loc.biometricDescription.isNotEmpty, isTrue);
        expect(loc.pinLabel.isNotEmpty, isTrue);
        expect(loc.pinDescription.isNotEmpty, isTrue);
        expect(loc.adsLabel.isNotEmpty, isTrue);
        expect(loc.adsDescription.isNotEmpty, isTrue);
        expect(loc.portuguese.isNotEmpty, isTrue);
        expect(loc.english.isNotEmpty, isTrue);
        expect(loc.spanish.isNotEmpty, isTrue);
        expect(loc.french.isNotEmpty, isTrue);
        expect(loc.italian.isNotEmpty, isTrue);
        expect(loc.german.isNotEmpty, isTrue);
        expect(loc.japanese.isNotEmpty, isTrue);
        expect(loc.chinese.isNotEmpty, isTrue);
        expect(loc.profileNotFound.isNotEmpty, isTrue);
        expect(loc.retryButton.isNotEmpty, isTrue);
        expect(loc.importContactTitle.isNotEmpty, isTrue);
        expect(loc.importViaQR.isNotEmpty, isTrue);
        expect(loc.importViaNFC.isNotEmpty, isTrue);
        expect(loc.importViaVCard.isNotEmpty, isTrue);
        expect(loc.pasteVCard.isNotEmpty, isTrue);
        expect(loc.importButton.isNotEmpty, isTrue);
        expect(loc.viaQRCode.isNotEmpty, isTrue);
        expect(loc.viaNFC.isNotEmpty, isTrue);
        expect(loc.viaVCard.isNotEmpty, isTrue);
        expect(loc.profileReceived.isNotEmpty, isTrue);
        expect(loc.profileFound.isNotEmpty, isTrue);
        expect(loc.close.isNotEmpty, isTrue);
        expect(loc.receiveViaNFC.isNotEmpty, isTrue);
        expect(loc.startReceiving.isNotEmpty, isTrue);
        expect(loc.shareViaNFC.isNotEmpty, isTrue);
        expect(loc.shareViaQR.isNotEmpty, isTrue);
        expect(loc.startSending.isNotEmpty, isTrue);
        expect(loc.sendAgain.isNotEmpty, isTrue);
        expect(loc.profileSentSuccess.isNotEmpty, isTrue);
        expect(loc.scanQRCode.isNotEmpty, isTrue);
        expect(loc.cropPhoto.isNotEmpty, isTrue);
        expect(loc.useButton.isNotEmpty, isTrue);
        expect(loc.camera.isNotEmpty, isTrue);
        expect(loc.gallery.isNotEmpty, isTrue);
        expect(loc.noProfileFound.isNotEmpty, isTrue);
        expect(loc.pinSetupTitle.isNotEmpty, isTrue);
        expect(loc.pinSetupSuccess.isNotEmpty, isTrue);
        expect(loc.pinSetupMismatch.isNotEmpty, isTrue);
        expect(loc.openingQRReader.isNotEmpty, isTrue);
        expect(loc.openingNFCReader.isNotEmpty, isTrue);
      });
    });
  }
}
