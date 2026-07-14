# Services

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Lista de Services

| Service | Responsabilidade |
|---------|-----------------|
| **QRCodeService** | Geração e leitura de QR Code |
| **NFCService** | Transmissão e recepção NFC |
| **ContactsService** | Acesso à agenda do dispositivo |
| **VCardService** | Geração e parse de vCard |
| **AdsService** | Gerenciamento de anúncios |
| **LocalizationService** | Internacionalização |
| **SecurityService** | Biometria e PIN |
| **LoggerService** | Registro de logs |
| **MigrationService** | Migração de dados |
| **BiometricService** | Autenticação biométrica |

---

## QRCodeService

```dart
class QRCodeService {
  Future<Uint8List> generateQR(String data) async {
    // ...
  }

  Future<String?> readQR() async {
    // ...
  }
}
```

---

## NFCService

```dart
class NfcService {
  Future<void> transmit(UserProfile profile) async {
    // ...
  }

  Stream<NfcPayload> receive() async* {
    // ...
  }
}
```

---

## ContactsService

```dart
class ContactsService {
  Future<bool> requestPermission() async {
    // ...
  }

  Future<List<Contact>> getContacts() async {
    // ...
  }

  Future<void> addContact(Contact contact) async {
    // ...
  }

  Future<void> updateContact(Contact contact) async {
    // ...
  }
}
```

---

## VCardService

```dart
class VCardService {
  String generate(UserProfile profile) {
    // ...
  }

  UserProfile? parse(String vcard) {
    // ...
  }
}
```

---

## SecurityService

```dart
class SecurityService {
  Future<bool> isBiometricAvailable() async {
    // ...
  }

  Future<bool> authenticate() async {
    // ...
  }

  Future<void> setPin(String pin) async {
    // ...
  }

  Future<bool> validatePin(String pin) async {
    // ...
  }
}
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Services ficam em infrastructure |
| 2 | Services são injetados via Provider |
| 3 | Services não possuem estado |
| 4 | Services são testáveis com mocks |

---

## Documentos Relacionados

- [11_UseCases.md](./11_UseCases.md)
- [07_DependencyInjection.md](./07_DependencyInjection.md)
