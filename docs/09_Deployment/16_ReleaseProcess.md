# Processo de Release — VCardSmart

## Fluxo

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

## 1. Merge Develop

```bash
# Atualizar develop
git checkout develop
git pull origin develop

# Merge na main
git checkout main
git merge develop

# Push
git push origin main
```

## 2. Versionamento

```bash
# Incrementar versão
./scripts/bump_version.sh

# Commit
git add .
git commit -m "chore: bump version to 1.2.0"
```

## 3. Build

```bash
# Build Android
flutter build apk --release
flutter build appbundle --release

# Build iOS
flutter build ios --release
flutter build ipa --release
```

## 4. Testes

```bash
# Rodar todos os testes
flutter test

# Rodar testes de regressão
flutter test test/regression/

# Rodar testes de performance
flutter test test/performance/
```

## 5. CI

```bash
# Push para trigger CI
git push origin main

# CI executará:
# - flutter analyze
# - flutter test
# - flutter build
```

## 6. Homologação

```bash
# Verificar build
# - Android: testar APK em device real
# - iOS: testar via TestFlight

# Checklist de homologação:
# [ ] Funcionalidades principais
# [ ] Performance
# [ ] Segurança
# [ ] Acessibilidade
# [ ] Compatibilidade
```

## 7. Publicação

### Google Play

```bash
# Upload com Fastlane
cd android
bundle exec fastlane production

# Ou manualmente:
# 1. Acesse Google Play Console
# 2. Crie nova release
# 3. Upload AAB
# 4. Preencha metadata
# 5. Publique
```

### App Store

```bash
# Upload com Fastlane
cd ios
bundle exec fastlane app_store

# Ou manualmente:
# 1. Acesse App Store Connect
# 2. Crie nova versão
# 3. Upload IPA
# 4. Preencha metadata
# 5. Submeta para revisão
```

## 8. Pós-Publicação

```bash
# Tag da versão
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin v1.2.0

# Atualizar CHANGELOG
# Comunicar stakeholders
# Monitorar crash reports
```

## Critérios de Aprovação

### Técnicos

- [ ] Todos os testes aprovados
- [ ] Cobertura mínima atingida
- [ ] flutter analyze sem erros
- [ ] dart format executado
- [ ] Build assinado

### Produto

- [ ] Funcionalidades implementadas
- [ ] UX validada
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado

### Compliance

- [ ] Política de Privacidade revisada
- [ ] Data Safety atualizado
- [ ] Privacy Labels atualizados
- [ ] LGPD compliance

### Aprovações

- [ ] QA aprovado
- [ ] Product Owner aprovado
- [ ] Tech Lead aprovado

## Timeline Típica

| Dia | Atividade |
|-----|-----------|
| D-5 | Merge develop → main |
| D-4 | Versionamento + Build |
| D-3 | Testes + CI |
| D-2 | Homologação |
| D-1 | Aprovações |
| D-0 | Publicação |
| D+1 | Monitoramento |
