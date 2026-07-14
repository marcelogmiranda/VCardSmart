# AI Overview — VCardSmart

## Visão Geral

Este documento descreve como IA é utilizada no desenvolvimento do VCardSmart.

## Objetivo

Usar IA para:
- Acelerar desenvolvimento
- Manter consistência
- Garantir qualidade
- Automatizar tarefas repetitivas

## Princípios

### 1. IA como Assistente

IA auxilia, mas não substitui decisões humanas.

### 2. Sempre Supervisionado

Todo código gerado por IA deve ser revisado.

### 3. Seguro por Padrão

IA segue restrições de segurança e arquitetura.

### 4. Documentado

Toda ação de IA deve ser rastreável.

## Fluxo de Trabalho

```
Humano define tarefa
      ↓
IA recebe contexto
      ↓
IA gera solução
      ↓
Humano revisa
      ↓
IA implementa
      ↓
Testes executados
      ↓
Humano aprova
```

## Context Pack

### O que a IA recebe

| Documento | Descrição |
|-----------|-----------|
| README | Visão geral do projeto |
| PROJECT_CONTEXT | Contexto do projeto |
| PRODUCT_REQUIREMENTS | Requisitos do produto |
| ARCHITECTURE | Arquitetura |
| DATA_MODEL | Modelo de dados |
| ACCEPTANCE | Critérios de aceitação |
| TASK | Tarefa específica |

### Ordem de Leitura

```
README
  ↓
PROJECT_CONTEXT
  ↓
PRODUCT_REQUIREMENTS
  ↓
ARCHITECTURE
  ↓
DATA_MODEL
  ↓
ACCEPTANCE
  ↓
TASK
```

## Tipos de Tarefas

### Criação de Feature

1. Ler toda documentação
2. Implementar apenas a feature solicitada
3. Criar: Entity, Model, Repository, UseCases, Providers, Widgets, Pages, Tests, Localization, Documentation
4. Executar análise e testes
5. Atualizar CHANGELOG

### Correção de Bug

1. Corrigir apenas os erros
2. Não refatorar
3. Não alterar APIs
4. Não alterar documentação
5. Não instalar novas dependências

### Refatoração

1. Manter API pública
2. Manter arquitetura
3. Manter testes
4. Manter cobertura
5. Manter performance
6. Manter documentação

### Revisão

1. Verificar SOLID
2. Verificar Clean Architecture
3. Verificar Riverpod
4. Verificar GoRouter
5. Verificar Hive
6. Verificar Lints
7. Verificar testes
8. Verificar performance
9. Verificar segurança

## Restrições

### IA nunca poderá

- Adicionar dependências sem aprovação
- Alterar arquitetura sem aprovação
- Alterar banco sem aprovação
- Alterar modelo de dados sem aprovação
- Alterar ADRs sem aprovação

### IA sempre deverá

- Consultar Acceptance Criteria
- Executar testes antes do commit
- Atualizar CHANGELOG
- Seguir padrões existentes
- Manter compatibilidade

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Redução de tempo | > 30% |
| Qualidade do código | > 4.0/5.0 |
| Cobertura de testes | > 80% |
| Bugs em produção | < 5/mês |
