# Prompts de Refatoração — VCardSmart

## Refatoração Geral

### Refatorar Componente

```
Refatore [componente] mantendo:

1. API pública
   - Mesmos métodos
   - Mesmos parâmetros
   - Mesmos tipos de retorno

2. Arquitetura
   - Mesma separação de camadas
   - Mesmos padrões
   - Mesmas dependências

3. Testes
   - Todos os testes passando
   - Cobertura mantida
   - Novos testes se necessário

4. Performance
   - Sem regressão
   - Melhorias se possível

5. Documentação
   - CHANGELOG atualizado
   - README atualizado se necessário
```

### Extrair Método

```
Extraia o método [nome] de [classe/método].

Mantendo:
- Mesma funcionalidade
- Mesmos parâmetros
- Mesmo retorno
- Testes passando
```

### Extrair Classe

```
Extraia a classe [nome] de [arquivo].

Mantendo:
- Mesma funcionalidade
- Mesmos métodos
- Mesmas dependências
- Testes passando
```

### Renomear

```
Renomeie [antigo] para [novo] em [escopo].

Mantendo:
- Mesma funcionalidade
- Todos os usos atualizados
- Testes passando
```

## Refatoração por Camada

### Refatorar Entity

```
Refatore esta Entity:

[class Entity]

Mantendo:
- Imutabilidade
- Campos
- Métodos
- Validações
```

### Refatorar Model

```
Refatore este Model:

[class Model]

Mantendo:
- fromJson/toJson
- toDomain/fromDomain
- Validações
```

### Refatorar Repository

```
Refatore este Repository:

[class Repository]

Mantendo:
- Interface
- Métodos
- Tratamento de erros
```

### Refatorar UseCase

```
Refatore este UseCase:

[class UseCase]

Mantendo:
- Single Responsibility
- Tratamento de erros
- Documentação
```

### Refatorar Provider

```
Refatore este Provider:

[código Provider]

Mantendo:
- Estado
- Ciclo de vida
- Erros tratados
```

### Refatorar Widget

```
Refatore este Widget:

[código Widget]

Mantendo:
- Construção
- Interação
- Acessibilidade
```

## Refatoração por Motivo

### Melhorar Performance

```
Refatore [componente] para melhorar performance.

Problemas:
- [problema 1]
- [problema 2]

Soluções:
- [solução 1]
- [solução 2]

Mantendo:
- Funcionalidade
- Testes
- Documentação
```

### Melhorar Legibilidade

```
Refatore [componente] para melhorar legibilidade.

Problemas:
- [problema 1]
- [problema 2]

Soluções:
- [solução 1]
- [solução 2]

Mantendo:
- Funcionalidade
- Testes
- Documentação
```

### Melhorar Manutenibilidade

```
Refatore [componente] para melhorar manutenibilidade.

Problemas:
- [problema 1]
- [problema 2]

Soluções:
- [solução 1]
- [solução 2]

Mantendo:
- Funcionalidade
- Testes
- Documentação
```

### Reduzir Acoplamento

```
Refatore [componente] para reduzir acoplamento.

Problemas:
- [problema 1]
- [problema 2]

Soluções:
- [solução 1]
- [solução 2]

Mantendo:
- Funcionalidade
- Testes
- Documentação
```

## Checklist de Refatoração

### Antes

- [ ] Backup do código
- [ ] Testes passando
- [ ] Cobertura atual
- [ ] Performance atual

### Durante

- [ ] Manter API pública
- [ ] Manter arquitetura
- [ ] Manter testes
- [ ] Manter documentação

### Depois

- [ ] Testes passando
- [ ] Cobertura mantida
- [ ] Performance mantida
- [ ] Lints OK
- [ ] CHANGELOG atualizado
