# UseCases

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Princípio

> Cada ação do sistema = Um UseCase

---

## Padrão

```dart
class VerbNounUseCase {
  final Repository repository;

  VerbNounUseCase(this.repository);

  Future<Result<Type>> call(Params params) async {
    // Lógica de negócio
  }
}
```

---

## Exemplos

### GetProfileUseCase
```dart
class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserProfile?> call() async {
    return await repository.getProfile();
  }
}
```

### SaveProfileUseCase
```dart
class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> call(UserProfile profile) async {
    await repository.saveProfile(profile);
  }
}
```

### GenerateQRCodeUseCase
```dart
class GenerateQRCodeUseCase {
  final VCardGenerator vCardGenerator;

  GenerateQRCodeUseCase(this.vCardGenerator);

  String call(UserProfile profile) {
    return vCardGenerator.generate(profile);
  }
}
```

### ShareNFCUseCase
```dart
class ShareNFCUseCase {
  final NfcService nfcService;

  ShareNFCUseCase(this.nfcService);

  Future<void> call(UserProfile profile) async {
    await nfcService.transmit(profile);
  }
}
```

### ImportVCardUseCase
```dart
class ImportVCardUseCase {
  final ReceivedCardsRepository repository;

  ImportVCardUseCase(this.repository);

  Future<void> call(ReceivedCard card) async {
    await repository.saveCard(card);
  }
}
```

---

## Lista de UseCases

| Feature | UseCase |
|---------|---------|
| Profile | GetProfileUseCase |
| Profile | SaveProfileUseCase |
| Profile | DeleteProfileUseCase |
| Sharing | ShareNFCUseCase |
| Sharing | ShareQRUseCase |
| Sharing | ShareWhatsAppUseCase |
| QR Code | GenerateQRCodeUseCase |
| QR Code | ReadQRCodeUseCase |
| NFC | TransmitNFCUseCase |
| NFC | ReceiveNFCUseCase |
| vCard | GenerateVCardUseCase |
| vCard | ImportVCardUseCase |
| Contacts | GetContactsUseCase |
| Contacts | SaveContactUseCase |
| Settings | GetSettingsUseCase |
| Settings | SaveSettingsUseCase |

---

## Documentos Relacionados

- [02_CleanArchitecture.md](../04_Architecture/02_CleanArchitecture.md)
- [13_Providers.md](./13_Providers.md)
