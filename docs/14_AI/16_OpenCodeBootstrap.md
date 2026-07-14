# OpenCode Bootstrap — VCardSmart

## Visão Geral

Configuração para inicializar o OpenCode com o contexto do projeto.

## Bootstrap

### Instrução

```
Leia README.md.

Execute bootstrap.

Valide ambiente.

Leia AI_CONTEXT.md.

Crie plano.

Implemente a primeira Sprint.
```

## Context Pack

### Arquivos

| Arquivo | Descrição |
|---------|-----------|
| README.md | Visão geral |
| AI_CONTEXT.md | Contexto para IA |
| PROJECT_CONTEXT.md | Contexto do projeto |
| PRODUCT_REQUIREMENTS.md | Requisitos |
| ARCHITECTURE.md | Arquitetura |
| DATA_MODEL.md | Modelo de dados |
| ACCEPTANCE.md | Critérios de aceitação |

### Ordem

```
README.md
  ↓
AI_CONTEXT.md
  ↓
PROJECT_CONTEXT.md
  ↓
PRODUCT_REQUIREMENTS.md
  ↓
ARCHITECTURE.md
  ↓
DATA_MODEL.md
  ↓
ACCEPTANCE.md
```

## Configuração

### .opencode/config.json

```json
{
  "project": "VCardSmart",
  "version": "1.0.0",
  "context": [
    "README.md",
    "AI_CONTEXT.md",
    "PROJECT_CONTEXT.md",
    "PRODUCT_REQUIREMENTS.md",
    "ARCHITECTURE.md",
    "DATA_MODEL.md",
    "ACCEPTANCE.md"
  ],
  "rules": [
    "Nunca quebre arquitetura",
    "Nunca altere documentação sem ADR",
    "Sempre execute testes",
    "Sempre atualize CHANGELOG"
  ]
}
```

## Workflow

### 1. Inicialização

```
OpenCode lê context pack
OpenCode entende projeto
OpenCode está pronto
```

### 2. Receber Tarefa

```
Humano envia tarefa
OpenCode valida contexto
OpenCode confirma entendimento
```

### 3. Implementar

```
OpenCode planeja
OpenCode implementa
OpenCode testa
OpenCode documenta
```

### 4. Entregar

```
OpenCode entrega código
Humano revisa
Humano aprova
```

## Restrições

### OpenCode

- Segue padrões do projeto
- Não quebra arquitetura
- Não altera documentação sem ADR
- Executa testes antes de commit
- Atualiza CHANGELOG

### Humano

- Revisa código
- Aprova mudanças
- Define prioridades
- Mantém contexto
