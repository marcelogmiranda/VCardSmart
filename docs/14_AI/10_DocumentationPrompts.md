# Prompts de Documentação — VCardSmart

## Documentação Automática

### Atualizar CHANGELOG

```
Atualize o CHANGELOG com as seguintes mudanças:

## [Versão] - YYYY-MM-DD

### Adicionado
- [funcionalidade 1]
- [funcionalidade 2]

### Alterado
- [alteração 1]
- [alteração 2]

### Corrigido
- [correção 1]
- [correção 2]

### Removido
- [remoção 1]
- [remoção 2]
```

### Atualizar README

```
Atualize o README com as seguintes informações:

## Nova Feature

[descrição da feature]

### Como usar

[instruções]

### Configuração

[configurações]
```

### Criar ADR

```
Crie um ADR para a seguinte decisão:

## ADR-[número] - [título]

### Contexto

[contexto]

### Decisão

[decisão]

### Consequências

**Positivas**:
- [consequência 1]
- [consequência 2]

**Negativas**:
- [consequência 1]
- [consequência 2]

### Status

Aceito

### Data

YYYY-MM-DD
```

### Criar Documentação de Feature

```
Crie documentação para a feature [nome]:

## Feature: [nome]

### Descrição

[descrição]

### Funcionalidades

- [funcionalidade 1]
- [funcionalidade 2]

### Como usar

[instruções]

### Configuração

[configurações]

### Limitações

[limitações]
```

## Documentação por Tipo

### Documentação de API

```
Documente a API do [componente]:

## [Nome do Método]

### Descrição

[descrição]

### Parâmetros

| Parâmetro | Tipo | Obrigatório | Descrição |
|-----------|------|-------------|-----------|
| [param] | [tipo] | [sim/não] | [descrição] |

### Retorno

| Tipo | Descrição |
|------|-----------|
| [tipo] | [descrição] |

### Exemplo

[código de exemplo]
```

### Documentação de Modelo

```
Documente o modelo [nome]:

## [Nome do Modelo]

### Campos

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| [campo] | [tipo] | [sim/não] | [descrição] |

### Métodos

| Método | Descrição |
|--------|-----------|
| [método] | [descrição] |

### Exemplo

[código de exemplo]
```

### Documentação de Provider

```
Documente o provider [nome]:

## [Nome do Provider]

### Tipo

[tipo do provider]

### Estado

| Campo | Tipo | Descrição |
|-------|------|-----------|
| [campo] | [tipo] | [descrição] |

### Métodos

| Método | Descrição |
|--------|-----------|
| [método] | [descrição] |

### Uso

[código de uso]
```

## Formato de Documentação

### Padrão

```markdown
# [Título]

## Visão Geral

[visão geral]

## Funcionalidades

- [funcionalidade 1]
- [funcionalidade 2]

## Como usar

[instruções]

## Configuração

[configurações]

## Limitações

[limitações]

## Exemplos

[exemplos]
```

## Checklist

- [ ] CHANGELOG atualizado
- [ ] README atualizado
- [ ] ADR criado (se necessário)
- [ ] Documentação da feature criada
- [ ] API documentada
- [ ] Modelos documentados
- [ ] Providers documentados
- [ ] Exemplos adicionados
