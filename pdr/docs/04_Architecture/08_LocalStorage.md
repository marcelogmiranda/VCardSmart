# Local Storage

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estratégia de Armazenamento

| Propriedade | Valor |
|-------------|-------|
| **Banco** | Hive |
| **Criptografia** | AES (dados sensíveis) |
| **Cloud** | ❌ Nunca |
| **Backup** | ❌ Nunca (V1) |
| **Sincronização** | ❌ Nunca |

---

## Regras de Armazenamento

| Regra | Descrição |
|-------|-----------|
| **Local Only** | Todo armazenamento é no dispositivo |
| **Hive Only** | Apenas Hive como banco de dados |
| **No Cloud** | Nenhum dado sai do dispositivo |
| **No Backup** | Sem backup em nuvem (V1) |
| **No Sync** | Sem sincronização entre dispositivos |
| **Delete = Gone** | Ao desinstalar, todos os dados desaparecem |

---

## Criptografia

### Hive AES Encryption
```dart
// Abrir box com criptografia
final encryptedBox = await Hive.openBox(
  'sensitiveData',
  encryptionCipher: HiveAesCipher(),
);
```

### Dados Criptografados
| Dado | Criptografado |
|------|---------------|
| PIN | ✅ |
| Token de sessão (se houver) | ✅ |
| Dados biométricos | ❌ (nunca armazenados) |
| Perfil | ❌ (não é sensível) |
| Configurações | ❌ |
| Contatos recebidos | ❌ |

---

## Ciclo de Vida dos Dados

```
Criação → Armazenamento (Hive) → Uso → Exclusão
```

### Exclusão ao Desinstalar
```dart
// Hive armazena em diretório do app
// Ao desinstalar, SO remove todos os dados automaticamente
```

---

## Backup (Cancelado em V1)

| Status | Descrição |
|--------|-----------|
| ❌ Cancelado | Backup não será implementado em V1 |
| Motivo | Manter princípio de zero cloud |
| Futuro | V5 pode incluir backup opcional |

---

## Armazenamento por Feature

| Feature | Box | Tipo |
|---------|-----|------|
| Perfil | `userProfile` | JSON |
| Configurações | `settings` | JSON |
| Contatos | `contacts` | JSON |
| Histórico | `history` | JSON |
| Templates | `templates` | JSON |
| Cache | `cache` | JSON |

---

## Tamanho Estimado

| Dado | Tamanho Estimado |
|------|-----------------|
| Perfil (sem foto) | ~1 KB |
| Perfil (com foto) | ~100 KB |
| Contato recebido | ~2 KB |
| Configurações | ~0.5 KB |
| **Total típico** | **~500 KB** |

---

## Documentos Relacionados

- [07_DatabaseArchitecture.md](./07_DatabaseArchitecture.md)
- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
- [18_OfflineStrategy.md](./18_OfflineStrategy.md)
