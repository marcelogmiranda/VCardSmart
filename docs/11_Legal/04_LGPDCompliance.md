# Conformidade LGPD — VCardSmart

## Base Legal

### Consentimento

> O tratamento de dados pessoais é baseado no consentimento explícito do titular.

**Implementação**:
- Confirmação explícita para todas as ações
- Registro de consentimento
- Possibilidade de revogação

### Legítimo Interesse

> Tratamento necessário para o funcionamento do aplicativo.

**Implementação**:
- Dados locais para funcionamento
- Sem processamento automatizado
- Sem perfilamento

## Direitos do Titular

### 1. Acesso (Art. 18, I)

> O titular tem direito de acessar seus dados.

**Implementação**:
- Dados sempre acessíveis no dispositivo
- Visualização completa do perfil
- Exportação em formatos padrão

### 2. Correção (Art. 18, III)

> O titular pode corrigir seus dados.

**Implementação**:
- Edição permitida a qualquer momento
- Validação em tempo real
- Feedback imediato

### 3. Exclusão (Art. 18, VI)

> O titular pode excluir seus dados.

**Implementação**:
- Exclusão completa dos dados
- Confirmação obrigatória
- Irreversível

### 4. Portabilidade (Art. 18, V)

> O titular pode transferir seus dados.

**Implementação**:
- Exportação em vCard
- Exportação em JSON
- Formatos padrão

### 5. Informação (Art. 18, VII)

> O titular deve ser informado sobre o tratamento.

**Implementação**:
- Política de privacidade clara
- Fluxos transparentes
- Feedback em tempo real

### 6. Consentimento (Art. 18, IX)

> O consentimento deve ser livre e informado.

**Implementação**:
- Sempre explícito
- Sempre informado
- Sempre granular
- Sempre revogável

## Dados Tratados

### Dados Pessoais

| Dado | Finalidade | Base Legal |
|------|------------|------------|
| Nome | Perfil | Consentimento |
| Email | Perfil | Consentimento |
| Telefone | Perfil | Consentimento |
| Empresa | Perfil | Consentimento |
| Configurações | Funcionamento | Legítimo interesse |

### Dados Sensíveis

| Dado | Tratamento |
|------|------------|
| Biometria | Não coletada (apenas verificação local) |
| Dados de saúde | Não coletados |
| Dados financeiros | Não coletados |

## Processamento

### Local

- Todos os dados são processados localmente
- Sem envio para servidores
- Sem processamento automatizado
- Sem perfilamento

### Segurança

- Criptografia AES-256
- Secure Storage para chaves
- Autenticação opcional
- Sem logs em produção

## Retenção

### Política

- Dados mantidos enquanto o app estiver instalado
- Remoção completa na desinstalação
- Sem backup em nuvem
- Sem sincronização

### Exclusão

```
Usuário solicita exclusão
    ↓
Confirmação obtida
    ↓
Dados excluídos do Hive
    ↓
Chaves excluídas do Secure Storage
    ↓
Aplicativo limpo
```

## Compartilhamento

### Regras

- ❌ Não compartilhamos com terceiros
- ❌ Não vendemos dados
- ❌ Não enviamos para servidores

### Exceção

- **Google Mobile Ads**: Uso de identificador de publicidade (opt-in)

## Encarregado

- Não aplicável (sem tratamento de dados em escala)
- Canal de suporte disponível

## Relatório de Impacto

### Avaliação

- Risco baixo: Dados locais apenas
- Sem processamento automatizado
- Sem perfilamento
- Sem compartilhamento

### Conclusão

- Não há necessidade de Relatório de Impacto à Proteção de Dados (RIPD)

## Conformidade

### Checklist

- [x] Base legal definida
- [x] Direitos do titular implementados
- [x] Dados minimizados
- [x] Finalidade clara
- [x] Segurança garantida
- [x] Retenção definida
- [x] Política de privacidade publicada

### Auditoria

- Revisão anual
- Atualização conforme necessidade
- Documentação mantida
