# Codex Bootstrap — VCardSmart

## Visão Geral

Configuração para inicializar Codex com o contexto do projeto.

## Configuração

### codex.json

```json
{
  "project": "VCardSmart",
  "version": "1.0.0",
  "instructions": "Leia README.md. Execute bootstrap. Valide ambiente. Implemente a primeira Sprint.",
  "context_files": [
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

## Instruções

### Bootstrap

```
Leia README.md.

Execute bootstrap:
flutter pub get
flutter analyze
flutter test

Valide ambiente:
flutter doctor

Leia AI_CONTEXT.md.

Crie plano para Sprint 1.

Implemente a primeira feature.
```

### Feature

```
Implemente a feature [nome].

1. Leia documentação
2. Crie Entity
3. Crie Model
4. Crie Repository
5. Crie UseCase
6. Crie Provider
7. Crie Widget
8. Crie Page
9. Crie Testes
10. Atualize CHANGELOG
```

### Bug

```
Corrija o bug [descrição].

1. Identifique causa
2. Implemente correção
3. Execute testes
4. Atualize CHANGELOG
```

## Workflow

### 1. Inicialização

```
Codex lê configuração
Codex lê context pack
Codex valida ambiente
Codex está pronto
```

### 2. Tarefa

```
Humano envia tarefa
Codex valida contexto
Codex cria plano
Codex confirma com humano
```

### 3. Implementação

```
Codex implementa
Codex testa
Codex documenta
Codex entrega
```

### 4. Revisão

```
Humano revisa
Humano aprova ou solicita mudanças
Codex ajusta
Humano aprova final
```

## Restrições

### Codex

- Segue padrões do projeto
- Não quebra arquitetura
- Não altera documentação sem ADR
- Executa testes
- Atualiza CHANGELOG

### Segurança

- Não acessa secrets
- Não altera configurações de segurança
- Não comprometer privacidade
