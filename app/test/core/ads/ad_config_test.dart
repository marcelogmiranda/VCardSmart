import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/ads/ad_config.dart';

void main() {
  group('AdConfig', () {
    test('should have showAds as true', () {
      expect(AdConfig.showAds, isTrue);
    });

    test('should have showBanner as true', () {
      expect(AdConfig.showBanner, isTrue);
    });

    test('should have showInterstitial as true', () {
      expect(AdConfig.showInterstitial, isTrue);
    });

    test('should have showRewarded as false', () {
      expect(AdConfig.showRewarded, isFalse);
    });

    test('should have interstitialInterval as 3', () {
      expect(AdConfig.interstitialInterval, 3);
    });
  });
}
