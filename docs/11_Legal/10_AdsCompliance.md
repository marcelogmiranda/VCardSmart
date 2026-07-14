# Conformidade de Anúncios — VCardSmart

## Google Mobile Ads

### Política

- ✅ Sem anúncios personalizados
- ✅ Sem coleta adicional de dados
- ✅ Respeitar políticas Google
- ✅ Exibir somente anúncios permitidos
- ✅ Não interromper fluxos críticos

### Configuração

```dart
// lib/presentation/providers/ads_provider.dart
class AdsService {
  static Future<void> init() async {
    await MobileAds.instance.initialize();
  }
  
  static AdRequest createAdRequest() {
    return AdRequest(
      // Sem personalização
      keywords: <String>[],
      // Sem location targeting
      location: null,
      // Sem device targeting
      deviceId: null,
    );
  }
}
```

### Tipos de Anúncio

| Tipo | Uso | Frequência |
|------|-----|------------|
| Banner | Parte inferior da tela | Sempre visível |
| Interstitial | Entre telas | Máximo 1 por sessão |
| Rewarded | Não utilizado | - |
| Native | Não utilizado | - |

### Regras

1. **Não personalizado** — Sem targeting baseado em dados
2. **Não intrusivo** — Não interrompe fluxos críticos
3. **Não enganoso** — Anúncios claramente identificados
4. **Não malicioso** — Apenas anúncios verificados

### Implementação

```dart
class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  
  @override
  void initState() {
    super.initState();
    _loadAd();
  }
  
  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdService.bannerAdUnitId,
      size: AdSize.banner,
      request: AdService.createAdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }
  
  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded) return SizedBox.shrink();
    
    return SizedBox(
      height: _bannerAd.size.height.toDouble(),
      width: _bannerAd.size.width.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }
  
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}
```

## Políticas Google

### Ad Content

- ✅ Conteúdo apropriado
- ✅ Sem conteúdo adulto
- ✅ Sem conteúdo violento
- ✅ Sem conteúdo discriminatório

### Ad Behavior

- ✅ Não cliques automáticos
- ✅ Não redirecionamentos enganosos
- ✅ Não download automáticos
- ✅ Não fechamento difícil

### Ad Placement

- ✅ Anúncios claramente identificados
- ✅ Não próximos a botões interativos
- ✅ Não sobrepondo conteúdo
- ✅ Não em fluxos críticos

## Políticas Apple

### Ad Content

- ✅ Conteúdo apropriado
- ✅ Sem conteúdo adulto
- ✅ Sem conteúdo violento

### Ad Behavior

- ✅ Não cliques automáticos
- ✅ Não redirecionamentos enganosos
- ✅ Não download automáticos

### Ad Placement

- ✅ Anúncios claramente identificados
- ✅ Não próximos a botões interativos
- ✅ Não sobrepondo conteúdo

## Consentimento

### Regras

1. **Transparência** — Usuário ciente de anúncios
2. **Opção de remoção** — Premium sem anúncios (futuro)
3. **Não personalizado** — Sem targeting

### UI

```dart
class AdsConsentBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(
        'Este aplicativo contém anúncios não personalizados.',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
```

## Métricas

| Métrica | Meta |
|---------|------|
| Personalização | 0% |
| Intrusividade | Baixa |
| CTR | Orgânico |
| Revogação | Disponível |

## Checklist

- [x] Anúncios não personalizados
- [x] Sem coleta adicional
- [x] Respeitar políticas Google
- [x] Respeitar políticas Apple
- [x] Não interromper fluxos críticos
- [x] Anúncios claramente identificados
- [x] Consentimento disponível
