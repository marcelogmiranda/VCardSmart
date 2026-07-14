# Ads Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Plugin

| Propriedade | Valor |
|-------------|-------|
| **Plugin** | google_mobile_ads |
| **Plataformas** | Android, iOS |
| **Tipo** | Freemium |

---

## Tipos de Anúncio

| Tipo | Formato | Uso |
|------|---------|-----|
| **Banner** | Retangular | Parte inferior da tela |
| **Interstitial** | Tela cheia | Entre telas (com cuidado) |
| **Reward** | Opcional | Não utilizado em V1 |

---

## Regras de Exibição

### NUNCA mostrar anúncios durante:

| Tela | Motivo |
|------|--------|
| Cadastro | Experiência de primeiro acesso |
| Compartilhamento NFC | Foco na transmissão |
| Leitura QR | Experiência contínua |
| Envio QR | Foco na transmissão |
| Biometria | Segurança sem distração |
| Configurações | Interface limpa |
| Importação | Foco na importação |

### SEMPRE mostrar anúncios em:

| Tela | Posição |
|------|---------|
| Tela principal | Banner inferior |
| Lista de contatos | Banner inferior |
| Sobre | Banner inferior |

---

## Implementação

### Service
```dart
class AdsService {
  static const _bannerAdUnitId = 'ca-app-pub-xxx/yyy';
  static const _interstitialAdUnitId = 'ca-app-pub-xxx/zzz';

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
  }

  Future<void> showInterstitialAd() async {
    final interstitialAd = await InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
    );
    await interstitialAd.show();
  }
}
```

---

## Controle de Exibição

```dart
class AdsController extends StateNotifier<bool> {
  AdsController() : super(true); // Anúncios ativos

  void disableAds() {
    state = false;
  }

  void enableAds() {
    state = true;
  }
}
```

---

## Políticas das Lojas

| Loja | Política | Status |
|------|----------|--------|
| Google Play | AdMob policy | ✅ |
| App Store | Apple guidelines | ✅ |

---

## Documentos Relacionados

- [14_AdsArchitecture.md](./14_AdsArchitecture.md)
- [14_Monetization.md](../03_Product/14_Monetization.md)
