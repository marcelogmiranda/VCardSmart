# Prompts de Release — VCardSmart

## Preparar Release

### Criar Release

```
Prepare a release [versão]:

## Mudanças

[mudanças desde a última release]

## Checklist

- [ ] Todas as features implementadas
- [ ] Todos os testes passando
- [ ] Cobertura > 80%
- [ ] Lints OK
- [ ] Performance OK
- [ ] Segurança OK
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado
- [ ] Versão atualizada no pubspec.yaml
- [ ] Screenshots atualizados (se necessário)
- [ ] Store listing atualizado (se necessário)
```

### Atualizar Versão

```
Atualize a versão para [versão]:

## Arquivos

- pubspec.yaml
- CHANGELOG.md
- README.md (se necessário)

## Versão

[versão]
```

### Criar Tag

```
Crie a tag [versão]:

git tag -a [versão] -m "Release [versão]"
git push origin [versão]
```

## Release Notes

### Formato

```markdown
# Release [versão]

## Data

YYYY-MM-DD

## Novidades

- [novidade 1]
- [novidade 2]

## Melhorias

- [melhoria 1]
- [melhoria 2]

## Correções

- [correção 1]
- [correção 2]

## Breaking Changes

- [breaking change 1]
- [breaking change 2]

## Upgrade Guide

[instruções de upgrade]
```

## Publicação

### Google Play

```
Prepare a publicação na Google Play:

## Arquivos

- APK/AAB assinado
- Screenshots
- Feature graphic
- Descrição
- Políticas

## Checklist

- [ ] Build de release
- [ ] Assinatura OK
- [ ] Screenshots atualizados
- [ ] Feature graphic atualizado
- [ ] Descrição atualizada
- [ ] Políticas OK
- [ ] Data Safety preenchido
- [ ] Classificação indicativa OK
```

### Apple App Store

```
Prepare a publicação na Apple App Store:

## Arquivos

- IPA assinado
- Screenshots
- App Preview
- Descrição
- Privacy Labels

## Checklist

- [ ] Build de release
- [ ] Assinatura OK
- [ ] Screenshots atualizados
- [ ] App Preview atualizado
- [ ] Descrição atualizada
- [ ] Privacy Labels preenchidas
- [ ] Age Rating OK
```

## Hotfix

### Criar Hotfix

```
Crie o hotfix [versão]:

## Bug

[descrição do bug]

## Correção

[descrição da correção]

## Impacto

[impacto da correção]

## Testes

[testes realizados]
```

### Release Hotfix

```
Prepare a release do hotfix [versão]:

## Mudanças

- Correção do bug [descrição]

## Checklist

- [ ] Bug corrigido
- [ ] Testes passando
- [ ] Build de release
- [ ] CHANGELOG atualizado
- [ ] Tag criada
- [ ] Publicado
```

## Rollback

### Criar Rollback

```
Crie o rollback para a versão [versão]:

## Motivo

[motivo do rollback]

## Versão anterior

[versão anterior]

## Ações

1. [ação 1]
2. [ação 2]
3. [ação 3]
```

## Checklist de Release

### Pré-Release

- [ ] Todas as features implementadas
- [ ] Todos os testes passando
- [ ] Cobertura > 80%
- [ ] Lints OK
- [ ] Performance OK
- [ ] Segurança OK
- [ ] Documentação atualizada
- [ ] CHANGELOG atualizado
- [ ] Versão atualizada

### Release

- [ ] Build de release criado
- [ ] Assinatura OK
- [ ] Tag criada
- [ ] Release notes criadas
- [ ] Publicado nas lojas

### Pós-Release

- [ ] Monitoramento ativo
- [ ] Crash reports monitorados
- [ ] Reviews monitorados
- [ ] Métricas acompanhadas
