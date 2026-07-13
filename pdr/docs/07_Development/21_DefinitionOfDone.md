# Definition of Done

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Critérios

Uma funcionalidade está considerada **pronta** quando:

| # | Critério | Status |
|---|----------|--------|
| 1 | Implementada conforme documentação | ✅ |
| 2 | Testes unitários passando | ✅ |
| 3 | Testes de widget passando | ✅ |
| 4 | Documentada (DartDoc) | ✅ |
| 5 | Internacionalizada (ARB) | ✅ |
| 6 | Acessível (labels, contraste) | ✅ |
| 7 | Sem erros no `flutter analyze` | ✅ |
| 8 | Sem warnings no `flutter analyze` | ✅ |
| 9 | Código formatado (`dart format`) | ✅ |
| 10 | Aprovado no Code Review | ✅ |
| 11 | Conforme Clean Architecture | ✅ |
| 12 | Conforme SOLID | ✅ |
| 13 | Sem dependências não aprovadas | ✅ |
| 14 | Documentação atualizada | ✅ |
| 15 | CHANGELOG atualizado | ✅ |

---

## Validação Automática

```bash
# Análise
flutter analyze

# Formatação
dart format --set-exit-if-changed .

# Testes
flutter test --coverage

# Cobertura mínima 80%
genhtml coverage/lcov.info -o coverage/
```

---

## Validação Manual

| # | Validação |
|---|-----------|
| 1 | Code Review aprovado |
| 2 | Funcionalidade testada manualmente |
| 3 | Tema claro/escuro funcionando |
| 4 | Internacionalização funcionando |
| 5 | Acessibilidade verificada |

---

## Documentos Relacionados

- [21_DefinitionOfDone.md](./21_DefinitionOfDone.md)
- [18_CodeReview.md](./18_CodeReview.md)
- [17_TestStrategy.md](./17_TestStrategy.md)
