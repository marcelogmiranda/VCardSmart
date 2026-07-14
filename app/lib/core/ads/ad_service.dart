import 'ad_config.dart';
import 'ad_data_source.dart';
import 'ad_units.dart';

class AdService {
  final AdDataSource _dataSource;
  int _actionCount = 0;
  bool _initialized = false;

  AdService(this._dataSource);

  bool get isInitialized => _initialized;
  int get actionCount => _actionCount;

  Future<void> init() async {
    if (_initialized) return;
    await _dataSource.initialize();
    _initialized = true;
    await loadInterstitial();
  }

  Future<void> loadInterstitial() async {
    if (!AdConfig.showInterstitial) return;
    await _dataSource.loadInterstitial(AdUnits.interstitialPlatform);
  }

  void showInterstitialIfNeeded() {
    if (!AdConfig.showInterstitial) return;
    if (!_initialized) return;

    _actionCount++;
    if (_actionCount >= AdConfig.interstitialInterval) {
      _actionCount = 0;
      _dataSource.showInterstitial();
      loadInterstitial();
    }
  }

  void resetActionCount() {
    _actionCount = 0;
  }

  void dispose() {
    _dataSource.disposeInterstitial();
    _initialized = false;
  }
}
