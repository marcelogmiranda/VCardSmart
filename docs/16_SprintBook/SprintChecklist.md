# Sprint Checklist — VCardSmart

## Checklist Global

### Antes de Cada Sprint

- [ ] Documentação da sprint lida
- [ ] Pré-requisitos atendidos
- [ ] Dependências identificadas
- [ ] Ambiente pronto

### Durante Cada Sprint

- [ ] Arquitetura respeitada
- [ ] SOLID seguido
- [ ] Riverpod pattern
- [ ] GoRouter navigation
- [ ] Hive storage
- [ ] Naming conventions
- [ ] Error handling
- [ ] Null safety

### Ao Final de Cada Sprint

- [ ] flutter analyze (0 warnings)
- [ ] flutter test (todos passando)
- [ ] flutter test --coverage (> 80%)
- [ ] CHANGELOG atualizado
- [ ] README atualizado (se necessário)
- [ ] ADR criado (se necessário)
- [ ] Code review aprovado
- [ ] Merge na branch principal

## Checklist por Feature

### Entity

- [ ] Imutável
- [ ] Campos corretos
- [ ] Construtor const
- [ ] Equatable (se necessário)

### Model

- [ ] fromJson/toJson
- [ ] toDomain/fromDomain
- [ ] Hive adapter
- [ ] Validações

### Repository Interface

- [ ] Abstrato
- [ ] Métodos definidos
- [ ] Retornos corretos

### Repository Implementation

- [ ] Implementa interface
- [ ] DataSource injetado
- [ ] Tratamento de erros
- [ ] Async/await

### UseCase

- [ ] Single Responsibility
- [ ] Um método call
- [ ] Tratamento de erros
- [ ] Documentação

### Provider

- [ ] StateNotifier
- [ ] Estado gerenciado
- [ ] Ciclo de vida
- [ ] Erros tratados

### Widget

- [ ] Stateless (quando possível)
- [ ] Parâmetros corretos
- [ ] Key definida
- [ ] Acessibilidade

### Page

- [ ] ConsumerWidget
- [ ] Loading state
- [ ] Error state
- [ ] Empty state

### Tests

- [ ] Unit tests
- [ ] Widget tests
- [ ] Golden tests (se necessário)
- [ ] Integration tests (se necessário)
- [ ] Cobertura > 80%

## Checklist de Qualidade

### Código

- [ ] Lints OK
- [ ] Sem code smells
- [ ] Código legível
- [ ] Código manutenível

### Performance

- [ ] Sem rebuilds desnecessários
- [ ] Sem memória leaks
- [ ] Sem operações bloqueantes
- [ ] Imagens otimizadas

### Segurança

- [ ] Criptografia implementada
- [ ] Input sanitizado
- [ ] Sem logs sensíveis
- [ ] Sem vulnerabilidades

### Documentação

- [ ] Funções documentadas
- [ ] Classes documentadas
- [ ] Exemplos (se necessário)
- [ ] CHANGELOG

## Checklist de Deploy

### Build

- [ ] Build de release funcionando
- [ ] Assinatura configurada
- [ ] Versão atualizada

### Store

- [ ] Screenshots atualizados
- [ ] Descrição atualizada
- [ ] Classificação indicativa OK
- [ ] Políticas OK

### Pós-Release

- [ ] Monitoramento ativo
- [ ] Crash reports monitorados
- [ ] Reviews monitorados
