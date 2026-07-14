import '../../../../core/ads/ad_service.dart';

class InterstitialAdWidget {
  InterstitialAdWidget._();

  static void showIfNeeded(AdService adService) {
    adService.showInterstitialIfNeeded();
  }
}
