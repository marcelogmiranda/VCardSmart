# Git Strategy

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Branches

| Branch | Uso | Protegida |
|--------|-----|-----------|
| **main** | Produção | ✅ |
| **develop** | Desenvolvimento | ✅ |
| **feature/*** | Funcionalidades | ❌ |
| **release/*** | Releases | ❌ |
| **hotfix/*** | Correções urgentes | ❌ |

---

## Fluxo

```
main ← release/* ← develop ← feature/*
                ↑
              hotfix/*
```

---

## Conventional Commits

### Formato
```
<type>(<scope>): <description>
```

### Types
| Type | Uso |
|------|-----|
| **feat** | Nova funcionalidade |
| **fix** | Correção de bug |
| **docs** | Documentação |
| **style** | Formatação |
| **refactor** | Refatoração |
| **test** | Testes |
| **chore** | Configurações |
| **perf** | Performance |

### Exemplos
```
feat(profile): add photo upload
fix(nfc): fix transmission error
docs(readme): update installation guide
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre criar branch feature |
| 2 | Commits descritivos |
| 3 | PR antes de merge |
| 4 | Review obrigatório |
| 5 | Testes passando |

---

## Documentos Relacionados

- [19_GitStrategy.md](./19_GitStrategy.md)
- [20_CICD.md](./20_CICD.md)
- [18_CodeReview.md](./18_CodeReview.md)
