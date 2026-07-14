# OpenCode Workflow

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fluxo Oficial

```
1. Ler Workspace
   ↓
2. Validar documentação
   ↓
3. Criar branch
   ↓
4. Implementar módulo
   ↓
5. Executar testes
   ↓
6. Corrigir
   ↓
7. Atualizar documentação
   ↓
8. Atualizar CHANGELOG
   ↓
9. Criar Commit
   ↓
10. Abrir PR
```

---

## Detalhamento

### 1. Ler Workspace
- Verificar estrutura do projeto
- Identificar features existentes
- Entender contexto atual

### 2. Validar Documentação
- Ler PRD da feature
- Ler Architecture
- Ler Acceptance Criteria
- Verificar dependências

### 3. Criar Branch
```bash
git checkout -b feature/nome-da-feature
```

### 4. Implementar Módulo
- Seguir Clean Architecture
- Criar UseCases
- Criar Providers
- Criar UI

### 5. Executar Testes
```bash
flutter test
flutter analyze
dart format .
```

### 6. Corrigir
- Corrigir erros encontrados
- Refatorar se necessário

### 7. Atualizar Documentação
- README se necessário
- Documentação da feature

### 8. Atualizar CHANGELOG
```markdown
## [1.0.0] - 2026-07-13
### Added
- Feature X
```

### 9. Criar Commit
```bash
git add .
git commit -m "feat(feature): descrição"
```

### 10. Abrir PR
- Título descritivo
- Descrição completa
- Link para documentação

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre seguir o fluxo |
| 2 | Nunca pular etapas |
| 3 | Sempre validar antes de commitar |
| 4 | Sempre atualizar CHANGELOG |
| 5 | Sempre abrir PR |

---

## Documentos Relacionados

- [23_OpenCodeWorkflow.md](./23_OpenCodeWorkflow.md)
- [22_AIImplementationRules.md](./22_AIImplementationRules.md)
- [21_DefinitionOfDone.md](./21_DefinitionOfDone.md)
