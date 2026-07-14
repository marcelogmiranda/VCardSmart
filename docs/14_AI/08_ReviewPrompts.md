# Prompts de Revisão — VCardSmart

## Revisão Automática

### Checklist de Revisão

```
Revise o código implementado.

Verifique:

1. SOLID
   - Single Responsibility
   - Open/Closed
   - Liskov Substitution
   - Interface Segregation
   - Dependency Inversion

2. Clean Architecture
   - Domain não depende de Data
   - Data não depende de Presentation
   - Presentation depende de Domain

3. Riverpod
   - Providers bem definidos
   - Estado gerenciado corretamente
   - Sem estado mutável

4. GoRouter
   - Rotas configuradas
   - Navegação correta
   - Parâmetros passados

5. Hive
   - Models com fromJson/toJson
   - Datasources abstratos
   - Criptografia implementada

6. Lints
   - Sem warnings
   - Sem errors
   - Todos os rules passando

7. Testes
   - Unit tests passando
   - Widget tests passando
   - Cobertura > 80%

8. Performance
   - Sem rebuilds desnecessários
   - Sem memória leaks
   - Sem operações bloqueantes

9. Segurança
   - Criptografia implementada
   - Sem logs sensíveis
   - Input sanitizado
```

### Revisão de Código

```
Revise o seguinte código:

[paste do código]

Verifique:
- Legibilidade
- Manutenibilidade
- Performance
- Segurança
- Padrões
```

### Revisão de Arquitetura

```
Revise a arquitetura da feature:

[descrição da feature]

Verifique:
- Separação de responsabilidades
- Dependências
- Acoplamento
- Coesão
```

## Revisão por Tipo

### Revisão de Entity

```
Revise esta Entity:

[class Entity]

Verifique:
- Imutabilidade
- Campos corretos
- Métodos necessários
- Validações
```

### Revisão de Model

```
Revise este Model:

[class Model]

Verifique:
- fromJson/toJson
- toDomain/fromDomain
- Validações
- Tratamento de null
```

### Revisão de Repository

```
Revise este Repository:

[class Repository]

Verifique:
- Implementa interface
- Tratamento de erros
- Assincronismo
- Clean Architecture
```

### Revisão de UseCase

```
Revise este UseCase:

[class UseCase]

Verifique:
- Single Responsibility
- Tratamento de erros
- Documentação
- Testes
```

### Revisão de Provider

```
Revise este Provider:

[código Provider]

Verifique:
- Estado gerenciado
- Ciclo de vida
- Erros tratados
- Performance
```

### Revisão de Widget

```
Revise este Widget:

[código Widget]

Verifique:
- Construção
- Interação
- Acessibilidade
- Performance
- Testes
```

### Revisão de Page

```
Revise esta Page:

[código Page]

Verifique:
- Navegação
- Estado
- Erros
- Loading
- Empty state
```

## Revisão de Segurança

```
Revise o código em busca de vulnerabilidades:

Verifique:
- SQL Injection
- XSS
- CSRF
- Secrets expostos
- Logs sensíveis
- Input validation
- Encryption
```

## Revisão de Performance

```
Revise o código em busca de problemas de performance:

Verifique:
- Rebuilds desnecessários
- Operações bloqueantes
- Memória leaks
- Queries ineficientes
- Imagens não otimizadas
```

## Formato de Relatório

```markdown
# Relatório de Revisão

## Resumo
- [ ] Aprovado
- [ ] Aprovado com ressalvas
- [ ] Rejeitado

## Problemas Encontrados

### Críticos
- [problema 1]
- [problema 2]

### Médios
- [problema 1]
- [problema 2]

### Baixos
- [problema 1]
- [problema 2]

## Recomendações
- [recomendação 1]
- [recomendação 2]

## Aprovações
- [x] Código
- [x] Testes
- [x] Documentação
```
