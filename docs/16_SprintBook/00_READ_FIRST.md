# LEIA PRIMEIRO — VCardSmart Sprint Book

## Instrução para IA

```
Este é o Sprint Book do VCardSmart.

LEIA TODOS OS DOCUMENTOS ANTES DE COMEÇAR.

CADA SPRINT É INDEPENDENTE.

NÃO AVANCE PARA A PRÓXIMA SPRINT ANTES DE COMPLETAR A ATUAL.

SEMPRE EXECUTE TESTES ANTES DE COMMIT.

SEMPRE ATUALIZE DOCUMENTAÇÃO.

SEMPRE PARE AO TERMINAR.
```

## Ordem de Leitura

```
1. docs/01_Product/PROJECT_CONSTITUTION.md
2. docs/14_AI/AI_CONTEXT.md
3. docs/02_Architecture/01_ArchitectureOverview.md
4. docs/03_DataModel/01_DataModelOverview.md
5. docs/01_Product/11_AcceptanceCriteria.md
6. docs/16_SprintBook/00_READ_FIRST.md (este arquivo)
7. docs/16_SprintBook/01_DevelopmentRules.md
8. docs/16_SprintBook/02_DefinitionOfReady.md
9. docs/16_SprintBook/03_DefinitionOfDone.md
10. Sprint atual
```

## Regras Obrigatórias

### 1. Nunca Quebre Arquitetura

```
Toda feature deve seguir Clean Architecture.
Domain não depende de Data.
Data não depende de Presentation.
Presentation depende de Domain.
```

### 2. Sempre Execute Testes

```
cd app
flutter analyze
flutter test
flutter test --coverage
```

### 3. Sempre Atualize Documentação

```
CHANGELOG.md
README.md (se necessário)
ADR (se necessário)
```

### 4. Nunca Avance

```
Complete a sprint atual.
Aguarde revisão.
Só então avance.
```

## Fluxo de Trabalho

```
1. Leia documentação
2. Planeje a sprint
3. Implemente
4. Execute flutter analyze
5. Execute flutter test
6. Verifique cobertura
7. Atualize documentação
8. Faça commit
9. Crie pull request
10. Aguarde revisão
```

## Prompt para Início de Sprint

```
Leia:
- docs/01_Product/PROJECT_CONSTITUTION.md
- docs/14_AI/AI_CONTEXT.md
- docs/02_Architecture/01_ArchitectureOverview.md
- docs/01_Product/11_AcceptanceCriteria.md
- Sprint atual

Implemente somente esta Sprint.
Não avance para a próxima.
Não altere arquitetura.
Execute todos os testes.
Atualize documentação.
Pare ao terminar.
```

## Prompt para Fim de Sprint

```
Faça uma auditoria.

Liste:
- Arquivos criados
- Arquivos alterados
- Cobertura
- Lints
- Pendências
- Riscos
- Melhorias
- Próxima Sprint
```

## Checklist Global

- [ ] Arquitetura respeitada
- [ ] SOLID seguido
- [ ] Riverpod pattern
- [ ] GoRouter navigation
- [ ] Hive storage
- [ ] Testes passando
- [ ] Lints OK
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado
- [ ] ADR (quando necessário)
- [ ] Cobertura > 80%
- [ ] Performance OK
