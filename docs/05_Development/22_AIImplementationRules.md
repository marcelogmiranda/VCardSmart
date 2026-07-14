# AI Implementation Rules

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Antes de Codificar

| # | Ação |
|---|------|
| 1 | Ler README |
| 2 | Ler AI_CONTEXT |
| 3 | Ler PRD |
| 4 | Ler Architecture |
| 5 | Ler Acceptance Criteria |
| 6 | Verificar documentação da feature |

---

## Regras Obrigatórias

| # | Regra |
|---|-------|
| 1 | Nunca criar código fora da arquitetura |
| 2 | Nunca alterar documentação sem registrar |
| 3 | Nunca instalar dependências não aprovadas |
| 4 | Nunca criar lógica na UI |
| 5 | Sempre seguir Clean Architecture |
| 6 | Sempre seguir SOLID |
| 7 | Sempre criar UseCases para ações |
| 8 | Sempre testar antes de commitar |
| 9 | Sempre atualizar CHANGELOG |
| 10 | Sempre respeitar Definition of Done |

---

## Regras de Código

| # | Regra |
|---|-------|
| 1 | Nunca acessar Hive diretamente pela UI |
| 2 | Nunca acessar plugins pela Presentation |
| 3 | Toda regra deve possuir um UseCase |
| 4 | Toda entidade deve ser imutável |
| 5 | Todo Model deve possuir Mapper |
| 6 | Todo DTO deve possuir serialização |
| 7 | Todo Provider deve possuir testes |
| 8 | Toda tela deve possuir Widget Test |
| 9 | Toda Feature deve possuir documentação própria |

---

## Validação

```bash
# Antes de cada commit
flutter analyze
dart format .
flutter test
```

---

## Documentos Relacionados

- [22_AIImplementationRules.md](./22_AIImplementationRules.md)
- [23_OpenCodeWorkflow.md](./23_OpenCodeWorkflow.md)
- [21_DefinitionOfDone.md](./21_DefinitionOfDone.md)
