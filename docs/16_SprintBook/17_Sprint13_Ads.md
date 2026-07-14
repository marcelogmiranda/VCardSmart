# Sprint 13 — Ads

## Objetivo

Implementar monetização com Google AdMob.

## Pré-requisitos

- Sprint 12 concluída
- Multilanguage implementado

## Documentos Obrigatórios

- Architecture.md
- Monetization.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── ads/
│       ├── ad_service.dart
│       ├── ad_config.dart
│       └── ad_units.dart
├── features/
│   └── ads/
│       ├── data/
│       │   └── datasources/
│       │       └── ads_datasource.dart
│       ├── domain/
│       │   └── usecases/
│       │       └── show_ad_usecase.dart
│       └── presentation/
│           └── widgets/
│               ├── banner_ad_widget.dart
│               └── interstitial_ad_widget.dart
```

### Arquivos Alterados

- pubspec.yaml
- android/app/build.gradle
- ios/Runner/Info.plist

## Modelos

### ad_config.dart

```dart
class AdConfig {
  static const bool showAds = true;
  
  static const bool showBanner = true;
  static const bool showInterstitial = true;
  static const bool showRewarded = false;
  
  static const int interstitialInterval = 3; // A cada 3 ações
}
```

### ad_units.dart

```dart
class AdUnits {
  static const String bannerAndroid = 'ca-app-pub-XXX/YYY';
  static const String bannerIOS = 'ca-app-pub-XXX/YYY';
  
  static const String interstitialAndroid = 'ca-app-pub-XXX/YYY';
  static const String interstitialIOS = 'ca-app-pub-XXX/YYY';
  
  static String get banner {
    if (Platform.isAndroid) return bannerAndroid;
    if (Platform.isIOS) return bannerIOS;
    return bannerAndroid;
  }
  
  static String get interstitial {
    if (Platform.isAndroid) return interstitialAndroid;
    if (Platform.isIOS) return interstitialIOS;
    return interstitialAndroid;
  }
}
```

### ad_service.dart

```dart
class AdService {
  static InterstitialAd? _interstitialAd;
  static int _actionCount = 0;
  
  static Future<void> init() async {
    await MobileAds.instance.initialize();
  }
  
  static Future<void> loadInterstitial() async {
    await InterstitialAd.load(
      adUnitId: AdUnits.interstitial,
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
  
  static void showInterstitialIfNeeded() {
    if (!AdConfig.showInterstitial) return;
    
    _actionCount++;
    if (_actionCount >= AdConfig.interstitialInterval) {
      _actionCount = 0;
      _interstitialAd?.show();
      loadInterstitial();
    }
  }
  
  static void dispose() {
    _interstitialAd?.dispose();
  }
}
```

### banner_ad_widget.dart

```dart
class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    if (!AdConfig.showBanner) {
      return const SizedBox.shrink();
    }
    
    return SizedBox(
      height: 50,
      child: AdWidget(
        ad: BannerAd(
          adUnitId: AdUnits.banner,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: const BannerAdListener(),
        ),
      ),
    );
  }
}
```

## Critérios de Aceitação

- [x] Google AdMob configurado
- [x] Banner implementado
- [x] Interstitial implementado
- [x] Consentimento LGPD
- [x] Consentimento GDPR
- [x] Não interrompe fluxos críticos
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Regras (ADR-035)

- [x] Nunca interromper compartilhamento NFC
- [x] Nunca interromper geração de QR Code
- [x] Nunca interromper importação de contatos
- [x] Nunca interromper autenticação biométrica
- [x] Nunca interromper edição do cartão

## Checklist

- [x] Google AdMob configurado
- [x] Banner implementado
- [x] Interstitial implementado
- [x] Consentimento LGPD
- [x] Consentimento GDPR
- [x] Não interrompe fluxos críticos
- [x] Build funcionando
- [x] Testes passando
- [x] Lints OK
- [x] Cobertura > 80%
- [x] CHANGELOG atualizado

## Próxima Sprint

Sprint 14 — Testing
