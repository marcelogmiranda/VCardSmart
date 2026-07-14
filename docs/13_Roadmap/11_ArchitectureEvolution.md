# Evolução da Arquitetura — VCardSmart

## Visão Geral

A arquitetura do VCardSmart foi projetada para evoluir sem quebras, suportando futuras funcionalidades e integrações.

## Princípios

### 1. Evolução sem Refatoração

Toda nova funcionalidade deverá reutilizar a arquitetura existente.

### 2. Preparação desde a Versão 1

A arquitetura já suporta:

- Múltiplos cartões
- Sincronização
- Cloud
- Empresas
- Equipes
- API
- Widgets
- Integrações
- IA

### 3. Zero Alteração Arquitetural

Novas funcionalidades não devem quebrar a arquitetura atual.

## Componentes Prepados

### Repository Pattern

```dart
// Interface
abstract class ProfileRepository {
  Future<Profile> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}

// Implementação Local
class LocalProfileRepository implements ProfileRepository {
  // Implementação atual (Hive)
}

// Implementação Cloud (futuro)
class CloudProfileRepository implements ProfileRepository {
  // Implementação futura (API)
}
```

### DTOs

```dart
// DTO para serialização
class ProfileDTO {
  final String id;
  final String name;
  final String title;
  final List<SocialLinkDTO> socialLinks;
  // ...
  
  factory ProfileDTO.fromDomain(Profile profile) {
    // Conversão
  }
  
  Profile toDomain() {
    // Conversão
  }
}
```

### Versionamento

```dart
// Versão do modelo de dados
const int currentVersion = 1;

// Migração
class DatabaseMigrator {
  static Future<void> migrate(int fromVersion, int toVersion) async {
    // Migração entre versões
  }
}
```

### JSON Contracts

```dart
// Contrato JSON para API futura
class ProfileContract {
  static Map<String, dynamic> toJson(Profile profile) {
    return {
      'id': profile.id,
      'name': profile.name,
      'title': profile.title,
      // ...
    };
  }
  
  static Profile fromJson(Map<String, dynamic> json) {
    // Conversão
  }
}
```

## Funcionalidades Futuras Suportadas

### Múltiplos Cartões

**Status**: Preparado

```dart
// Já suporta múltiplos perfis
class ProfileService {
  Future<List<Profile>> getAllProfiles();
  Future<Profile> createProfile(ProfileData data);
}
```

### Sincronização

**Status**: Preparado

```dart
// Repository pattern permite sync
abstract class SyncEngine {
  Future<void> sync();
  Future<Conflict> resolveConflict(Conflict conflict);
}
```

### Cloud

**Status**: Preparado

```dart
// Interface para cloud
abstract class CloudService {
  Future<void> upload(Profile profile);
  Future<Profile> download(String id);
  Future<void> delete(String id);
}
```

### Empresas

**Status**: Preparado

```dart
// Suporte a organizações
class Organization {
  final String id;
  final String name;
  final List<String> memberIds;
  final Policies policies;
}
```

### Equipes

**Status**: Preparado

```dart
// Suporte a equipes
class Team {
  final String id;
  final String name;
  final String organizationId;
  final List<String> memberIds;
}
```

### API

**Status**: Preparado

```dart
// Contratos JSON prontos
class ApiContracts {
  static Map<String, dynamic> profileToJson(Profile profile);
  static Profile profileFromJson(Map<String, dynamic> json);
}
```

### Widgets

**Status**: Preparado

```dart
// Service layer separado
class WidgetService {
  Future<Profile> getDefaultProfile();
  Future<void> updateWidget();
}
```

### Integrações

**Status**: Preparado

```dart
// Interfaces para integrações
abstract class Integration {
  Future<void> connect();
  Future<void> disconnect();
  Future<void> sync();
}
```

### IA

**Status**: Preparado

```dart
// Interfaces para IA
abstract class AIService {
  Future<Profile> suggestProfile(Map<String, dynamic> data);
  Future<List<Profile>> classifyCards(List<Profile> cards);
  Future<String> generateDescription(Profile profile);
}
```

## Roadmap de Evolução

### Curto Prazo (v1.x)

- [x] Repository Pattern
- [x] DTOs
- [x] Versionamento
- [x] JSON Contracts

### Médio Prazo (v2.x)

- [ ] Múltiplos cartões
- [ ] Templates
- [ ] Widget
- [ ] Backup

### Longo Prazo (v3.x+)

- [ ] Sincronização
- [ ] Cloud
- [ ] API
- [ ] Empresas
- [ ] Equipes
- [ ] IA

## ADR Relacionados

| ADR | Descrição |
|-----|-----------|
| ADR-037 | Evolução sem Refatoração |
| ADR-038 | Premium como Extensão |
| ADR-039 | Offline Sempre Prioritário |
| ADR-040 | Cloud Opcional |

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Breaking changes | 0 por versão |
| Migrações automáticas | 100% |
| Tempo de adaptação | < 1 sprint |
| Testes de compatibilidade | 100% passando |
