# Hive Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Boxes (Tabelas)

| Box | Conteúdo | Chave Principal |
|-----|----------|-----------------|
| `user_profile` | Perfil do usuário | `profile` |
| `settings` | Configurações do app | `theme`, `language`, `security` |
| `received_cards` | Cartões importados | UUID de cada cartão |
| `history` | Histórico de compartilhamentos | UUID de cada registro |
| `preferences` | Preferências detalhadas | Categorias |
| `logs` | Logs locais (debug) | Timestamp |

---

## Estrutura de Cada Box

### user_profile
```json
{
  "profile": {
    "id": "uuid-v4",
    "fullName": "Nome Completo",
    "companyName": "Empresa",
    "jobTitle": "Cargo",
    "presentation": "Mensagem de apresentação",
    "photoPath": "caminho/foto.jpg",
    "logoPath": "caminho/logo.jpg",
    "email": "email@exemplo.com",
    "website": "https://exemplo.com",
    "phones": [],
    "socialNetworks": [],
    "preferredLanguage": "pt",
    "themeMode": "system",
    "shareOptions": {},
    "securityOptions": {},
    "createdAt": "2026-07-13T00:00:00Z",
    "updatedAt": "2026-07-13T00:00:00Z",
    "schemaVersion": "1.0"
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
  "autoLock": true,
  "lockTimeout": 300,
  "shareConfirmation": true,
  "importConfirmation": true
}
```

### received_cards
```json
{
  "uuid-card-1": {
    "id": "uuid-v4",
    "fullName": "Maria Santos",
    "email": "maria@exemplo.com",
    "phones": [],
    "companyName": "Empresa",
    "receivedAt": "2026-07-13T00:00:00Z",
    "source": "nfc",
    "rawVcard": "BEGIN:VCARD..."
  }
}
```

---

## Acesso ao Banco

### Regra
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

## Documentos Relacionados

- [01_DataModelOverview.md](./01_DataModelOverview.md)
- [08_HiveBoxes.md](./08_HiveBoxes.md)
- [07_DatabaseArchitecture.md](../04_Architecture/07_DatabaseArchitecture.md)
