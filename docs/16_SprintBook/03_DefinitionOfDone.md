# Definition of Done — VCardSmart

## Visão Geral

Uma Sprint está completa quando todos os critérios abaixo são atendidos.

## Critérios

### 1. Código

- [ ] Todo o código implementado
- [ ] Lints passando (0 warnings)
- [ ] Sem code smells
- [ ] Código revisado
- [ ] Merge na branch principal

### 2. Testes

- [ ] Unit tests passando
- [ ] Widget tests passando
- [ ] Integration tests passando (se necessário)
- [ ] Cobertura > 80%
- [ ] Testes significativos

### 3. Documentação

- [ ] CHANGELOG atualizado
- [ ] README atualizado (se necessário)
- [ ] ADR criado (se necessário)
- [ ] Comentários adequados

### 4. Qualidade

- [ ] Performance OK
- [ ] Segurança OK
- [ ] Acessibilidade OK
- [ ] Compatibilidade OK

### 5. Deploy

- [ ] Build de release funcionando
- [ ] Assinatura OK
- [ ] Versão atualizada
- [ ] CI/CD passando

### 6. Revisão

- [ ] Code review aprovado
- [ ] QA aprovado
- [ ] PO aprovado

## Checklist Detalhado

### Código

- [ ] Segue padrões do projeto
- [ ] Segue Clean Architecture
- [ ] Segue SOLID
- [ ] Segue naming conventions
- [ ] Sem dependências circulares
- [ ] Tratamento de erros
- [ ] Null safety

### Testes

- [ ] Happy path testado
- [ ] Edge cases testados
- [ ] Error cases testados
- [ ] Mocks configurados
- [ ] Assertions corretas

### Documentação

- [ ] Funções documentadas
- [ ] Classes documentadas
- [ ] Parâmetros documentados
- [ ] Retornos documentados
- [ ] Exemplos (se necessário)

### Performance

- [ ] Sem rebuilds desnecessários
- [ ] Sem memória leaks
- [ ] Sem operações bloqueantes
- [ ] Imagens otimizadas
- [ ] Lazy loading

### Segurança

- [ ] Criptografia implementada
- [ ] Input sanitizado
- [ ] Sem logs sensíveis
- [ ] Sem vulnerabilidades
- [ ] Autenticação segura

## Validação Final

### Antes de Merge

- [ ] Todos os critérios atendidos
- [ ] Build passando
- [ ] Testes passando
- [ ] Review aprovado

### Após Merge

- [ ] Deploy automático
- [ ] Monitoramento ativo
- [ ] Métricas acompanhadas

## Formato de Entrega

### Pull Request

```
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
