# Architecture Layers

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Camadas

```
Presentation  (UI)
      ↓
Application   (Controllers/Providers)
      ↓
Domain        (Use Cases / Business Logic)
      ↓
Data          (Repositories / Models / DataSources)
      ↓
Infrastructure (Plugins / Hive / Hardware)
```

---

## Regras de Dependência

| Camada | Pode Importar | Não Pode Importar |
|--------|--------------|-------------------|
| **Presentation** | Application, Domain | Data, Infrastructure |
| **Application** | Domain | Presentation, Data |
| **Domain** | Nada (apenas shared) | Flutter, Material, Hive |
| **Data** | Domain, Infrastructure | Presentation |
| **Infrastructure** | Data | Presentation, Domain |

---

## Responsabilidades

### Presentation
- Widgets e Pages
- Controllers (StateNotifier)
- Providers

### Application
- Use Cases
- Coordenação entre camadas

### Domain
- Entities
- Repository interfaces
- Value Objects
- Regras de negócio

### Data
- Repository implementations
- Models
- DataSources
- Mappers

### Infrastructure
- Plugins (NFC, QR, Camera)
- Hive
- Plataforma

---

## Documentos Relacionados

- [02_CleanArchitecture.md](../04_Architecture/02_CleanArchitecture.md)
- [04_DependencyRules.md](../04_Architecture/04_DependencyRules.md)
- [07_DependencyInjection.md](./07_DependencyInjection.md)
