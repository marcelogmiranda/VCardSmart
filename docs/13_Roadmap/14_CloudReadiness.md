# Prontidão para Cloud — VCardSmart

## Visão Geral

O VCardSmart é offline-first, mas a arquitetura já está preparada para suportar sincronização opcional no futuro.

## Estado Atual

### Versão 1

| Componente | Status |
|------------|--------|
| Cloud | ❌ Não implementada |
| Repository Pattern | ✅ Implementado |
| Sync Engine | ✅ Interface definida |
| Conflict Resolution | ✅ Interface definida |
| Encryption | ✅ Implementado |

## Princípios

### 1. Cloud Opcional

A sincronização nunca será obrigatória. O usuário decidirá se deseja utilizá-la.

### 2. Offline Sempre Prioritário

Mesmo com futuras integrações online, o funcionamento offline continuará sendo um requisito obrigatório.

### 3. Zero Alteração Arquitetural

A adição de cloud não deve quebrar a arquitetura atual.

## Preparação

### Repository Pattern

```dart
// Interface
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

// Implementação cloud
class CloudProfileRepository implements ProfileRepository {
  // API implementation
}

// Implementação com sync
class SyncProfileRepository implements ProfileRepository {
  final LocalProfileRepository local;
  final CloudProfileRepository cloud;
  final SyncEngine syncEngine;
  
  // Sync logic
}
```

### Sync Engine

```dart
// Interface
abstract class SyncEngine {
  Future<void> sync();
  Future<SyncStatus> getStatus();
  Stream<SyncEvent> get events;
}

// Implementação
class DefaultSyncEngine implements SyncEngine {
  final LocalDatabase local;
  final CloudService cloud;
  final ConflictResolver resolver;
  
  @override
  Future<void> sync() async {
    // 1. Detectar mudanças locais
    // 2. Detectar mudanças na nuvem
    // 3. Resolver conflitos
    // 4. Sincronizar
  }
}
```

### Conflict Resolution

```dart
// Interface
abstract class ConflictResolver {
  Future<Conflict> detectConflict(LocalData local, CloudData cloud);
  Future<Resolution> resolve(Conflict conflict);
}

// Estratégias
class LastWriteWinsResolver implements ConflictResolver {
  @override
  Future<Resolution> resolve(Conflict conflict) {
    // Última escrita vence
  }
}

class ManualResolver implements ConflictResolver {
  @override
  Future<Resolution> resolve(Conflict conflict) {
    // Usuário decide
  }
}
```

### Encryption

```dart
// Criptografia de dados sincronizados
class CloudEncryption {
  final SecureStorage storage;
  
  Future<EncryptedData> encrypt(Profile profile) async {
    final key = await storage.getKey();
    return AES256Encrypter.encrypt(profile.toJson(), key);
  }
  
  Future<Profile> decrypt(EncryptedData data) async {
    final key = await storage.getKey();
    final json = AES256Encrypter.decrypt(data, key);
    return Profile.fromJson(json);
  }
}
```

## Funcionalidades Cloud

### Backup Criptografado

| Campo | Valor |
|-------|-------|
| Prioridade | P1 |
| Versão | 2.1 |
| Descrição | Backup seguro na nuvem |

### Sincronização Opcional

| Campo | Valor |
|-------|-------|
| Prioridade | P2 |
| Versão | 3.0 |
| Descrição | Sincronizar entre dispositivos |

### Multi-device

| Campo | Valor |
|-------|-------|
| Prioridade | P2 |
| Versão | 3.0 |
| Descrição | Usar em vários dispositivos |

## Roadmap Cloud

### v2.1 — Backup

- [ ] Backup criptografado
- [ ] Restauração
- [ ] Gerenciamento de backups

### v3.0 — Sincronização

- [ ] Sync engine
- [ ] Conflict resolution
- [ ] Multi-device
- [ ] Status de sincronização

### v3.1 — Avançado

- [ ] Sync incremental
- [ ] Sync em background
- [ ] Retry automático
- [ ] Métricas de sync

## Segurança

### Princípios

1. **Criptografia**: Dados sempre criptografados
2. **Zero Knowledge**: Servidor não acessa dados
3. **Controle**: Usuário decide o que sincronizar
4. **Transparência**: Usuário sabe o que acontece

### Implementação

```dart
// Dados criptografados antes de enviar
class SecureCloudService {
  final CloudEncryption encryption;
  final CloudApi api;
  
  Future<void> upload(Profile profile) async {
    final encrypted = await encryption.encrypt(profile);
    await api.upload(encrypted);
  }
  
  Future<Profile> download(String id) async {
    final encrypted = await api.download(id);
    return await encryption.decrypt(encrypted);
  }
}
```

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Uptime | > 99.9% |
| Latência sync | < 5s |
| Conflitos | < 1% |
| Satisfação | > 4.5 |

## ADR Relacionados

| ADR | Descrição |
|-----|-----------|
| ADR-039 | Offline Sempre Prioritário |
| ADR-040 | Cloud Opcional |
