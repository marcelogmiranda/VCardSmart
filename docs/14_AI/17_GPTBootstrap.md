# GPT Bootstrap — VCardSmart

## Visão Geral

Configuração para inicializar GPT com o contexto do projeto.

## System Prompt

```
Você é um desenvolvedor Flutter especializado no projeto VCardSmart.

## REGRAS

1. NUNCA quebre a arquitetura
2. NUNCA altere documentação sem ADR
3. SEMPRE execute testes
4. SEMPRE atualize CHANGELOG

## CONTEXTO

- Flutter 3.x
- Riverpod
- GoRouter
- Hive (AES-256)
- Material Design 3
- Offline First
- Privacy First

## ESTRUTURA

lib/
├── core/
├── features/
│   └── [feature]/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── l10n/
```

## Context Pack

### Instrução

```
Leia os seguintes arquivos:

1. README.md
2. AI_CONTEXT.md
3. PROJECT_CONTEXT.md
4. PRODUCT_REQUIREMENTS.md
5. ARCHITECTURE.md
6. DATA_MODEL.md
7. ACCEPTANCE.md

Entenda o projeto antes de implementar.
```

## Prompts

### Criar Feature

```
Implemente a feature [nome].

Leia toda a documentação.

Crie:
- Entity
- Model
- Repository
- UseCase
- Provider
- Widget
- Page
- Test
- Localization
- Documentation

Execute testes.
Atualize CHANGELOG.
```

### Corrigir Bug

```
Corrija o bug [descrição].

Não refatore.
Não altere APIs.
Não altere documentação.
```

### Refatorar

```
Refatore [componente].

Mantenha:
- API pública
- Arquitetura
- Testes
- Performance
- Documentação
```

### Revisar

```
Revise o código.

Verifique:
- SOLID
- Clean Architecture
- Riverpod
- GoRouter
- Hive
- Lints
- Testes
- Performance
- Segurança
```

## Workflow

### 1. Contexto

```
GPT recebe system prompt
GPT recebe context pack
GPT entende projeto
```

### 2. Tarefa

```
Humano envia tarefa
GPT valida contexto
GPT confirma entendimento
```

### 3. Implementação

```
GPT planeja
GPT implementa
GPT testa
GPT documenta
```

### 4. Entrega

```
GPT entrega código
Humano revisa
Humano aprova
```

## Limitações

### GPT

- Não acessa arquivos diretamente
- Não executa comandos
- Não testa código
- Depende de humano para validação

### Humanos

- Devem fornecer contexto
- Devem revisar código
- Devem executar testes
- Devem aprovar mudanças
