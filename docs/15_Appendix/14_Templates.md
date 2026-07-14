# Templates — VCardSmart

## Feature Template

```markdown
# Feature: [Nome]

## Visão Geral

[Descrição da feature]

## Acceptance Criteria

- [ ] Critério 1
- [ ] Critério 2
- [ ] Critério 3

## Componentes

### Entity

```dart
class [Nome] {
  // campos
}
```

### Model

```dart
class [Nome]Model {
  // campos
  factory [Nome]Model.fromJson(Map<String, dynamic> json) {}
  Map<String, dynamic> toJson() {}
}
```

### Repository

```dart
abstract class [Nome]Repository {
  // métodos
}

class Local[Nome]Repository implements [Nome]Repository {
  // implementação
}
```

### UseCase

```dart
class [Nome]UseCase {
  // implementação
}
```

### Provider

```dart
final [nome]Provider = StateNotifierProvider<...>(...);
```

### Widget

```dart
class [Nome]Widget extends StatelessWidget {
  // implementação
}
```

### Page

```dart
class [Nome]Page extends ConsumerWidget {
  // implementação
}
```

## Testes

- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests

## Documentação

- [ ] CHANGELOG
- [ ] README (se necessário)
- [ ] ADR (se necessário)
```

## ADR Template

```markdown
# ADR-[número] - [Título]

## Status

Aceito

## Data

YYYY-MM-DD

## Contexto

[Descrição do contexto]

## Decisão

[Descrição da decisão]

## Consequências

### Positivas

- [consequência 1]
- [consequência 2]

### Negativas

- [consequência 1]
- [consequência 2]

## Alternativas Consideradas

### Alternativa 1

[Descrição]

### Alternativa 2

[Descrição]

## Referências

- [link 1]
- [link 2]
```

## Bug Report Template

```markdown
# Bug Report

## Descrição

[Descrição do bug]

## Passos para Reproduzir

1. [passo 1]
2. [passo 2]
3. [passo 3]

## Comportamento Esperado

[Comportamento esperado]

## Comportamento Atual

[Comportamento atual]

## Screenshots

[screenshots]

## Ambiente

- Dispositivo: [modelo]
- OS: [versão]
- App: [versão]

## Prioridade

- [ ] Crítica
- [ ] Alta
- [ ] Média
- [ ] Baixa
```

## Sprint Template

```markdown
# Sprint [número]

## Período

[início] - [fim]

## Objetivo

[Objetivo da sprint]

## Tarefas

### Backlog

- [ ] Tarefa 1
- [ ] Tarefa 2

### Em Progresso

- [ ] Tarefa 3

### Concluído

- [x] Tarefa 4

## Métricas

| Métrica | Meta | Real |
|---------|------|------|
| Velocity | X | Y |
| Bugs | X | Y |
| Features | X | Y |

## Retrospectiva

### O que funcionou

- [item 1]

### O que melhorar

- [item 1]

### Ações

- [ação 1]
```

## Release Template

```markdown
# Release [versão]

## Data

YYYY-MM-DD

## Novidades

- [novidade 1]
- [novidade 2]

## Melhorias

- [melhoria 1]
- [melhoria 2]

## Correções

- [correção 1]
- [correção 2]

## Breaking Changes

- [breaking change 1]

## Upgrade Guide

[instruções de upgrade]

## Download

- [Google Play](link)
- [App Store](link)
```

## PR Template

```markdown
# Pull Request

## Descrição

[Descrição da mudança]

## Tipo

- [ ] Feature
- [ ] Bug Fix
- [ ] Refactoring
- [ ] Docs
- [ ] Test

## Checklist

- [ ] Código segue padrões
- [ ] Testes passando
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado
- [ ] Lints OK
- [ ] Performance OK
- [ ] Segurança OK

## Screenshots

[screenshots]

## Related Issues

- [issue 1]
```

## Commit Template

```
[tipo](escopo): [descrição]

[corpo opcional]

[footer opcional]

Tipos:
- feat: nova feature
- fix: correção de bug
- docs: documentação
- style: formatação
- refactor: refatoração
- test: testes
- chore: manutenção
```
