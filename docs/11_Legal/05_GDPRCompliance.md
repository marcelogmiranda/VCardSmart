# Conformidade GDPR — VCardSmart

## Princípios (Art. 5)

### 1. Lawfulness (Licitude)

> Dados tratados de forma lícita.

**Implementação**:
- Consentimento explícito
- Legítimo interesse para funcionamento
- Sem tratamento ilegal

### 2. Fairness (Lealdade)

> Dados tratados de forma leal.

**Implementação**:
- Transparência total
- Sem práticas enganosas
- Controle do usuário

### 3. Transparency (Transparência)

> Dados tratados de forma transparente.

**Implementação**:
- Política de privacidade clara
- Fluxos transparentes
- Feedback em tempo real

### 4. Purpose Limitation (Finalidade)

> Dados coletados para finalidade específica.

**Implementação**:
- Dados usados apenas para perfil
- Sem uso para marketing
- Sem uso para analytics

### 5. Data Minimization (Minimização)

> Apenas dados necessários coletados.

**Implementação**:
- Campos opcionais claramente marcados
- Sem dados de telemetria
- Sem metadados

### 6. Accuracy (Precisão)

> Dados precisos e atualizados.

**Implementação**:
- Edição permitida a qualquer momento
- Validação em tempo real
- Controle do usuário

### 7. Integrity (Integridade)

> Dados protegidos contra alterações.

**Implementação**:
- Criptografia AES-256
- Validação de integridade
- Versionamento

### 8. Confidentiality (Confidencialidade)

> Dados protegidos contra acesso não autorizado.

**Implementação**:
- Criptografia em repouso
- Secure Storage para chaves
- Autenticação opcional

## Dados Pessoais

### Categorias

| Categoria | Dados | Finalidade |
|-----------|-------|------------|
| Identificação | Nome | Perfil |
| Contato | Email, Telefone | Perfil |
| Profissional | Empresa | Perfil |
| Técnicos | Configurações | Funcionamento |

### Base Legal

| Finalidade | Base Legal (Art. 6) |
|------------|---------------------|
| Funcionamento | Legítimo interesse (6, f) |
| Perfil | Consentimento (6, a) |
| Compartilhamento | Consentimento (6, a) |
| Importação contatos | Consentimento (6, a) |

## Direitos do Titular

### Art. 15 — Acesso

> Direito de obter confirmação do tratamento.

**Implementação**:
- Dados sempre acessíveis
- Exportação disponível

### Art. 16 — Retificação

> Direito de corrigir dados inexatos.

**Implementação**:
- Edição permitida
- Validação em tempo real

### Art. 17 — Eliminação

> Direito de supressão de dados.

**Implementação**:
- Exclusão completa
- Confirmação obrigatória
- Irreversível

### Art. 18 — Limitação

> Direito de limitar tratamento.

**Implementação**:
- Sem tratamento automatizado
- Sem perfilamento

### Art. 20 — Portabilidade

> Direito de receber dados em formato estruturado.

**Implementação**:
- Exportação em vCard
- Exportação em JSON

### Art. 21 — Oposição

> Direito de se opor ao tratamento.

**Implementação**:
- Sem tratamento baseado em interesse legítimo para marketing
- Sem perfilamento

### Art. 22 — Decisões Automatizadas

> Direito de não ser submetido a decisões automatizadas.

**Implementação**:
- Sem decisões automatizadas
- Sem perfilamento

## Segurança (Art. 32)

### Medidas Técnicas

- Criptografia AES-256
- Secure Storage
- Autenticação opcional
- Sem logs em produção

### Medidas Organizacionais

- Política de privacidade
- Termos de uso
- Checklist de conformidade

## Transferência Internacional

### Regra

- ❌ Sem transferência internacional
- ❌ Sem servidores
- ❌ Sem nuvem

### Exceção

- Google Mobile Ads (opt-in)

## Encarregado (Art. 37)

### Não Aplicável

- Sem tratamento de dados em escala
- Sem monitoramento sistemático
- Sem dados sensíveis em larga escala

## Relatório de Impacto (Art. 35)

### Avaliação

- Risco baixo: Dados locais apenas
- Sem processamento automatizado
- Sem perfilamento
- Sem compartilhamento

### Conclusão

- Não há necessidade de DPIA (Data Protection Impact Assessment)

## Conformidade

### Checklist

- [x] Princípios respeitados
- [x] Base legal definida
- [x] Direitos do titular implementados
- [x] Segurança garantida
- [x] Política de privacidade publicada
- [x] Termos de uso publicados

### Auditoria

- Revisão anual
- Atualização conforme necessidade
- Documentação mantida
