import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VCardSmart'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Business Card'**
  String get appSubtitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTitle;

  /// No description provided for @importTitle.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @contactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTitle;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @scanButton.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanButton;

  /// No description provided for @nfcButton.
  ///
  /// In en, this message translates to:
  /// **'Share via NFC'**
  String get nfcButton;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create Card'**
  String get createButton;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @emptyState.
  ///
  /// In en, this message translates to:
  /// **'No cards yet. Create your first digital card!'**
  String get emptyState;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securitySection;

  /// No description provided for @privacySection.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacySection;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @biometricLabel.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get biometricLabel;

  /// No description provided for @biometricDescription.
  ///
  /// In en, this message translates to:
  /// **'Authenticate with fingerprint'**
  String get biometricDescription;

  /// No description provided for @pinLabel.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get pinLabel;

  /// No description provided for @pinDescription.
  ///
  /// In en, this message translates to:
  /// **'Protect with PIN'**
  String get pinDescription;

  /// No description provided for @adsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ads'**
  String get adsLabel;

  /// No description provided for @adsDescription.
  ///
  /// In en, this message translates to:
  /// **'Show relevant ads'**
  String get adsDescription;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italian;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'No profile found'**
  String get profileNotFound;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retryButton;

  /// No description provided for @importContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Contact'**
  String get importContactTitle;

  /// No description provided for @importViaQR.
  ///
  /// In en, this message translates to:
  /// **'Import via QR Code'**
  String get importViaQR;

  /// No description provided for @importViaNFC.
  ///
  /// In en, this message translates to:
  /// **'Import via NFC'**
  String get importViaNFC;

  /// No description provided for @importViaVCard.
  ///
  /// In en, this message translates to:
  /// **'Import via vCard'**
  String get importViaVCard;

  /// No description provided for @pasteVCard.
  ///
  /// In en, this message translates to:
  /// **'Paste vCard'**
  String get pasteVCard;

  /// No description provided for @importButton.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importButton;

  /// No description provided for @viaQRCode.
  ///
  /// In en, this message translates to:
  /// **'Via QR Code'**
  String get viaQRCode;

  /// No description provided for @viaNFC.
  ///
  /// In en, this message translates to:
  /// **'Via NFC'**
  String get viaNFC;

  /// No description provided for @viaVCard.
  ///
  /// In en, this message translates to:
  /// **'Via vCard'**
  String get viaVCard;

  /// No description provided for @profileReceived.
  ///
  /// In en, this message translates to:
  /// **'Profile Received'**
  String get profileReceived;

  /// No description provided for @profileFound.
  ///
  /// In en, this message translates to:
  /// **'Profile Found'**
  String get profileFound;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @receiveViaNFC.
  ///
  /// In en, this message translates to:
  /// **'Receive via NFC'**
  String get receiveViaNFC;

  /// No description provided for @startReceiving.
  ///
  /// In en, this message translates to:
  /// **'Start receiving'**
  String get startReceiving;

  /// No description provided for @shareViaNFC.
  ///
  /// In en, this message translates to:
  /// **'Share via NFC'**
  String get shareViaNFC;

  /// No description provided for @shareViaQR.
  ///
  /// In en, this message translates to:
  /// **'Share via QR Code'**
  String get shareViaQR;

  /// No description provided for @startSending.
  ///
  /// In en, this message translates to:
  /// **'Start sending'**
  String get startSending;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get sendAgain;

  /// No description provided for @profileSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile sent successfully!'**
  String get profileSentSuccess;

  /// No description provided for @scanQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQRCode;

  /// No description provided for @cropPhoto.
  ///
  /// In en, this message translates to:
  /// **'Crop Photo'**
  String get cropPhoto;

  /// No description provided for @useButton.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get useButton;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @noProfileFound.
  ///
  /// In en, this message translates to:
  /// **'No profile found'**
  String get noProfileFound;

  /// No description provided for @pinSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up PIN'**
  String get pinSetupTitle;

  /// No description provided for @pinSetupSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN set up successfully!'**
  String get pinSetupSuccess;

  /// No description provided for @pinSetupMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match'**
  String get pinSetupMismatch;

  /// No description provided for @openingQRReader.
  ///
  /// In en, this message translates to:
  /// **'Opening QR Code reader...'**
  String get openingQRReader;

  /// No description provided for @openingNFCReader.
  ///
  /// In en, this message translates to:
  /// **'Opening NFC reader...'**
  String get openingNFCReader;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'pt',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
