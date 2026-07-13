# Test Strategy

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Tipos de Teste

| Tipo | Uso | Cobertura |
|------|-----|-----------|
| **Unit Test** | Lógica de negócio | UseCases, Repositories, Services |
| **Widget Test** | Componentes UI | Pages, Widgets |
| **Integration Test** | Fluxos completos | Navegação, compartilhamento |
| **Golden Test** | Visual | Comparação de screenshots |

---

## Cobertura

| Métrica | Meta |
|---------|------|
| **Cobertura mínima** | 80% |
| **Testes unitários** | 100% dos UseCases |
| **Testes de widget** | Todas as telas principais |
| **Testes de integração** | Fluxos críticos |

---

## Estrutura

```
test/
├── features/
│   ├── profile/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   ├── data/
│   │   │   └── repositories/
│   │   └── presentation/
│   │       └── widgets/
│   ├── sharing/
│   └── ...
├── core/
│   └── services/
└── shared/
    └── widgets/
```

---

## Exemplo: Unit Test

```dart
void main() {
  group('SaveProfileUseCase', () {
    test('should save profile successfully', () async {
      final repository = MockProfileRepository();
      final useCase = SaveProfileUseCase(repository);

      final profile = UserProfile(
        id: '1',
        fullName: 'Test',
        email: 'test@test.com',
        // ...
      );

      await useCase(profile);

      verify(() => repository.saveProfile(profile)).called(1);
    });
  });
}
```

---

## Exemplo: Widget Test

```dart
void main() {
  testWidgets('ProfilePage should display profile', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileProvider.overrideWithValue(AsyncValue.data(mockProfile)),
        ],
        child: MaterialApp(home: ProfilePage()),
      ),
    );

    expect(find.text('Nome'), findsOneWidget);
  });
}
```

---

## Documentos Relacionados

- [17_TestStrategy.md](./17_TestStrategy.md)
- [21_DefinitionOfDone.md](./21_DefinitionOfDone.md)
