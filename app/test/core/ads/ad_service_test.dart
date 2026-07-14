import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/ads/ad_data_source.dart';
import 'package:vcardsmart/core/ads/ad_service.dart';

class MockAdDataSource implements AdDataSource {
  int initializeCount = 0;
  int loadInterstitialCount = 0;
  int showInterstitialCount = 0;
  int disposeCount = 0;
  String? lastAdUnitId;

  @override
  Future<void> initialize() async {
    initializeCount++;
  }

  @override
  Future<void> loadInterstitial(String adUnitId) async {
    loadInterstitialCount++;
    lastAdUnitId = adUnitId;
  }

  @override
  void showInterstitial() {
    showInterstitialCount++;
  }

  @override
  void disposeInterstitial() {
    disposeCount++;
  }
}

void main() {
  late AdService adService;
  late MockAdDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAdDataSource();
    adService = AdService(mockDataSource);
  });

  group('AdService', () {
    test('should start uninitialized', () {
      expect(adService.isInitialized, isFalse);
    });

    test('should start with actionCount 0', () {
      expect(adService.actionCount, 0);
    });

    test('should initialize with data source', () async {
      await adService.init();

      expect(adService.isInitialized, isTrue);
      expect(mockDataSource.initializeCount, 1);
    });

    test('should not initialize twice', () async {
      await adService.init();
      await adService.init();

      expect(mockDataSource.initializeCount, 1);
    });

    test('should load interstitial on init', () async {
      await adService.init();

      expect(mockDataSource.loadInterstitialCount, greaterThanOrEqualTo(1));
    });

    test('should increment action count', () async {
      await adService.init();
      adService.showInterstitialIfNeeded();

      expect(adService.actionCount, 1);
    });

    test('should show interstitial at interval', () async {
      await adService.init();

      adService.showInterstitialIfNeeded();
      adService.showInterstitialIfNeeded();
      adService.showInterstitialIfNeeded();

      expect(mockDataSource.showInterstitialCount, 1);
      expect(adService.actionCount, 0);
    });

    test('should not show interstitial before interval', () async {
      await adService.init();

      adService.showInterstitialIfNeeded();
      adService.showInterstitialIfNeeded();

      expect(mockDataSource.showInterstitialCount, 0);
      expect(adService.actionCount, 2);
    });

    test('should reset action count', () async {
      await adService.init();
      adService.showInterstitialIfNeeded();
      adService.resetActionCount();

      expect(adService.actionCount, 0);
    });

    test('should dispose and mark uninitialized', () async {
      await adService.init();
      adService.dispose();

      expect(adService.isInitialized, isFalse);
      expect(mockDataSource.disposeCount, 1);
    });

    test('should not show interstitial when not initialized', () {
      adService.showInterstitialIfNeeded();

      expect(adService.actionCount, 0);
      expect(mockDataSource.showInterstitialCount, 0);
    });
  });
}
