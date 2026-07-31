import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/ads/ad_config.dart';
import '../../../../core/ads/ad_units.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _loadFailed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adsEnabled = ref.watch(settingsProvider).adsEnabled;
    if (adsEnabled && AdConfig.showBanner && !_isLoaded && !_loadFailed) {
      _loadAd();
    }
  }

  void _loadAd() {
    BannerAd(
      adUnitId: AdUnits.bannerPlatform,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _bannerAd = ad as BannerAd;
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) {
            setState(() => _loadFailed = true);
          }
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    final adsEnabled = ref.watch(settingsProvider).adsEnabled;

    if (!adsEnabled || !AdConfig.showBanner) {
      return const SizedBox.shrink();
    }

    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox(height: 50);
    }

    return SizedBox(
      height: 50,
      child: AdWidget(ad: _bannerAd!),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
