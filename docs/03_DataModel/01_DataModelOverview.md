# Data Model Overview

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Visão Geral

| Propriedade | Valor |
|-------------|-------|
| **Banco** | Hive |
| **Persistência** | Offline (local) |
| **Criptografia** | AES-256 |
| **Formato** | JSON |
| **Serialização** | TypeAdapter |

---

## Objetivos do Modelo de Dados

| Objetivo | Como Alcançado |
|----------|---------------|
| **Performance** | Hive NoSQL com leitura/escrita rápida |
| **Simplicidade** | Estrutura flat, sem relações complexas |
| **Privacidade** | Armazenamento 100% local |
| **Evolução Controlada** | Schema versioning com migração |

---

## Estrutura Geral

```
Models
├── Entities (entidades de negócio)
├── Value Objects (objetos de valor)
├── DTOs (data transfer objects)
└── TypeAdapters (serialização Hive)
```

---

## Fluxo de Dados

```
UI (Presentation)
    ↓
Controller (Application)
    ↓
Use Case (Domain)
    ↓
Repository (Data)
    ↓
DataSource (Hive)
    ↓
TypeAdapter (Serialização)
```

---

## Regras Fundamentais

| # | Regra |
|---|-------|
| 1 | UI nunca acessa Hive diretamente |
| 2 | Todo acesso via Repository |
| 3 | Models possuem TypeAdapter |
| 4 | Entidades possuem UUID v4 |
| 5 | Timestamps obrigatórios (createdAt, updatedAt) |
| 6 | Schema version em toda entidade |

---

## Documentos Relacionados

- [02_HiveArchitecture.md](./02_HiveArchitecture.md)
- [03_Entities.md](./03_Entities.md)
- [04_ValueObjects.md](./04_ValueObjects.md)
- [05_DTOs.md](./05_DTOs.md)
