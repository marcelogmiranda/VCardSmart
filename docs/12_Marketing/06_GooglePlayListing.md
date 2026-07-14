# Google Play Listing — VCardSmart

## Informações Básicas

### Título

```
VCardSmart - Cartão de Visitas Digital Offline
```

### Descrição Curta

```
Cartão de visitas digital offline. QR Code, NFC, vCard. Sem login, sem nuvem, sem rastreamento.
```

### Categoria

- **Principal**: Business
- **Secundária**: Productivity

### Preço

- **Preço**: Gratuito
- **Compras internas**: Não

### Classificação

- **Classificação indicativa**: Livre para todos
- **Conteúdo**: Sem restrições

## Descrição Completa

```markdown
VCardSmart - O cartão de visitas inteligente que respeita sua privacidade.

**100% Offline**
Compartilhe seu contato profissional sem necessidade de internet. Sem login, sem criação de conta, sem nuvem.

**Múltiplas Formas de Compartilhamento**
- QR Code: Gere seu QR Code personalizado
- NFC: Compartilhe tocando os dispositivos
- vCard: Exporte no formato padrão

**Privacidade Total**
- Sem coleta de dados
- Sem analytics
- Sem rastreamento
- Dados criptografados localmente

**Segurança**
- Autenticação biométrica
- Proteção por PIN
- Criptografia AES-256

**Multilíngue**
Disponível em 8 idiomas: Português, English, Español, Français, Italiano, Deutsch, 日本語, 中文.

**Material Design 3**
Interface moderna, intuitiva e profissional.

**Para Quem?**
- Empresários
- Profissionais liberais
- Consultores
- Freelancers
- Participantes de eventos de networking

Baixe agora e comece a compartilhar seu contato profissional de forma segura!
```

## Permissões

### Câmera

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

**Justificativa**: Necessária para escanear QR Code.

### NFC

```xml
<uses-feature android:name="android.hardware.nfc" android:required="false" />
```

**Justificativa**: Necessária para compartilhar via NFC.

### Biometria

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

**Justificativa**: Necessária para autenticação do perfil.

### Contatos

```xml
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
```

**Justificativa**: Necessária para importar/exportar contatos da agenda.

## Data Safety

### Coleta de Dados

| Dado | Coletado | Compartilhado |
|------|----------|---------------|
| Dados de perfil | Não | Não |
| Dados de contato | Não | Não |
| Dados de uso | Não | Não |
| Dados de dispositivo | Não | Não |

### Segurança

| Medida | Implementada |
|--------|--------------|
| Criptografia em trânsito | N/A (offline) |
| Criptografia em repouso | Sim |
| Você pode deletar dados | Sim |
| Dev follows families policy | Não aplicável |

## Screenshots

### Especificações

| Loja | Resolução | Proporção |
|------|-----------|-----------|
| Telefone | 1080x1920 | 9:16 |
| Tablet 7" | 1080x1920 | 9:16 |
| Tablet 10" | 1080x1920 | 9:16 |

### Conteúdo

| Posição | Conteúdo | Foco |
|---------|----------|------|
| 1 | Tela inicial / Perfil | Apresentação |
| 2 | QR Code | Compartilhamento |
| 3 | NFC | Compartilhamento |
| 4 | Importação | Uso |
| 5 | Tema Escuro | Visual |

## Feature Graphic

### Especificações

| Campo | Valor |
|-------|-------|
| Resolução | 1024x500 |
| Formato | PNG ou JPG |
| Tamanho | Máximo 1MB |

### Mensagem

> Privacidade. Offline. QR Code. NFC.

### Elementos

- Logo VCardSmart
- Ícones representativos
- Fundo gradiente

## Ícone

### Especificações

| Campo | Valor |
|-------|-------|
| Resolução | 512x512 |
| Formato | PNG |
| Tamanho | Máximo 1MB |

### Regras

- Fundo sólido
- Sem texto
- Sem bordas
- Reconhecimento imediato

## Classificação Indicativa

### Questionário

| Pergunta | Resposta |
|----------|----------|
| Violência | Não |
| Sexo | Não |
| Drogas | Não |
| Linguagem | Não |
| Assédio | Não |
| Compartilhamento de dados | Não |
| Localização | Não |
| Compras | Não |

### Resultado

**Livre para todos os públicos**

## Restrições

### Dispositivos

| Restrição | Valor |
|-----------|-------|
| Android mínimo | 5.0 (API 21) |
| Android alvo | 14 (API 34) |
| Arquitetura | arm64-v8a, armeabi-v7a |

### Funcionalidades

| Funcionalidade | Requerida |
|----------------|-----------|
| NFC | Não |
| Câmera | Sim |
| Biometria | Não |

## Contato

### Email

```
contato@vcardsmart.app
```

### Website

```
https://vcardsmart.app
```

### Política de Privacidade

```
https://vcardsmart.app/privacy
```

## Tags

### Tags Recomendadas

- cartão digital
- business card
- vcard
- qr code
- nfc
- networking
- contato
- offline
- privacidade
- contacts
- professional

## Status

### Status Atual

- [ ] Pronto para publicação
- [ ] Revisão jurídica
- [ ] Revisão técnica
- [ ] Aprovação final
