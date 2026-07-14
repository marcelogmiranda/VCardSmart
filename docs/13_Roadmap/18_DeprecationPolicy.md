# Política de Depreciação — VCardSmart

## Princípios

### 1. Suporte por Uma Versão Principal

Toda funcionalidade removida deverá permanecer suportada por pelo menos uma versão principal.

### 2. Migração Obrigatória Documentada

Toda depreciação deverá incluir documentação de migração.

### 3. Comunicação Antecipada

Usuários deverão ser informados com antecedência sobre depreciações.

## Processo

### 1. Anúncio

| Ação | Prazo |
|------|-------|
| Anúncio de depreciação | 3 meses antes |
| Aviso no app | 1 mês antes |
| Lembrete final | 1 semana antes |

### 2. Período de Transição

| Ação | Prazo |
|------|-------|
| Funcionalidade depreciada | Mantida por 1 versão principal |
| Avisos contínuos | Durante todo o período |
| Migração assistida | Disponível |

### 3. Remoção

| Ação | Prazo |
|------|-------|
| Remoção da funcionalidade | Após período de transição |
| Documentação atualizada | Imediatamente |
| Comunicação final | Imediatamente |

## Formato de Comunicação

### Anúncio

```markdown
## Aviso de Depreciação

**Funcionalidade**: [Nome da funcionalidade]
**Data de remoção**: [Data]
**Versão de remoção**: [Versão]
**Motivo**: [Motivo]
**Alternativa**: [Funcionalidade substituta]

### O que fazer

1. [Passo 1]
2. [Passo 2]
3. [Passo 3]

### Mais informações

- [Link para documentação]
- [Link para migração]
```

### Aviso no App

```markdown
⚠️ A funcionalidade [nome] será removida em [data].

Por favor, utilize [alternativa] até lá.

Mais informações: [link]
```

## Exemplos

### Exemplo 1: Formato de Exportação

| Campo | Valor |
|-------|-------|
| Funcionalidade | Exportação em formato X |
| Depreciada na versão | 2.0 |
| Removida na versão | 3.0 |
| Alternativa | Exportação em formato Y |
| Motivo | Formato X descontinuado |

### Exemplo 2: Integração

| Campo | Valor |
|-------|-------|
| Funcionalidade | Integração com serviço Z |
| Depreciada na versão | 3.0 |
| Removida na versão | 4.0 |
| Alternativa | Integração com serviço W |
| Motivo | Serviço Z encerrou operações |

## Casos Especiais

### Bugs Críticos

| Situação | Ação |
|----------|------|
| Bug de segurança | Remoção imediata |
| Bug de dados | Remoção imediata |
| Bug de performance | Remoção após correção |

### Mudanças de Plataforma

| Situação | Ação |
|----------|------|
| API descontinuada | Remoção após migração |
| Biblioteca abandonada | Substituição planejada |
| Mudança de plataforma | Adaptação |

## Documentação

### Obrigatória

| Documento | Conteúdo |
|-----------|----------|
| Motivo | Por que foi depreciado |
| Alternativa | O que usar no lugar |
| Migração | Como migrar |
| Timeline | Datas importantes |

### Localização

| Documento | Local |
|-----------|-------|
| CHANGELOG | Registro da depreciação |
| Docs | Documentação de migração |
| Blog | Post de anúncio |
| In-app | Aviso ao usuário |

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Tempo de aviso | > 3 meses |
| Migração bem-sucedida | > 90% |
| Reclamações | < 5% |
| Satisfação | > 4.0 |

## ADR Relacionados

| ADR | Descrição |
|-----|-----------|
| ADR-037 | Evolução sem Refatoração |
| ADR-038 | Premium como Extensão |
