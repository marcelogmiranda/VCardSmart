# Processo de Hotfix — VCardSmart

## Fluxo

```
Bug Crítico Identificado
    ↓
Branch Hotfix Criada
    ↓
Correção Implementada
    ↓
Testes Executados
    ↓
CI Aprovado
    ↓
Nova Versão Patch
    ↓
Publicação Emergencial
```

## 1. Identificação do Bug

### Critérios para Hotfix

- App crashando em produção
- Perda de dados do usuário
- Funcionalidade crítica inutilizável
- Vulnerabilidade de segurança
- Violação de política das lojas

### Comunicação

```
1. Notificar equipe imediatamente
2. Avaliar severidade
3. Decidir se hotfix é necessário
4. Criar ticket de hotfix
```

## 2. Criar Branch Hotfix

```bash
# Criar branch a partir da main
git checkout main
git pull origin main

# Criar branch hotfix
git checkout -b hotfix/1.2.1

# Ou com nome descritivo
git checkout -b hotfix/crash-on-nfc-read
```

## 3. Implementar Correção

```bash
# Fazer correção
# ...

# Testar localmente
flutter test
flutter analyze

# Commit
git add .
git commit -m "fix: resolve crash on NFC read"
```

## 4. Testes

```bash
# Rodar testes completos
flutter test

# Rodar testes de regressão
flutter test test/regression/

# Verificar não quebrou nada
flutter test test/unit/
flutter test test/widget/
```

## 5. CI

```bash
# Push para CI
git push origin hotfix/1.2.1

# CI executará:
# - flutter analyze
# - flutter test
# - flutter build
```

## 6. Versão Patch

```bash
# Incrementar patch version
# Ex: 1.2.0 → 1.2.1

# Atualizar pubspec.yaml
version: 1.2.1+3

# Atualizar CHANGELOG
## [1.2.1] - 2024-01-15
### Fixed
- Critical crash on NFC read

# Commit
git add .
git commit -m "chore: bump version to 1.2.1"
```

## 7. Merge

```bash
# Merge na main
git checkout main
git merge hotfix/1.2.1

# Push
git push origin main

# Merge na develop (se aplicável)
git checkout develop
git merge hotfix/1.2.1

# Push
git push origin develop

# Delete branch
git branch -d hotfix/1.2.1
git push origin --delete hotfix/1.2.1
```

## 8. Publicação Emergencial

### Google Play

```bash
# Build
flutter build appbundle --release

# Upload com Fastlane
cd android
bundle exec fastlane production
```

### App Store

```bash
# Build
flutter build ipa --release

# Upload com Fastlane
cd ios
bundle exec fastlane app_store

# Ou via TestFlight para revisão rápida
```

## 9. Pós-Hotfix

```bash
# Tag
git tag -a v1.2.1 -m "Hotfix 1.2.1"
git push origin v1.2.1

# Monitorar
# - Crash reports
# - User feedback
# - Store reviews

# Documentar
# - Causa raiz
# - Correção aplicada
# - Ações preventivas
```

## Template de Hotfix

```markdown
## Hotfix: [Título]

### Bug
[Descrição do bug]

### Causa Raiz
[Análise da causa]

### Correção
[Descrição da correção]

### Testes
- [ ] Unit tests passando
- [ ] Widget tests passando
- [ ] Integration tests passando
- [ ] Regression tests passando

### Impacto
- [ ] Sem efeitos colaterais
- [ ] Performance mantida
- [ ] Compatibilidade mantida

### Aprovações
- [ ] QA
- [ ] Tech Lead
```

## Timeline Típica

| Hora | Atividade |
|------|-----------|
| H+0 | Bug identificado |
| H+1 | Branch hotfix criada |
| H+2 | Correção implementada |
| H+3 | Testes executados |
| H+4 | CI aprovado |
| H+5 | Build gerado |
| H+6 | Publicado em homologação |
| H+24 | Publicado em produção |
