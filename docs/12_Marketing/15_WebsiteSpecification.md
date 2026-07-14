# Especificação do Website — VCardSmart

## Visão Geral

Site institucional para apresentar o aplicativo, fornecer informações e direcionar para as lojas.

## Objetivos

1. Apresentar o VCardSmart
2. Fornecer informações sobre privacidade e segurança
3. Direcionar para download nas lojas
4. Fornecer suporte e documentação
5. Estabelecer credibilidade

## Estrutura

### Páginas

| Página | URL | Descrição |
|--------|-----|-----------|
| Home | / | Página principal |
| Privacy | /privacy | Política de Privacidade |
| Terms | /terms | Termos de Uso |
| Support | /support | Central de Suporte |
| FAQ | /faq | Perguntas Frequentes |
| Download | /download | Links de download |
| Contact | /contact | Contato |

## Home

### Layout

```
+--------------------------------------------------+
|  HEADER                                          |
|  Logo | Home | Privacy | Terms | Support | Download |
+--------------------------------------------------+
|  HERO                                            |
|  Título | Subtítulo | Botão Download            |
+--------------------------------------------------+
|  FEATURES                                        |
|  Privacidade | Offline | QR Code | NFC           |
+--------------------------------------------------+
|  HOW IT WORKS                                    |
|  Passo 1 | Passo 2 | Passo 3                    |
+--------------------------------------------------+
|  TESTIMONIALS                                    |
|  Depoimentos                                     |
+--------------------------------------------------+
|  DOWNLOAD                                        |
|  Google Play | App Store                         |
+--------------------------------------------------+
|  FOOTER                                          |
|  Copyright | Links | Social                      |
+--------------------------------------------------+
```

### Seções

#### Hero

- **Título**: VCardSmart
- **Subtítulo**: O cartão de visitas inteligente que respeita sua privacidade.
- **CTA**: Baixe agora

#### Features

| Feature | Ícone | Descrição |
|---------|-------|-----------|
| Privacidade | Shield | Sem coleta de dados |
| Offline | Cloud off | Funciona sem internet |
| QR Code | QR Code | Compartilhe por QR |
| NFC | NFC | Compartilhe por toque |

#### How It Works

| Passo | Título | Descrição |
|-------|--------|-----------|
| 1 | Crie seu perfil | Adicione seus dados |
| 2 | Compartilhe | Use QR Code ou NFC |
| 3 | Conecte-se | Receba contatos |

#### Download

- **Google Play**: Botão direcionamento
- **App Store**: Botão direcionamento

## Privacy

### Conteúdo

- Política de Privacidade completa
- Dados coletados (nenhum)
- Direitos do usuário
- Contato

## Terms

### Conteúdo

- Termos de Uso
- Condições de uso
- Limitações
- Isenções

## Support

### Conteúdo

- Canal de suporte
- FAQ
- Sugestões
- Melhorias
- Relatar problema

## FAQ

### Perguntas

| Pergunta | Resposta |
|----------|----------|
| O que é VCardSmart? | Cartão de visitas digital offline |
| Como funciona? | Crie perfil, compartilhe via QR/NFC |
| É seguro? | Sim, dados criptografados localmente |
| Precisa de internet? | Não, 100% offline |
| Precisa de conta? | Não, sem login |

## Download

### Links

| Loja | URL |
|------|-----|
| Google Play | https://play.google.com/store/apps/details?id=br.com.vcardsmart.app |
| App Store | https://apps.apple.com/app/vcardsmart/idXXXXXXXXXX |

## Contact

### Formulário

| Campo | Tipo |
|-------|------|
| Nome | Texto |
| Email | Email |
| Assunto | Select |
| Mensagem | Textarea |

## Design

### Paleta de Cores

| Elemento | Cor |
|----------|-----|
| Fundo | #FFFFFF |
| Texto | #212121 |
| Destaque | #1976D2 |
| Secundário | #757575 |

### Tipografia

| Elemento | Fonte |
|----------|-------|
| Títulos | Roboto Bold |
| Corpo | Roboto Regular |

### Responsividade

| Breakpoint | Layout |
|------------|--------|
| Mobile | < 768px |
| Tablet | 768px - 1024px |
| Desktop | > 1024px |

## SEO

### Meta Tags

```html
<title>VCardSmart - Offline Digital Business Card</title>
<meta name="description" content="O cartão de visitas inteligente que respeita sua privacidade. 100% offline, QR Code, NFC, vCard.">
<meta name="keywords" content="cartão digital, business card, vcard, qr code, nfc, offline, privacidade">
```

### Open Graph

```html
<meta property="og:title" content="VCardSmart">
<meta property="og:description" content="O cartão de visitas inteligente que respeita sua privacidade.">
<meta property="og:image" content="https://vcardsmart.app/og-image.png">
<meta property="og:url" content="https://vcardsmart.app">
```

## Hospedagem

### Provedor

| Campo | Valor |
|-------|-------|
| Provedor | GitHub Pages / Netlify |
| SSL | Sim |
| CDN | Sim |
| Domínio | vcardsmart.app |

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Visitantes únicos | > 1.000/mês |
| Pageviews | > 5.000/mês |
| Taxa de rejeição | < 50% |
| Conversão download | > 5% |

## Manutenção

### Processo

1. Atualizar conteúdo conforme necessário
2. Monitorar métricas
3. Atualizar links de download
4. Manter SEO atualizado
