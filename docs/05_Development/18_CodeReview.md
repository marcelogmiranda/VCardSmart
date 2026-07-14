# Code Review

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Checklist

### Flutter Analyze
- [ ] `flutter analyze` sem erros
- [ ] `flutter analyze` sem warnings
- [ ] `dart format .` aplicado

### Testes
- [ ] Testes unitários passando
- [ ] Testes de widget passando
- [ ] Cobertura mínima atingida

### Documentação
- [ ] DartDoc em APIs públicas
- [ ] README atualizado
- [ ] CHANGELOG atualizado

### Arquitetura
- [ ] Clean Architecture respeitada
- [ ] Dependências apontando para dentro
- [ ] Sem importações proibidas

### Performance
- [ ] Const constructors utilizados
- [ ] Widgets reconstruídos apenas quando necessário
- [ ] Sem operações pesadas na UI

### Segurança
- [ ] Sem dados sensíveis em logs
- [ ] Sem credenciais no código
- [ ] Permissões solicitadas corretamente

---

## Processo

1. Criar branch feature
2. Implementar
3. Rodar testes
4. Rodar analyze
5. Abrir PR
6. Revisão
7. Merge

---

## Documentos Relacionados

- [18_CodeReview.md](./18_CodeReview.md)
- [19_GitStrategy.md](./19_GitStrategy.md)
- [21_DefinitionOfDone.md](./21_DefinitionOfDone.md)
