import 'dart:io';

class AdUnits {
  const AdUnits._();

  static const String bannerAndroid = 'ca-app-pub-8091341581687367/4010700646';
  static const String bannerIOS = 'ca-app-pub-8091341581687367/4010700646';
  static const String interstitialAndroid = 'ca-app-pub-8091341581687367/5452875875';
  static const String interstitialIOS = 'ca-app-pub-8091341581687367/5452875875';

  static String banner({
    bool isAndroid = const bool.fromEnvironment('dart.library.io'),
    bool isIOS = false,
  }) {
    if (isAndroid) return bannerAndroid;
    if (isIOS) return bannerIOS;
    return bannerAndroid;
  }

  static String interstitial({
    bool isAndroid = const bool.fromEnvironment('dart.library.io'),
    bool isIOS = false,
  }) {
    if (isAndroid) return interstitialAndroid;
    if (isIOS) return interstitialIOS;
    return interstitialAndroid;
  }

  static String _getBannerId() {
    if (Platform.isAndroid) return bannerAndroid;
    if (Platform.isIOS) return bannerIOS;
    return bannerAndroid;
  }

  static String _getInterstitialId() {
    if (Platform.isAndroid) return interstitialAndroid;
    if (Platform.isIOS) return interstitialIOS;
    return interstitialAndroid;
  }

  static String get bannerPlatform => _getBannerId();
  static String get interstitialPlatform => _getInterstitialId();
}
