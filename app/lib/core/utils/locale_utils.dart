import 'package:flutter/material.dart';

class LocaleUtils {
  LocaleUtils._();

  static const supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('de'),
    Locale('ja'),
    Locale('zh'),
  ];

  static Locale getDeviceLocale() {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return locale;
      }
    }

    return const Locale('pt', 'BR');
  }

  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'pt':
        return 'Português';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'it':
        return 'Italiano';
      case 'de':
        return 'Deutsch';
      case 'ja':
        return '日本語';
      case 'zh':
        return '中文';
      default:
        return 'Português';
    }
  }
}
