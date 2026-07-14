# Monetização — VCardSmart

## Modelo de Monetização

### Estratégia

**Freemium**: Versão gratuita com anúncios + Versão premium sem anúncios e funcionalidades extras.

### Princípios

1. **Gratuito primeiro**: Funcionalidades core sempre gratuitas
2. **Anúncios éticos**: Não intrusivos, não em fluxos críticos
3. **Premium acessível**: Preço justo para valor entregue
4. **Sem coleta**: Não coletar dados para monetizar

## Versão Gratuita

### Funcionalidades

| Funcionalidade | Disponível |
|----------------|------------|
| Criar perfil | ✅ |
| Compartilhar via QR Code | ✅ |
| Compartilhar via NFC | ✅ |
| Importar contatos | ✅ |
| Tema claro/escuro | ✅ |
| Biometria | ✅ |
| PIN | ✅ |
| Multilíngue | ✅ |

### Anúncios

| Tipo | Posição | Frequência |
|------|---------|------------|
| Banner | Rodapé | Sempre visível |
| Interstitial | Entre telas | Moderado |
| Rewarded | Opcional | Apenas se usuário quiser |

### Regras de Anúncios

| Regra | Descrição |
|-------|-----------|
| ADR-035 | Nunca interromper compartilhamento NFC |
| ADR-035 | Nunca interromper geração de QR Code |
| ADR-035 | Nunca interromper importação de contatos |
| ADR-035 | Nunca interromper autenticação biométrica |
| ADR-035 | Nunca interromper edição do cartão |

## Versão Premium

### Preço

| Período | Preço |
|---------|-------|
| Mensal | R$ 9,90 |
| Anual | R$ 79,90 (33% desconto) |
| Vitalício | R$ 149,90 (opcional) |

### Funcionalidades Exclusivas

| Funcionalidade | Descrição |
|----------------|-----------|
| Sem anúncios | Experiência completamente limpa |
| Múltiplos cartões | Vários perfis profissionais |
| Backup criptografado | Backup seguro na nuvem |
| Exportações avançadas | PDF, HTML, múltiplos formatos |
| Personalização ampliada | Temas, cores, fontes |
| Suporte prioritário | Resposta mais rápida |
| Atualizações antecipadas | Acesso a novidades primeiro |

### Paywall

#### Regras

1. **Nunca** bloquear funcionalidades core
2. **Sempre** mostrar valor do premium
3. **Nunca** usar dark patterns
4. **Sempre** permitir cancelamento fácil

#### Locais

| Local | Oportunidade |
|-------|--------------|
| Tela de configurações | Alta |
| Após compartilhar | Média |
| Ao criar segundo perfil | Alta |
| Ao exportar PDF | Média |

## Google Play Billing

### Configuração

```kotlin
// Implementação
class BillingManager {
    fun launchPurchaseFlow(productId: String) {
        // Google Play Billing
    }
    
    fun acknowledgePurchase(purchase: Purchase) {
        // Acknowledge
    }
}
```

### SKUs

| SKU | Tipo | Preço |
|-----|------|-------|
| premium_monthly | Subscription | R$ 9,90/mês |
| premium_yearly | Subscription | R$ 79,90/ano |
| premium_lifetime | OneTime | R$ 149,90 |

## Apple In-App Purchase

### Configuração

```swift
// Implementação
class IAPManager {
    func purchaseProduct(productId: String) {
        // Apple IAP
    }
    
    func verifyReceipt() {
        // Receipt validation
    }
}
```

### Products

| Product ID | Tipo | Preço |
|------------|------|-------|
| premium_monthly | Auto-Renewable | R$ 9,90/mês |
| premium_yearly | Auto-Renewable | R$ 79,90/ano |
| premium_lifetime | Non-Consumable | R$ 149,90 |

## Anúncios (Google AdMob)

### Configuração

```kotlin
// Implementação
class AdManager {
    fun showBanner(adView: AdView) {
        // Banner ad
    }
    
    fun showInterstitial(activity: Activity) {
        // Interstitial ad
    }
    
    fun showRewarded(activity: Activity) {
        // Rewarded ad
    }
}
```

### Unit IDs

| Tipo | Android | iOS |
|------|---------|-----|
| Banner | ca-app-pub-XXX/YYY | ca-app-pub-XXX/YYY |
| Interstitial | ca-app-pub-XXX/YYY | ca-app-pub-XXX/YYY |
| Rewarded | ca-app-pub-XXX/YYY | ca-app-pub-XXX/YYY |

### Regras

1. **Nunca** em fluxos críticos
2. **Sempre** moderado
3. **Nunca** intrusivo
4. **Sempre** com opção de remover (premium)

## Projeções de Receita

### Mês 1

| Fonte | Receita Estimada |
|-------|------------------|
| Anúncios | R$ 500 |
| Premium | R$ 100 |
| **Total** | **R$ 600** |

### Mês 6

| Fonte | Receita Estimada |
|-------|------------------|
| Anúncios | R$ 3.000 |
| Premium | R$ 1.000 |
| **Total** | **R$ 4.000** |

### Mês 12

| Fonte | Receita Estimada |
|-------|------------------|
| Anúncios | R$ 10.000 |
| Premium | R$ 5.000 |
| **Total** | **R$ 15.000** |

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Conversão free → premium | > 5% |
| Retenção premium | > 90% |
| ARPU | > R$ 0,50 |
| LTV | > R$ 10,00 |

### Monitoramento

| Métrica | Frequência |
|---------|------------|
| Receita | Diária |
| Conversão | Semanal |
| Retenção | Mensal |
| LTV | Mensal |

## Processo

### 1. Implementação

- Integrar Google Play Billing
- Integrar Apple IAP
- Integrar Google AdMob
- Testar em sandbox

### 2. Validação

- Testar compras
- Testar anúncios
- Validar receipt
- Verificar conformidade

### 3. Lançamento

- Ativar anúncios
- Ativar premium
- Monitorar métricas
- Ajustar conforme necessário
