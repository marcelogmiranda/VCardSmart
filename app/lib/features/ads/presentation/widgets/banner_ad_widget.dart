import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../core/ads/ad_config.dart';
import '../../../../core/ads/ad_units.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded && AdConfig.showBanner) {
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
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    if (!AdConfig.showBanner) {
      return const SizedBox.shrink();
    }

    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
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
