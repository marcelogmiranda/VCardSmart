# Cobertura de Testes — VCardSmart

## Metas de Cobertura

| Nível | Meta Mínima | Meta Ideal |
|-------|-------------|------------|
| Unit | 90% | 95% |
| Widget | 90% | 95% |
| Integration | 80% | 90% |
| Golden | 100% componentes | 100% |
| E2E | 100% fluxos críticos | 100% |
| Security | 100% cenários críticos | 100% |
| Accessibility | 100% WCAG | 100% |
| i18n | 100% idiomas | 100% |

## Métricas

### Cobertura de Código

```bash
# Gerar relatório de cobertura
flutter test --coverage

# Visualizar relatório
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Cobertura por Camada

| Camada | Arquivos | Cobertura Meta |
|--------|----------|----------------|
| Domain | entities, value_objects, validators | 100% |
| Application | usecases, services | 100% |
| Data | repositories, mappers, services | 90% |
| Presentation | screens, widgets, components | 90% |
| Infrastructure | external services | 80% |

### Cobertura por Funcionalidade

| Funcionalidade | Unit | Widget | Integration | E2E |
|----------------|------|--------|-------------|-----|
| Perfil | 100% | 100% | 100% | 100% |
| QR Code | 100% | 100% | 100% | 100% |
| NFC | 100% | 100% | 100% | 100% |
| vCard | 100% | 100% | 100% | 100% |
| Agenda | 100% | 100% | 100% | 100% |
| Configurações | 100% | 100% | 90% | 100% |
| Biometria | 100% | 100% | 100% | 100% |
| Tema | 100% | 100% | 90% | 100% |
| Idioma | 100% | 100% | 90% | 100% |
| Anúncios | 100% | 100% | 80% | 100% |

## Análise de Cobertura

### Cobertura Aceitável

```dart
// Exemplo de teste com boa cobertura
testWidgets('should create profile with valid data', ($) async {
  // Arrange
  final profile = ProfileFixture.valid();
  
  // Act
  await $.pumpApp(CreateProfileScreen());
  await $.enterText(find.byKey(Key('name_field')), profile.name);
  await $.enterText(find.byKey(Key('email_field')), profile.email);
  await $.enterText(find.byKey(Key('phone_field')), profile.phone);
  await $.tap(find.byKey(Key('save_button')));
  await $.pumpAndSettle();
  
  // Assert
  expect(find.text(profile.name), findsOneWidget);
});
```

### Cobertura Insuficiente

```dart
// Exemplo com cobertura insuficiente
testWidgets('should work', ($) async {
  await $.pumpApp(HomeScreen());
  // Falta testar:
  // - Estados de loading
  // - Estados de erro
  // - Estados vazios
  // - Interações do usuário
});
```

## Relatório de Cobertura

### Formato

```
═══════════════════════════════════════
    VCardSmart Coverage Report
═══════════════════════════════════════

Unit Tests:        92% ✅ (target: 90%)
Widget Tests:      94% ✅ (target: 90%)
Integration Tests: 85% ✅ (target: 80%)
Golden Tests:      100% ✅ (target: 100%)
E2E Tests:         100% ✅ (target: 100%)

═══════════════════════════════════════
              RESULT: PASS
═══════════════════════════════════════
```

### Detalhamento por Arquivo

```
lib/
├── domain/
│   ├── entities/
│   │   ├── profile.dart         100% ✅
│   │   └── contact.dart         100% ✅
│   ├── value_objects/
│   │   ├── email.dart           100% ✅
│   │   └── phone.dart           100% ✅
│   └── validators/
│       └── profile_validator.dart 100% ✅
├── application/
│   ├── usecases/
│   │   ├── create_profile_usecase.dart  100% ✅
│   │   └── generate_qrcode_usecase.dart 100% ✅
│   └── services/
│       └── auth_service.dart    95% ✅
├── data/
│   ├── repositories/
│   │   └── profile_repository_impl.dart 92% ✅
│   └── mappers/
│       └── profile_mapper.dart  90% ✅
└── presentation/
    ├── screens/
    │   ├── home_screen.dart     95% ✅
    │   └── profile_screen.dart  93% ✅
    └── components/
        └── primary_button.dart  100% ✅

═══════════════════════════════════════
Overall: 94% ✅
═══════════════════════════════════════
```

## Ações para Melhorar Cobertura

### 1. Identificar Lacunas

```bash
# Gerar relatório detalhado
flutter test --coverage
lcov --list coverage/lcov.info
```

### 2. Adicionar Testes

```dart
// Teste para código não coberto
test('should handle edge case', () {
  // Arrange
  final service = MyService();
  
  // Act & Assert
  expect(
    () => service.edgeCaseMethod(null),
    throwsA(isA<ValidationException>()),
  );
});
```

### 3. Priorizar Cobertura

1. **P0**: UseCases, Entities, ValueObjects — 100%
2. **P1**: Repositories, Services — 90%
3. **P2**: Mappers, Screens — 90%
4. **P3**: Components, Utils — 80%

## Ferramentas

- **flutter test --coverage** — Gerar cobertura
- **lcov** — Processar dados
- **genhtml** — Gerar HTML
- **codecov** — CI/CD integration
- **coveralls** — CI/CD integration

## Processo

1. **Executar testes** com cobertura
2. **Analisar relatório** identificar lacunas
3. **Priorizar** baseado em criticidade
4. **Adicionar testes** para código não coberto
5. **Re-executar** validar melhoria
6. **Aprovar** se meta atingida

## Quality Gate

```yaml
quality_gate:
  unit_coverage: 90
  widget_coverage: 90
  integration_coverage: 80
  golden_coverage: 100
  e2e_coverage: 100
  overall_coverage: 90
```
