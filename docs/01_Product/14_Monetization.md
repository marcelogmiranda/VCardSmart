# Monetization

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estratégia de Monetização

O VCardSmart adota modelo **freemium**:
- **Versão Gratuita:** Anúncios não intrusivos via AdMob
- **Versão Premium:** Remoção de anúncios + funcionalidades exclusivas

---

## Versão Gratuita

### Anúncios (AdMob)

| Regra | Descrição |
|-------|-----------|
| Nunca mostrar durante cadastro | Tela de primeiro acesso livre de anúncios |
| Nunca mostrar durante compartilhamento | NFC, QR Code, vCard sem interrupção |
| Nunca mostrar durante leitura QR | Experiência contínua |
| Nunca mostrar durante NFC | Foco na transmissão |
| Nunca mostrar durante biometria | Segurança sem distração |
| Nunca mostrar durante configurações | Interface limpa |

### Onde os Anúncios Aparecem

| Tela | Anúncio | Posição |
|------|---------|---------|
| Tela principal | Banner | Parte inferior |
| Lista de cartões recebidos | Interstitial (leve) | Entre itens |
| Sobre | Banner | Parte inferior |

### Restrições de Anúncios

| Restrição | Motivo |
|-----------|--------|
| Sem interstitials agressivos | Experiência do usuário |
| Sem anúncios em tela cheia | Não intrusivo |
| Sem anúncios de áudio | Silencioso |
| Sem anúncios de vídeo longo | Rápido |

---

## Versão Premium

### Funcionalidades Exclusivas

| # | Funcionalidade | Descrição |
|---|---------------|-----------|
| P01 | Remoção de anúncios | Experiência limpa |
| P02 | Múltiplos cartões | Criar vários perfis profissionais |
| P03 | Templates premium | Designs exclusivos |
| P04 | Exportar vCard | Compartilhar como arquivo |
| P05 | Estatísticas locais | Quantas vezes o cartão foi compartilhado |
| P06 | Suporte prioritário | Atendimento diferenciado |

### Preço Estimado

| Plataforma | Preço | Modelo |
|------------|-------|--------|
| Android | R$ 19,90 | Compra única |
| iOS | R$ 19,90 | Compra única |

*Valores sujeitos a ajuste baseado em pesquisa de mercado.*

---

## Fluxo de Compra Premium

```
Tela principal → Opção Premium → Confirmação → Pagamento → Desbloqueio
```

### Critérios de Aceitação
- ✅ Compra via Google Play / App Store
- ✅ Desbloqueio imediato após pagamento
- ✅ Persistência entre sessões
- ✅ Sem necessidade de login
- ✅ Sem servidor (validação local)

---

## Projeção de Receita

| Cenário | Downloads | Conversão | Receita Mensal |
|---------|-----------|-----------|----------------|
| Conservador | 1.000 | 2% | R$ 398 |
| Moderado | 5.000 | 3% | R$ 2.985 |
| Otimista | 20.000 | 5% | R$ 19.900 |

*Projeções baseadas em dados de mercado para apps de nicho.*

---

## Dependências de Monetização

| Dependência | Tipo | Status |
|------------|------|--------|
| google_mobile_ads | Plugin AdMob | Estável |
| in_app_purchase | Plugin compras | Estável |

---

## Documentos Relacionados

- [04_PRD.md](./04_PRD.md)
- [13_Privacy.md](./13_Privacy.md)
- [17_VersionRoadmap.md](./17_VersionRoadmap.md)
