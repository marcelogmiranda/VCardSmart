abstract class AdDataSource {
  Future<void> initialize();
  Future<void> loadInterstitial(String adUnitId);
  void showInterstitial();
  void disposeInterstitial();
}
