import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_data_source.dart';

class LocalAdDataSource implements AdDataSource {
  InterstitialAd? _interstitialAd;

  InterstitialAd? get interstitialAd => _interstitialAd;

  @override
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  @override
  Future<void> loadInterstitial(String adUnitId) async {
    await InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  @override
  void showInterstitial() {
    _interstitialAd?.show();
  }

  @override
  void disposeInterstitial() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
