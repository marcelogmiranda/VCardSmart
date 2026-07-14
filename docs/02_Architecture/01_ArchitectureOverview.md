# Architecture Overview

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Arquitetura Principal

```
Flutter
    ↓
Clean Architecture
    ↓
SOLID
    ↓
Feature First
    ↓
Offline First
    ↓
Hive
    ↓
Material Design 3
    ↓
Riverpod
    ↓
GoRouter
```

---

## Pilha Tecnológica

| Camada | Tecnologia | Responsabilidade |
|--------|-----------|-----------------|
| **Framework** | Flutter | UI multiplataforma |
| **Linguagem** | Dart | Lógica de programação |
| **Arquitetura** | Clean Architecture | Separação de responsabilidades |
| **Padrões** | SOLID | Design de software |
| **Organização** | Feature First | Modularização por funcionalidade |
| **Estratégia** | Offline First | Funcionamento sem internet |
| **Banco** | Hive | Armazenamento local |
| **UI** | Material Design 3 | Design visual |
| **Estado** | Riverpod | Gerenciamento de estado |
| **Navegação** | GoRouter | Rotas e navegação |

---

## Objetivos Arquiteturais

| Objetivo | Como Alcançado |
|----------|---------------|
| **Escalabilidade** | Feature First + Clean Architecture permite adicionar funcionalidades sem impactar existentes |
| **Baixo Acoplamento** | Dependências apontam somente para dentro. Camadas isoladas |
| **Alta Coesão** | Cada módulo tem responsabilidade única e bem definida |
| **Testabilidade** | Clean Architecture permite testar cada camada isoladamente |
| **Modularidade** | Features independentes podem ser desenvolvidas em paralelo |
| **Performance** | Hive + lazy loading + const widgets + rebuild mínimo |

---

## Princípios Fundamentais

### 1. Offline First
Todas as funcionalidades funcionam 100% offline. Nenhuma dependência de internet.

### 2. Privacy First
Nenhum dado sai do dispositivo. Sem analytics, sem cloud, sem rastreamento.

### 3. Clean Architecture
Separação estrita de responsabilidades entre camadas. Dependências sempre apontam para dentro.

### 4. SOLID
Princípios de design orientado a objeto aplicados em toda a codebase.

### 5. Feature First
Cada funcionalidade é um módulo independente com suas próprias camadas.

---

## Fluxo de Dados

```
Usuário interage com UI (Presentation)
    ↓
Controller/Provider processa (Application)
    ↓
Use Case executa regra de negócio (Domain)
    ↓
Repository implementa acesso (Data)
    ↓
DataSource/Hive armazena (Infrastructure)
```

---

## Visão de Camadas

| Camada | Conteúdo | Regra |
|--------|----------|-------|
| **Presentation** | Pages, Widgets, Controllers | Nunca acessa Hive nem Plugins |
| **Application** | Providers, State Notifiers | Conhece apenas Domain |
| **Domain** | Use Cases, Entities, Repository interfaces | Nunca conhece Flutter |
| **Data** | Repository implementations, Models, DataSources | Implementa interfaces do Domain |
| **Infrastructure** | Plugins, Hive, NFC, QR, Camera | Contém toda interação com hardware |

---

## Documentos Relacionados

- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
- [03_ProjectStructure.md](./03_ProjectStructure.md)
- [04_DependencyRules.md](./04_DependencyRules.md)
- [05_StateManagement.md](./05_StateManagement.md)
- [21_ArchitectureDecisionRecords.md](./21_ArchitectureDecisionRecords.md)
