# Dados de Teste — VCardSmart

## Objetivo

Definir dados de teste padronizados para garantir consistência e reprodutibilidade nos testes.

## Estrutura

```
test/fixtures/
├── profiles/
│   ├── valid_profile.dart
│   ├── invalid_profile.dart
│   ├── complete_profile.dart
│   ├── minimal_profile.dart
│   └── special_chars_profile.dart
├── contacts/
│   ├── valid_contact.dart
│   ├── invalid_contact.dart
│   └── multiple_phones_contact.dart
├── nfc/
│   ├── valid_nfc_data.dart
│   ├── invalid_nfc_data.dart
│   └── corrupted_nfc_data.dart
├── vcard/
│   ├── valid_vcard.dart
│   ├── complete_vcard.dart
│   └── minimal_vcard.dart
└── settings/
    ├── default_settings.dart
    ├── dark_theme_settings.dart
    └── custom_settings.dart
```

## Perfis de Teste

### 1. Perfil Válido

```dart
class ProfileFixture {
  static Profile valid() => Profile(
    id: 'test-id-001',
    name: 'João Silva',
    email: 'joao@email.com',
    phone: '+5511999999999',
    company: 'Empresa LTDA',
    createdAt: DateTime(2024, 1, 15),
    updatedAt: DateTime(2024, 1, 15),
  );
}
```

### 2. Perfil Completo

```dart
static Profile complete() => Profile(
  id: 'test-id-002',
  name: 'Maria Santos',
  email: 'maria@email.com',
  phone: '+5511888888888',
  company: 'Tech Corp',
  website: 'https://techcorp.com',
  address: 'Rua das Flores, 123 - São Paulo, SP',
  networks: [
    SocialNetwork(
      name: 'LinkedIn',
      url: 'https://linkedin.com/in/mariasantos',
    ),
    SocialNetwork(
      name: 'Instagram',
      url: '@mariasantos',
    ),
    SocialNetwork(
      name: 'Twitter',
      url: '@mariasantos',
    ),
  ],
  photo: 'base64_encoded_photo',
  createdAt: DateTime(2024, 1, 15),
  updatedAt: DateTime(2024, 6, 20),
);
```

### 3. Perfil Inválido

```dart
static Profile invalid() => Profile(
  id: '',
  name: '',
  email: 'invalid-email',
  phone: '123',
  company: '',
);
```

### 4. Perfil Mínimo

```dart
static Profile minimal() => Profile(
  id: 'test-id-003',
  name: 'A',
  email: 'a@b.co',
  phone: '+5511000000000',
);
```

### 5. Perfil com Caracteres Especiais

```dart
static Profile specialChars() => Profile(
  id: 'test-id-004',
  name: 'José María García-López',
  email: 'jose.maria@email.com',
  phone: '+34612345678',
  company: 'Empresa & Filhos, Lda.',
  website: 'https://empresa.com/path?q=1&r=2',
  address: 'Calle de la Paz, 123 - São Paulo, SP',
);
```

### 6. Perfil com Unicode

```dart
static Profile unicode() => Profile(
  id: 'test-id-005',
  name: '田中太郎',
  email: 'tanaka@email.com',
  phone: '+81901234567',
  company: '株式会社テスト',
  website: 'https://テスト.com',
  address: '東京都渋谷区',
);
```

### 7. Empresa Pequena

```dart
static Profile smallBusiness() => Profile(
  id: 'test-id-006',
  name: 'João Silva',
  email: 'joao@padaria.com',
  phone: '+5511999999999',
  company: 'Padaria do João',
  website: null,
  address: 'Rua da Padaria, 123',
  networks: [],
);
```

### 8. Empresa Grande

```dart
static Profile largeBusiness() => Profile(
  id: 'test-id-007',
  name: 'Maria Santos',
  email: 'maria.santos@techcorp.com',
  phone: '+5511888888888',
  company: 'Tech Corporation International',
  website: 'https://techcorp.com',
  address: 'Av. Paulista, 1000 - 15º andar - São Paulo, SP',
  networks: [
    SocialNetwork(name: 'LinkedIn', url: 'linkedin.com/techcorp'),
    SocialNetwork(name: 'Twitter', url: '@techcorp'),
    SocialNetwork(name: 'Facebook', url: 'facebook.com/techcorp'),
    SocialNetwork(name: 'Instagram', url: '@techcorp'),
    SocialNetwork(name: 'YouTube', url: 'youtube.com/techcorp'),
  ],
);
```

## Contatos de Teste

### Contato Válido

```dart
class ContactFixture {
  static Contact valid() => Contact(
    id: 'contact-001',
    name: 'Ana Oliveira',
    email: 'ana@email.com',
    phone: '+5511777777777',
    company: 'Startup XYZ',
  );
}
```

### Contato com Múltiplos Telefones

```dart
static Contact multiplePhones() => Contact(
  id: 'contact-002',
  name: 'Carlos Ferreira',
  email: 'carlos@email.com',
  phones: [
    '+5511666666666', // Celular
    '+5511555555555', // Comercial
    '+5511444444444', // Residencial
  ],
  company: 'Empresa ABC',
);
```

### Contato com Múltiplas Redes

```dart
static Contact multipleNetworks() => Contact(
  id: 'contact-003',
  name: 'Pedro Costa',
  email: 'pedro@email.com',
  phone: '+5511333333333',
  company: 'Tech Solutions',
  networks: [
    SocialNetwork(name: 'LinkedIn', url: 'linkedin.com/in/pedro'),
    SocialNetwork(name: 'GitHub', url: 'github.com/pedro'),
    SocialNetwork(name: 'Twitter', url: '@pedro'),
  ],
);
```

## Dados NFC de Teste

### NFC Válido

```dart
class NfcDataFixture {
  static NfcData valid() => NfcData(
    type: 'vcard',
    payload: 'BEGIN:VCARD\nVERSION:3.0\nFN:João Silva\n...END:VCARD',
    timestamp: DateTime.now(),
  );
}
```

### NFC Inválido

```dart
static NfcData invalid() => NfcData(
  type: 'unknown',
  payload: 'invalid data',
  timestamp: DateTime.now(),
);
```

### NFC Corrompido

```dart
static NfcData corrupted() => NfcData(
  type: 'vcard',
  payload: 'BEGIN:VCARD\nVERSION:3.0\nFN:João\x00Silva\n...END:VCARD',
  timestamp: DateTime.now(),
);
```

## Dados vCard de Teste

### vCard Válida

```dart
class VCardFixture {
  static String valid() => '''
BEGIN:VCARD
VERSION:3.0
FN:João Silva
ORG:Empresa LTDA
TEL;TYPE=CELL:+5511999999999
EMAIL:joao@email.com
URL:https://empresa.com
END:VCARD
''';
}
```

### vCard Completa

```dart
static String complete() => '''
BEGIN:VCARD
VERSION:3.0
FN:Maria Santos
N:Santos;Maria;;;
ORG:Tech Corp
TITLE:CEO
TEL;TYPE=CELL:+5511888888888
TEL;TYPE=WORK:+5511777777777
EMAIL;TYPE=WORK:maria.santos@techcorp.com
URL:https://techcorp.com
ADR;TYPE=WORK:;;Av. Paulista, 1000;São Paulo;SP;01310-100;Brazil
NOTE:CEO da Tech Corp
END:VCARD
''';
}
```

## Configurações de Teste

### Configurações Padrão

```dart
class SettingsFixture {
  static Settings defaults() => Settings(
    theme: ThemeMode.system,
    locale: Locale('pt'),
    biometricEnabled: false,
    pinEnabled: false,
    adsEnabled: true,
  );
}
```

### Configurações Tema Escuro

```dart
static Settings darkTheme() => Settings(
  theme: ThemeMode.dark,
  locale: Locale('pt'),
  biometricEnabled: true,
  pinEnabled: true,
  adsEnabled: false,
);
```

## Geração de Dados

```dart
class TestDataGenerator {
  static Profile randomProfile() {
    final random = Random();
    return Profile(
      id: 'test-${random.nextInt(10000)}',
      name: _randomName(random),
      email: _randomEmail(random),
      phone: _randomPhone(random),
      company: _randomCompany(random),
    );
  }

  static List<Contact> randomContacts(int count) {
    return List.generate(count, (_) => randomContact());
  }
}
```

## Uso nos Testes

```dart
void main() {
  test('should save valid profile', () async {
    final profile = ProfileFixture.valid();
    final result = await repository.save(profile);
    
    expect(result, isNotNull);
    expect(result.name, equals('João Silva'));
  });

  test('should handle special characters', () async {
    final profile = ProfileFixture.specialChars();
    final result = await repository.save(profile);
    
    expect(result.name, equals('José María García-López'));
  });
}
```
