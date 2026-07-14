# Prompts de Teste — VCardSmart

## Unit Tests

### Criar Unit Tests

```
Gere unit tests para [componente].

Cobertura mínima: 80%

Casos de teste:
- Happy path
- Edge cases
- Error cases
- Null handling

Exemplo:

test('should return profile when found', () async {
  // Arrange
  final repository = MockProfileRepository();
  final useCase = GetProfileUseCase(repository);
  
  when(repository.getProfile('1')).thenAnswer(
    (_) async => const Profile(id: '1', name: 'Test'),
  );
  
  // Act
  final result = await useCase.call('1');
  
  // Assert
  expect(result.id, '1');
  expect(result.name, 'Test');
});

test('should throw exception when not found', () async {
  // Arrange
  final repository = MockProfileRepository();
  final useCase = GetProfileUseCase(repository);
  
  when(repository.getProfile('999')).thenThrow(
    ProfileNotFoundException('999'),
  );
  
  // Act & Assert
  expect(
    () => useCase.call('999'),
    throwsA(isA<ProfileNotFoundException>()),
  );
});
```

### Mock Repository

```
Gere mock para [Repository].

class MockProfileRepository extends Mock implements ProfileRepository {}

Uso:

final repository = MockProfileRepository();

when(repository.getProfile('1')).thenAnswer(
  (_) async => const Profile(id: '1', name: 'Test'),
);

verify(repository.getProfile('1')).called(1);
```

### Mock UseCase

```
Gere mock para [UseCase].

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

Uso:

final useCase = MockGetProfileUseCase();

when(useCase.call('1')).thenAnswer(
  (_) async => const Profile(id: '1', name: 'Test'),
);

verify(useCase.call('1')).called(1);
```

## Widget Tests

### Criar Widget Tests

```
Gere widget tests para [Widget].

Casos de teste:
- Renderização
- Interação
- Estado
- Acessibilidade

Exemplo:

testWidgets('should display profile name', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ProfileCard(
        profile: const Profile(id: '1', name: 'Test'),
      ),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
});

testWidgets('should call onTap when tapped', (tester) async {
  var tapped = false;
  
  await tester.pumpWidget(
    MaterialApp(
      home: ProfileCard(
        profile: const Profile(id: '1', name: 'Test'),
        onTap: () => tapped = true,
      ),
    ),
  );
  
  await tester.tap(find.byType(ProfileCard));
  
  expect(tapped, true);
});
```

### Mock Provider

```
Gere mock para Provider.

final mockProvider = Provider<ProfileRepository>(
  (ref) => MockProfileRepository(),
);

Uso:

await tester.pumpWidget(
  ProviderScope(
    overrides: [
      profileRepositoryProvider.overrideWithValue(mockProvider),
    ],
    child: const MaterialApp(
      home: ProfilePage(),
    ),
  ),
);
```

## Integration Tests

### Criar Integration Tests

```
Gere integration tests para [fluxo].

Fluxo:
1. [Passo 1]
2. [Passo 2]
3. [Passo 3]

Exemplo:

testWidgets('complete profile creation flow', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Step 1: Navigate to create profile
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  
  // Step 2: Fill form
  await tester.enterText(
    find.byKey(const Key('name_field')),
    'John Doe',
  );
  await tester.enterText(
    find.byKey(const Key('email_field')),
    'john@example.com',
  );
  
  // Step 3: Save
  await tester.tap(find.byKey(const Key('save_button')));
  await tester.pumpAndSettle();
  
  // Assert
  expect(find.text('John Doe'), findsOneWidget);
});
```

## Golden Tests

### Criar Golden Tests

```
Gere golden tests para [Widget].

Exemplo:

testWidgets('ProfileCard golden test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ProfileCard(
        profile: const Profile(id: '1', name: 'Test'),
      ),
    ),
  );
  
  await expectLater(
    find.byType(ProfileCard),
    matchesGoldenFile('golden/profile_card.png'),
  );
});
```

## Testes de Performance

### Criar Testes de Performance

```
Gere testes de performance para [componente].

Métricas:
- Tempo de construção
- Tempo de renderização
- Memória

Exemplo:

testWidgets('ProfileCard performance', (tester) async {
  final stopwatch = Stopwatch()..start();
  
  await tester.pumpWidget(
    MaterialApp(
      home: ProfileCard(
        profile: const Profile(id: '1', name: 'Test'),
      ),
    ),
  );
  
  stopwatch.stop();
  
  expect(stopwatch.elapsedMilliseconds, lessThan(100));
});
```

## Cobertura

### Verificar Cobertura

```bash
# Gerar relatório
flutter test --coverage

# Visualizar
genhtml coverage/lcov.info -o coverage/html

# Abrir
open coverage/html/index.html
```

### Meta

| Métrica | Meta |
|---------|------|
| Cobertura geral | > 80% |
| Domain | > 90% |
| Data | > 80% |
| Presentation | > 70% |
