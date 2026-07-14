# Deployment Overview — VCardSmart

## Stack de Deployment

| Camada | Tecnologia |
|--------|------------|
| IDE | Visual Studio Code |
| Framework | Flutter Stable |
| CI/CD | GitHub Actions |
| Automação | Fastlane |
| Distribuição | Google Play / Apple App Store |
| Atualizações | Somente pelas lojas oficiais |

## Pipeline

```
Commit → GitHub → Analyze → Test → Build → Artifacts → Release
```

## Ambientes

| Ambiente | Uso | Distribuição |
|----------|-----|--------------|
| Development | Desenvolvimento local | - |
| CI | Testes automáticos | - |
| Beta | Testes internos | TestFlight / Internal Testing |
| RC | Validação final | - |
| Production | Produção | Google Play / App Store |

## Fluxo de Release

```
Merge Develop
    ↓
Versionamento
    ↓
Build
    ↓
Testes
    ↓
CI
    ↓
Homologação
    ↓
Google Play
    ↓
App Store
    ↓
Publicação
```

## Critérios para Publicação

- Todos os testes aprovados
- Cobertura mínima atingida
- Documentação atualizada
- CHANGELOG atualizado
- Política de Privacidade revisada
- Data Safety (Google Play) atualizada
- Privacy Labels (Apple) atualizadas
- Build assinado
- Aprovação de QA
- Aprovação do Product Owner

## ADRs

- **ADR-022**: Deployment Automatizado — Build automatizado via GitHub Actions + Fastlane
- **ADR-023**: Distribuição Exclusiva pelas Lojas — Sem APKs de terceiros
- **ADR-024**: Atualizações Exclusivamente pelas Lojas — Sem in-app update próprio
