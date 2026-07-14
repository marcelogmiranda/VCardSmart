# Plano de Testes — VCardSmart

## Fluxo do Processo

```
Planejamento → Execução → Registro → Correção → Reteste → Homologação → Release
```

## 1. Planejamento

### Escopo
- Todas as funcionalidades do aplicativo
- Múltiplas plataformas (Android/iOS)
- Múltiplos tamanhos de tela
- Cenários online e offline

### Prioridades
| Prioridade | Descrição | Prazo |
|------------|-----------|-------|
| P0 - Crítico | Perfil, QR Code, NFC, vCard | 100% antes de Release |
| P1 - Alto | Agenda, Configurações, Biometria | 100% antes de Release |
| P2 - Médio | Tema, Idioma, Anúncios | 90% antes de Release |
| P3 - Baixo | Detalhes visuais, edge cases | 80% antes de Release |

### Recursos
- Desenvolvedores: Testes unitários e de widget
- QA: Testes de integração e E2E
- Product Owner: Testes de aceitação

## 2. Execução

### Ambientes
- **Dev**: Testes locais durante desenvolvimento
- **CI**: Testes automáticos a cada commit
- **Staging**: Testes completos antes de Release
- **Produção**: Monitoramento pós-release

### Frequência
| Tipo | Frequência |
|------|------------|
| Unit | A cada commit |
| Widget | A cada commit |
| Integration | A cada PR |
| Golden | A cada PR |
| E2E | Diário |
| Performance | Semanal |
| Regression | Antes de cada Release |
| UAT | Antes de cada Release |

## 3. Registro

### Formato
- ID do teste
- Descrição
- Passos
- Resultado esperado
- Resultado obtido
- Status (Pass/Fail/Skip)
- Evidência (screenshot/log)

### Ferramentas
- flutter test --reporter expanded
- Cobertura HTML
- Screenshots de falhas

## 4. Correção

### Processo
1. Identificar causa raiz
2. Criar bug report
3. Priorizar correção
4. Implementar fix
5. Adicionar teste de regressão

## 5. Reteste

### Critérios
- Correção implementada
- Teste de regressão passando
- Nenhum efeito colateral
- Cobertura mantida

## 6. Homologação

### Checklist
- [ ] Todos os testes P0 passando
- [ ] Todos os testes P1 passando
- [ ] 90%+ cobertura de código
- [ ] flutter analyze sem erros
- [ ] dart format executado
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado

## 7. Release

### Gates
- Quality Gate aprovado
- Revisão de código aprovada
- Aprovação do Product Owner
- Build de produção gerado
- Testes em device real executados

## Cronograma

| Fase | Início | Fim | Responsável |
|------|--------|-----|-------------|
| Planejamento | Sprint 1 | Sprint 1 | QA + Dev |
| Execução Unit | Contínuo | Contínuo | Dev |
| Execução Widget | Contínuo | Contínuo | Dev |
| Execução Integration | Contínuo | Contínuo | QA |
| Execução E2E | Sprint 2 | Contínuo | QA |
| Regression | Pré-release | Pré-release | QA + Dev |
| UAT | Pré-release | Pré-release | PO + Users |
| Homologação | Pré-release | Pré-release | QA |

## Riscos

| Risco | Impacto | Mitigação |
|-------|---------|-----------|
| Falta de dispositivos | Alto | Emuladores + Cloud Testing |
| Tempo insuficiente | Médio | Priorização P0/P1 |
| Dados inconsistentes | Médio | Fixtures padronizados |
| Flaky tests | Médio | Isolamento e retry |
