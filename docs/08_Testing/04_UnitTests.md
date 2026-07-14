# Testes Unitários — VCardSmart

## Objetivo

Testar toda a lógica de negócio isoladamente, sem dependência de UI ou APIs externas.

## Cobertura Mínima

- **100% dos UseCases**
- **90% dos Repositories**
- **90% dos Services**
- **100% dos Validators**
- **100% dos ValueObjects**
- **90% dos Mappers**

## Estrutura

```
test/unit/
├── application/
│   ├── usecases/
│   │   ├── create_profile_usecase_test.dart
│   │   ├── update_profile_usecase_test.dart
│   │   ├── generate_qrcode_usecase_test.dart
│   │   ├── generate_vcard_usecase_test.dart
│   │   ├── read_nfc_usecase_test.dart
│   │   ├── import_contact_usecase_test.dart
│   │   ├── export_to_agenda_usecase_test.dart
│   │   └── ...
│   └── services/
│       ├── auth_service_test.dart
│       ├── theme_service_test.dart
│       └── language_service_test.dart
├── domain/
│   ├── entities/
│   │   ├── profile_test.dart
│   │   └── contact_test.dart
│   ├── value_objects/
│   │   ├── email_test.dart
│   │   ├── phone_test.dart
│   │   ├── url_test.dart
│   │   └── ...
│   └── validators/
│       ├── profile_validator_test.dart
│       └── contact_validator_test.dart
└── data/
    ├── repositories/
    │   ├── profile_repository_impl_test.dart
    │   ├── contact_repository_impl_test.dart
    │   └── settings_repository_impl_test.dart
    ├── services/
    │   ├── hive_service_test.dart
    │   ├── secure_storage_service_test.dart
    │   └── nfc_service_test.dart
    └── mappers/
        ├── profile_mapper_test.dart
        ├── contact_mapper_test.dart
        └── vcard_mapper_test.dart
```

## Padrão de Teste

### Arrange-Act-Assert (AAA)

```dart
void main() {
  group('CreateProfileUseCase', () {
    late CreateProfileUseCase useCase;
    late MockProfileRepository mockRepository;

    setUp(() {
      mockRepository = MockProfileRepository();
      useCase = CreateProfileUseCase(mockRepository);
    });

    test('should create profile successfully', () async {
      // Arrange
      final profile = ProfileFixture.valid();
      when(() => mockRepository.save(any()))
          .thenAnswer((_) async => profile);

      // Act
      final result = await useCase(profile);

      // Assert
      expect(result, isNotNull);
      verify(() => mockRepository.save(profile)).called(1);
    });

    test('should throw when profile is invalid', () async {
      // Arrange
      final profile = ProfileFixture.invalid();

      // Act & Assert
      expect(
        () => useCase(profile),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
```

## Casos de Teste por UseCase

### CreateProfileUseCase

| ID | Cenário | Entrada | Resultado Esperado |
|----|---------|---------|-------------------|
| UP-01 | Criar perfil válido | Dados válidos | Perfil criado |
| UP-02 | Criar perfil com nome vazio | Nome = "" | ValidationException |
| UP-03 | Criar perfil com email inválido | Email inválido | ValidationException |
| UP-04 | Criar perfil com múltiplos telefones | Lista de telefones | Perfil criado |
| UP-05 | Criar perfil com caracteres especiais | Unicode | Perfil criado |

### GenerateQRCodeUseCase

| ID | Cenário | Entrada | Resultado Esperado |
|----|---------|---------|-------------------|
| QR-01 | Gerar QR Code válido | Perfil válido | Imagem QR Code |
| QR-02 | Gerar QR Code com perfil vazio | Perfil vazio | ValidationException |
| QR-03 | Gerar QR Code com dados grandes | Perfil grande | QR Code gerado |

### GenerateVCardUseCase

| ID | Cenário | Entrada | Resultado Esperado |
|----|---------|---------|-------------------|
| VC-01 | Gerar vCard válida | Perfil válido | String vCard |
| VC-02 | Gerar vCard com todos os campos | Perfil completo | String vCard completa |
| VC-03 | Gerar vCard com campos opcionais | Perfil parcial | String vCard parcial |

### ReadNFCUseCase

| ID | Cenário | Entrada | Resultado Esperado |
|----|---------|---------|-------------------|
| NF-01 | Ler NFC válido | Tag NFC | Dados do perfil |
| NF-02 | Ler NFC com dados corrompidos | Dados inválidos | ParseException |
| NF-03 | Ler NFC timeout | Timeout | TimeoutException |

## Mocking

### Padrão com Mockito

```dart
@GenerateMocks([
  ProfileRepository,
  ContactRepository,
  HiveService,
])
void main() {
  // ...
}
```

### Mocks Customizados

```dart
class MockProfileRepository extends Mock
    implements ProfileRepository {}

class MockContactRepository extends Mock
    implements ContactRepository {}
```

## Fixtures

### ProfileFixture

```dart
class ProfileFixture {
  static Profile valid() => Profile(
    name: 'João Silva',
    email: 'joao@email.com',
    phone: '+5511999999999',
    company: 'Empresa LTDA',
  );

  static Profile invalid() => Profile(
    name: '',
    email: 'invalid',
    phone: '',
    company: '',
  );

  static Profile complete() => Profile(
    name: 'Maria Santos',
    email: 'maria@email.com',
    phone: '+5511888888888',
    company: 'Tech Corp',
    website: 'https://tech.com',
    address: 'Rua A, 123',
    networks: [
      SocialNetwork(name: 'LinkedIn', url: 'linkedin.com/in/maria'),
      SocialNetwork(name: 'Instagram', url: '@maria'),
    ],
  );
}
```

## Execução

```dart
// Rodar todos os testes unitários
flutter test test/unit/

// Rodar com cobertura
flutter test --coverage test/unit/

// Rodar teste específico
flutter test test/unit/application/usecases/create_profile_usecase_test.dart

// Rodar grupo específico
flutter test --name "CreateProfileUseCase"
```

## Métricas

| Métrica | Meta |
|---------|------|
| Cobertura de código | ≥ 90% |
| Testes passando | 100% |
| Tempo total | < 30s |
| Testes por UseCase | ≥ 5 |
