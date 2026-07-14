# Modelo de Ameaças — VCardSmart

## Visão Geral

Identificação das principais ameaças à segurança e privacidade do aplicativo.

## Ameaças Identificadas

### 1. Perda do Dispositivo

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Dispositivo perdido ou esquecido |
| Impacto | Alto |
| Probabilidade | Média |
| Dados em risco | Todos os dados locais |

**Mitigação**:
- Biometria opcional
- PIN opcional
- Timeout de bloqueio
- Ocultar conteúdo no app switcher

### 2. Roubo do Dispositivo

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Dispositivo roubado |
| Impacto | Alto |
| Probabilidade | Baixa |
| Dados em risco | Todos os dados locais |

**Mitigação**:
- Biometria
- PIN com tentativas limitadas
- Timeout agressivo
- Lock automático

### 3. Acesso Indevido

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Pessoa não autorizada acessa o app |
| Impacto | Alto |
| Probabilidade | Média |
| Dados em risco | Perfil, contatos |

**Mitigação**:
- Autenticação obrigatória
- Tentativas limitadas
- Timeout de sessão
- Bloqueio automático

### 4. Captura de Tela

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Captura de tela dos dados |
| Impacto | Médio |
| Probabilidade | Média |
| Dados em risco | Dados visíveis na tela |

**Mitigação**:
- Flag de segurança (Android quando suportado)
- Ocultar conteúdo sensível
- Alerta ao usuário

### 5. Compartilhamento Acidental

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Compartilhamento não intencional |
| Impacto | Médio |
| Probabilidade | Média |
| Dados em risco | Dados selecionados |

**Mitigação**:
- Confirmação obrigatória
- Resumo antes de compartilhar
- Seleção granular

### 6. Permissões Excessivas

| Aspecto | Detalhe |
|---------|---------|
| Descrição | App solicita permissões desnecessárias |
| Impacto | Médio |
| Probabilidade | Baixa |
| Dados em risco | Dados acessados pelas permissões |

**Mitigação**:
- Permissões sob demanda
- Justificativa clara
- Sem permissões preventivas

### 7. QR Code Malicioso

| Aspecto | Detalhe |
|---------|---------|
| Descrição | QR Code contendo dados maliciosos |
| Impacto | Médio |
| Probabilidade | Baixa |
| Dados em risco | Integridade dos dados |

**Mitigação**:
- Validação de todos os dados
- Sanitização de input
- Limites de tamanho
- Rejeição de formato inválido

### 8. vCard Inválido

| Aspecto | Detalhe |
|---------|---------|
| Descrição | vCard com dados malformados |
| Impacto | Médio |
| Probabilidade | Baixa |
| Dados em risco | Integridade dos dados |

**Mitigação**:
- Validação RFC 6350
- Sanitização de campos
- Limites de tamanho
- Rejeição de campos desconhecidos

### 9. NFC Inválido

| Aspecto | Detalhe |
|---------|---------|
| Descrição | Tag NFC com dados inválidos |
| Impacto | Médio |
| Probabilidade | Baixa |
| Dados em risco | Integridade dos dados |

**Mitigação**:
- Validação de payload
- Versionamento
- Confirmação antes de salvar
- Sanitização

## Matriz de Risco

```
Impacto
Alto   │  Perda   │  Roubo  │ Acesso
Médio  │ Captura  │ QR/ NFC │ vCard
Baixo  │          │         │
       └──────────┴─────────┴──────────
         Baixa    Média     Alta
                Probabilidade
```

## ADRs Relacionadas

- **ADR-025**: Security by Design
- **ADR-028**: Zero Trust Local
