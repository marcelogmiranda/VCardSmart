# Sprint 3 — Local Database

## Objetivo

Implementar o banco de dados local com Hive.

## Pré-requisitos

- Sprint 2 concluída
- Design System implementado

## Documentos Obrigatórios

- Architecture.md
- DataModel.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── database/
│       ├── hive_service.dart
│       ├── hive_boxes.dart
│       └── hive_adapters.dart
├── features/
│   └── profile/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── profile_local_datasource.dart
│       │   ├── models/
│       │   │   └── profile_model.dart
│       │   └── repositories/
│       │       └── local_profile_repository.dart
│       └── domain/
│           ├── entities/
│           │   └── profile.dart
│           └── repositories/
│               └── profile_repository.dart
```

### Arquivos Alterados

- pubspec.yaml

## Modelos

### profile.dart (Entity)

```dart
class Profile {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? linkedin;
  final String? website;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Profile({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.linkedin,
    this.website,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });
}
```

### profile_model.dart

```dart
@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String? email;
  
  @HiveField(3)
  final String? phone;
  
  @HiveField(4)
  final String? linkedin;
  
  @HiveField(5)
  final String? website;
  
  @HiveField(6)
  final String? bio;
  
  @HiveField(7)
  final DateTime createdAt;
  
  @HiveField(8)
  final DateTime updatedAt;
  
  ProfileModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.linkedin,
    this.website,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      linkedin: json['linkedin'],
      website: json['website'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'linkedin': linkedin,
      'website': website,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  Profile toDomain() {
    return Profile(
      id: id,
      name: name,
      email: email,
      phone: phone,
      linkedin: linkedin,
      website: website,
      bio: bio,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  factory ProfileModel.fromDomain(Profile profile) {
    return ProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
      phone: profile.phone,
      linkedin: profile.linkedin,
      website: profile.website,
      bio: profile.bio,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
```

### profile_repository.dart (Interface)

```dart
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}
```

### local_profile_repository.dart

```dart
class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource dataSource;
  
  LocalProfileRepository(this.dataSource);
  
  @override
  Future<Profile> getProfile(String id) async {
    final model = await dataSource.getProfile(id);
    return model.toDomain();
  }
  
  @override
  Future<List<Profile>> getAllProfiles() async {
    final models = await dataSource.getAllProfiles();
    return models.map((m) => m.toDomain()).toList();
  }
  
  @override
  Future<void> saveProfile(Profile profile) async {
    final model = ProfileModel.fromDomain(profile);
    await dataSource.saveProfile(model);
  }
  
  @override
  Future<void> deleteProfile(String id) async {
    await dataSource.deleteProfile(id);
  }
}
```

### hive_service.dart

```dart
class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(ProfileModelAdapter());
    
    // Open boxes
    await Hive.openBox<ProfileModel>(AppConstants.profileBox);
  }
  
  static Box<ProfileModel> get profileBox {
    return Hive.box<ProfileModel>(AppConstants.profileBox);
  }
}
```

## Critérios de Aceitação

- [x] Hive configurado
- [x] Adapters criados
- [x] Entity criada
- [x] Model criada
- [x] DataSource criada
- [x] Repository Interface criada
- [x] Repository Implementation criada
- [x] Criptografia configurada
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Hive configurado
- [x] Adapters criados
- [x] Entity criada
- [x] Model criada
- [x] DataSource criada
- [x] Repository Interface criada
- [x] Repository Implementation criada
- [x] Criptografia configurada
- [x] Build funcionando
- [x] Testes passando (54/54)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (100%)
- [x] CHANGELOG atualizado (v1.3.0)

## Próxima Sprint

Sprint 4 — Profile Module
