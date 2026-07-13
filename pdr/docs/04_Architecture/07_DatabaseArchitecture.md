# Database Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Banco de Dados

| Propriedade | Valor |
|-------------|-------|
| **Banco** | Hive |
| **Tipo** | NoSQL local |
| **Criptografia** | AES (opcional) |
| **Performance** | Alto |
| **Dependência** | Nenhuma (100% local) |

---

## Boxes (Tabelas)

| Box | Conteúdo | Chave |
|-----|----------|-------|
| `user_profile` | Perfil principal | `profile` |
| `settings` | Configurações gerais | Chaves fixas |
| `received_cards` | Cartões importados | UUID |
| `history` | Histórico de ações | UUID |
| `preferences` | Preferências detalhadas | Chaves fixas |
| `logs` | Logs locais | Timestamp |

---

## Estrutura de uma Box

### user_profile
```json
{
  "profile": {
    "id": "uuid",
    "fullName": "Nome Completo",
    "email": "email@exemplo.com",
    "phones": [
      {
        "id": "uuid",
        "label": "Celular",
        "number": "+55 11 99999-9999",
        "countryCode": "+55",
        "share": true,
        "whatsappEnabled": true
      }
    ],
    "companyName": "Empresa",
    "jobTitle": "Cargo",
    "website": "https://exemplo.com",
    "photoPath": "path/to/photo",
    "logoPath": "path/to/logo",
    "socialNetworks": [
      {"id": "uuid", "type": "linkedin", "url": "...", "share": true, "order": 1},
      {"id": "uuid", "type": "instagram", "url": "...", "share": true, "order": 2}
    ],
    "createdAt": "2026-07-13T00:00:00Z",
    "updatedAt": "2026-07-13T00:00:00Z"
  }
}
```

### settings
```json
{
  "theme": "system",
  "language": "pt",
  "biometricEnabled": false,
  "pinEnabled": false,
  "pin": null,
  "autoLock": true,
  "lockTimeout": 300,
  "shareConfirmation": true,
  "importConfirmation": true
}
```

### received_cards
```json
{
  "uuid": {
    "id": "uuid",
    "fullName": "Nome Completo",
    "email": "email@exemplo.com",
    "phones": [
      {
        "id": "uuid",
        "label": "Celular",
        "number": "+55 11 99999-9999",
        "countryCode": "+55",
        "share": true,
        "whatsappEnabled": true
      }
    ],
    "companyName": "Empresa",
    "jobTitle": "Cargo",
    "photoPath": "path/to/photo",
    "receivedAt": "2026-07-13T00:00:00Z",
    "source": "nfc",
    "rawVcard": "BEGIN:VCARD..."
  }
}
```

---

## Acesso ao Banco

### Regra Fundamental
> UI nunca acessa Hive diretamente. Acesso sempre via Repository.

### DataSource
```dart
class ProfileDataSource {
  final box = Hive.box('user_profile');

  Future<UserProfileModel?> getProfile() async {
    return box.get('profile');
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    await box.put('profile', profile);
  }
}
```

### Repository
```dart
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  @override
  Future<UserProfile?> getProfile() async {
    final model = await dataSource.getProfile();
    return model?.toEntity();
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    final model = UserProfileModel.fromEntity(profile);
    await dataSource.saveProfile(model);
  }
}
```

---

## Inicialização

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrar Adapters
  Hive.registerAdapter(UserProfileModelAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(ReceivedCardModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(PhoneModelAdapter());
  Hive.registerAdapter(SocialNetworkModelAdapter());

  // Abrir Boxes
  await Hive.openBox('user_profile');
  await Hive.openBox('settings');
  await Hive.openBox('received_cards');
  await Hive.openBox('history');
  await Hive.openBox('preferences');
  await Hive.openBox('logs');

  runApp(const ProviderScope(child: VCardSmartApp()));
}
```

---

## Migração de Versão

```dart
// Quando a estrutura de dados mudar
final box = await Hive.openBox('userProfile');
if (box.version == 1) {
  // Migração v1 → v2
  await migrateV1ToV2(box);
}
```

---

## Documentos Relacionados

- [08_LocalStorage.md](./08_LocalStorage.md)
- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
