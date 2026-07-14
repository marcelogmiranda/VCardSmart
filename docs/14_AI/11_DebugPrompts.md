# Prompts de Debug — VCardSmart

## Debug Geral

### Corrigir Bug

```
Corrija o seguinte bug:

## Bug Report

### Descrição

[descrição do bug]

### Passos para reproduzir

1. [passo 1]
2. [passo 2]
3. [passo 3]

### Comportamento esperado

[comportamento esperado]

### Comportamento atual

[comportamento atual]

### Erro

[erro ou stack trace]

## Restrições

- Não refatore
- Não altere APIs
- Não altere documentação
- Não instale novas dependências
```

### Corrigir Erro de Compilação

```
Corrija o erro de compilação:

## Erro

[erro de compilação]

## Código

[código com erro]

## Restrições

- Não altere funcionalidade
- Não altere API pública
```

### Corrigir Erro de Runtime

```
Corrija o erro de runtime:

## Erro

[erro de runtime]

## Stack Trace

[stack trace]

## Código

[código relacionado]

## Restrições

- Não altere funcionalidade
- Não altere API pública
```

## Debug por Tipo

### Bug de UI

```
Corrija o bug de UI:

## Problema

[descrição do problema]

## Screenshots

[screenshots]

## Dispositivo

- Modelo: [modelo]
- OS: [versão]
- Tamanho da tela: [tamanho]

## Restrições

- Manter design
- Manter acessibilidade
```

### Bug de Performance

```
Corrija o bug de performance:

## Problema

[descrição do problema]

## Métricas

- Tempo de carregamento: [tempo]
- FPS: [fps]
- Memória: [memória]

## Restrições

- Manter funcionalidade
- Manter testes
```

### Bug de Navegação

```
Corrija o bug de navegação:

## Problema

[descrição do problema]

## Rotas

[rotas envolvidas]

## Restrições

- Manter fluxo
- Manter parâmetros
```

### Bug de Estado

```
Corrija o bug de estado:

## Problema

[descrição do problema]

## Estado

[estado atual]

## Restrições

- Manter ciclo de vida
- Manter reatividade
```

### Bug de Dados

```
Corrija o bug de dados:

## Problema

[descrição do problema]

## Dados

[dados envolvidos]

## Restrições

- Manter integridade
- Manter criptografia
```

## Debug de Testes

### Teste Falhando

```
Corrija o teste falhando:

## Teste

[nome do teste]

## Erro

[erro do teste]

## Código Testado

[código sendo testado]

## Restrições

- Manter cobertura
- Manter asserts
```

### Teste Instável

```
Corrija o teste instável:

## Teste

[nome do teste]

## Problema

[descrição do problema]

## Frequência

[frequência do problema]

## Restrições

- Manter cobertura
- Manter asserts
```

## Ferramentas

### Flutter Debug

```bash
# Hot reload
r

# Hot restart
R

# Inspect widget
p

# Toggle debug paint
P

# Toggle performance overlay
o

# Show depth tree
d
```

### Dart Debug

```dart
// Breakpoint
debugger();

// Print
print('debug: $variable');

// Assert
assert(condition, 'message');
```

## Checklist

- [ ] Bug reproduzido
- [ ] Causa identificada
- [ ] Correção implementada
- [ ] Testes passando
- [ ] Não quebrou nada
- [ ] CHANGELOG atualizado
