# Prontidão para API — VCardSmart

## Visão Geral

O VCardSmart não possui API na versão 1, mas a arquitetura já está preparada para suportar no futuro.

## Estado Atual

### Versão 1

| Componente | Status |
|------------|--------|
| API | ❌ Não implementada |
| Repository Pattern | ✅ Implementado |
| DTOs | ✅ Implementados |
| Versionamento | ✅ Implementado |
| JSON Contracts | ✅ Implementados |

## Preparação

### Repository Pattern

```dart
// Interface para repositório
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}

// Implementação local
class LocalProfileRepository implements ProfileRepository {
  // Hive implementation
}

// Implementação cloud (futuro)
class CloudProfileRepository implements ProfileRepository {
  // API implementation
}
```

### DTOs

```dart
// Data Transfer Object
class ProfileDTO {
  final String id;
  final String name;
  final String title;
  final List<SocialLinkDTO> socialLinks;
  
  factory ProfileDTO.fromDomain(Profile profile) {
    return ProfileDTO(
      id: profile.id,
      name: profile.name,
      title: profile.title,
      socialLinks: profile.socialLinks
          .map((sl) => SocialLinkDTO.fromDomain(sl))
          .toList(),
    );
  }
  
  Profile toDomain() {
    return Profile(
      id: id,
      name: name,
      title: title,
      socialLinks: socialLinks.map((sl) => sl.toDomain()).toList(),
    );
  }
}
```

### Versionamento

```dart
// Versão do modelo de dados
const int currentVersion = 1;

// Migração entre versões
class DatabaseMigrator {
  static Future<void> migrate(int fromVersion, int toVersion) async {
    for (var version = fromVersion; version < toVersion; version++) {
      await _migrateToVersion(version + 1);
    }
  }
  
  static Future<void> _migrateToVersion(int version) async {
    switch (version) {
      case 2:
        // Migração para versão 2
        break;
      // ...
    }
  }
}
```

### JSON Contracts

```dart
// Contrato JSON para API
class ProfileContract {
  static Map<String, dynamic> toJson(Profile profile) {
    return {
      'id': profile.id,
      'name': profile.name,
      'title': profile.title,
      'social_links': profile.socialLinks
          .map((sl) => SocialLinkContract.toJson(sl))
          .toList(),
      'created_at': profile.createdAt.toIso8601String(),
      'updated_at': profile.updatedAt.toIso8601String(),
    };
  }
  
  static Profile fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      socialLinks: (json['social_links'] as List)
          .map((sl) => SocialLinkContract.fromJson(sl))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
```

## API Futura

### Endpoints Planejados

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /profiles | Listar perfis |
| GET | /profiles/:id | Obter perfil |
| POST | /profiles | Criar perfil |
| PUT | /profiles/:id | Atualizar perfil |
| DELETE | /profiles/:id | Excluir perfil |
| POST | /profiles/:id/share | Compartilhar perfil |
| POST | /profiles/:id/import | Importar perfil |

### Autenticação

| Método | Descrição |
|--------|-----------|
| API Key | Para aplicações |
| OAuth2 | Para usuários |
| JWT | Tokens de acesso |

### Versionamento

| Estratégia | Descrição |
|------------|-----------|
| URL | /api/v1/profiles |
| Header | Accept-Version: 1 |
| Query | ?version=1 |

## Roadmap de API

### v3.0 — API Básica

- [ ] Endpoints CRUD
- [ ] Autenticação API Key
- [ ] Documentação OpenAPI
- [ ] Rate limiting

### v3.1 — API Avançada

- [ ] OAuth2
- [ ] Webhooks
- [ ] SDKs
- [ ] Exemplos

### v4.0 — API Completa

- [ ] Marketplace API
- [ ] Enterprise API
- [ ] IA API
- [ ] Integrações

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Uptime | > 99.9% |
| Latência | < 200ms |
| Throughput | > 1.000 req/s |
| Erros | < 0.1% |
