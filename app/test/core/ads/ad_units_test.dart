import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/ads/ad_units.dart';

void main() {
  group('AdUnits', () {
    group('banner', () {
      test('should return bannerAndroid for Android', () {
        expect(AdUnits.banner(isAndroid: true, isIOS: false), AdUnits.bannerAndroid);
      });

      test('should return bannerIOS for iOS', () {
        expect(AdUnits.banner(isAndroid: false, isIOS: true), AdUnits.bannerIOS);
      });

      test('should return bannerAndroid as default', () {
        expect(AdUnits.banner(), AdUnits.bannerAndroid);
      });
    });

    group('interstitial', () {
      test('should return interstitialAndroid for Android', () {
        expect(AdUnits.interstitial(isAndroid: true, isIOS: false), AdUnits.interstitialAndroid);
      });

      test('should return interstitialIOS for iOS', () {
        expect(AdUnits.interstitial(isAndroid: false, isIOS: true), AdUnits.interstitialIOS);
      });

      test('should return interstitialAndroid as default', () {
        expect(AdUnits.interstitial(), AdUnits.interstitialAndroid);
      });
    });

    test('should have placeholder ad unit IDs', () {
      expect(AdUnits.bannerAndroid, contains('ca-app-pub'));
      expect(AdUnits.bannerIOS, contains('ca-app-pub'));
      expect(AdUnits.interstitialAndroid, contains('ca-app-pub'));
      expect(AdUnits.interstitialIOS, contains('ca-app-pub'));
    });
  });
}
