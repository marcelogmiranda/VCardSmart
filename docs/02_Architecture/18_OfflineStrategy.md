# Offline Strategy

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Princípio

**Offline First:** Todas as funcionalidades funcionam 100% offline. Nenhuma dependência de internet.

---

## Estratégia

| Componente | Estratégia |
|------------|-----------|
| **Armazenamento** | Hive (local) |
| **Processamento** | Local |
| **Compartilhamento** | NFC / QR Code (local) |
| **Backup** | Não (V1) |
| **Sincronização** | Não |
| **APIs** | Nenhuma |
| **Backend** | Nenhum |

---

## O que é 100% Offline

| Funcionalidade | Offline |
|---------------|---------|
| Cadastro de perfil | ✅ |
| Edição de perfil | ✅ |
| Compartilhamento NFC | ✅ |
| Geração de QR Code | ✅ |
| Leitura de QR Code | ✅ |
| Geração de vCard | ✅ |
| Importação de vCard | ✅ |
| Biometria/PIN | ✅ |
| Temas | ✅ |
| Internacionalização | ✅ |
| Compartilhamento WhatsApp | ✅ |
| Anúncios | ⚠️ Requer internet |

---

## Anúncios (Única Exceção)

| Situação | Comportamento |
|----------|---------------|
| Sem internet | Anúncios não são exibidos |
| Com internet | Anúncios são exibidos |
| Funcionalidade afetada | Apenas monetização |

---

## Sem APIs

| Tipo | Status |
|------|--------|
| REST API | ❌ Não utilizado |
| GraphQL | ❌ Não utilizado |
| WebSocket | ❌ Não utilizado |
| Firebase | ❌ Não utilizado |
| Qualquer HTTP | ❌ Não utilizado |

---

## Sem Backend

| Componente | Status |
|-----------|--------|
| Servidor | ❌ Não existe |
| Banco de dados remoto | ❌ Não existe |
| Autenticação remota | ❌ Não existe |
| Processamento remoto | ❌ Não existe |

`

---

## Impacto na Arquitetura

| Camada | Impacto |
|--------|---------|
| **Data** | Repositories usam apenas Hive |
| **Infrastructure** | Plugins são locais (NFC, QR, Camera) |
| **Domain** | Use Cases são independentes |
| **Presentation** | UI não depende de estado de rede |

---

## Verificação de Offline

```dart
// ❌ INCORRETO - Não verificar internet
final response = await http.get(Uri.parse('https://api.example.com'));

// ✅ CORRETO - Não fazer requisições HTTP
final profile = await profileRepository.getProfile();
```

---

## Documentos Relacionados

- [08_LocalStorage.md](./08_LocalStorage.md)
- [07_DatabaseArchitecture.md](./07_DatabaseArchitecture.md)
- [09_NFCArchitecture.md](./09_NFCArchitecture.md)
- [18_OfflineStrategy.md](./18_OfflineStrategy.md)
