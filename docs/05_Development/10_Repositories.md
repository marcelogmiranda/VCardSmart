# Repositories

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Interface no Domain |
| 2 | Implementação em Data |
| 3 | Hive apenas na Infrastructure |
| 4 | UI nunca acessa Repository diretamente |

---

## Interface (Domain)

```dart
abstract class ProfileRepository {
  Future<UserProfile?> getProfile();
  Future<void> saveProfile(UserProfile profile);
  Future<void> deleteProfile();
}
```

---

## Implementação (Data)

```dart
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

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

  @override
  Future<void> deleteProfile() async {
    await dataSource.deleteProfile();
  }
}
```

---

## DataSource (Infrastructure)

```dart
class ProfileDataSource {
  final box = Hive.box('user_profile');

  Future<UserProfileModel?> getProfile() async {
    return box.get('profile');
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    await box.put('profile', profile);
  }

  Future<void> deleteProfile() async {
    await box.delete('profile');
  }
}
```

---

## Documentos Relacionados

- [02_CleanArchitecture.md](../04_Architecture/02_CleanArchitecture.md)
- [04_DependencyRules.md](../04_Architecture/04_DependencyRules.md)
- [12_Services.md](./12_Services.md)
