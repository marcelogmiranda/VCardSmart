# Contexto do Projeto — VCardSmart

## Visão Geral

Contexto completo do projeto para orientar IA.

## Identificação

| Campo | Valor |
|-------|-------|
| Nome | VCardSmart |
| Descrição | Cartão de visitas digital offline |
| Versão | 1.0 |
| Plataformas | Android, iOS |

## Pilares

1. **Privacidade**: Sem coleta de dados
2. **Offline First**: Funciona sem internet
3. **Simplicidade**: Sem login, sem conta
4. **Segurança**: Criptografia e biometria
5. **Qualidade**: Material Design 3

## Stack Tecnológica

| Componente | Tecnologia |
|------------|------------|
| Framework | Flutter 3.x |
| Linguagem | Dart 3.x |
| State Management | Riverpod |
| Navigation | GoRouter |
| Local Storage | Hive (AES-256) |
| Secure Storage | Flutter Secure Storage |
| UI | Material Design 3 |
| Testes | flutter_test, integration_test |

## Arquitetura

### Padrão

- Clean Architecture
- Repository Pattern
- UseCase Pattern
- Feature-based Organization

### Camadas

```
┌─────────────────────────────────────┐
│         Presentation                │
│  Pages, Widgets, Providers          │
├─────────────────────────────────────┤
│           Domain                    │
│  Entities, UseCases, Repositories   │
├─────────────────────────────────────┤
│            Data                     │
│  Datasources, Models, Repositories  │
└─────────────────────────────────────┘
```

## Estrutura de Pastas

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── router/
│   ├── utils/
│   └── errors/
├── features/
│   └── [feature]/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── pages/
│           ├── widgets/
│           └── providers/
└── l10n/
```

## Features

### v1.0 — MVP

| Feature | Status |
|---------|--------|
| Profile | ✅ |
| QR Code | ✅ |
| NFC | ✅ |
| Import | ✅ |
| vCard | ✅ |
| Biometric | ✅ |
| PIN | ✅ |
| Theme | ✅ |
| Localization | ✅ |
| History | ⏳ |
| Suggestions | ⏳ |

### v2.0 — Premium

| Feature | Status |
|---------|--------|
| No Ads | ⏳ |
| Multiple Cards | ⏳ |
| Templates | ⏳ |
| Custom QR | ⏳ |
| Encrypted Backup | ⏳ |
| Advanced Export | ⏳ |
| Widget | ⏳ |
| Apple Watch | ⏳ |
| Wear OS | ⏳ |

## Regras de Negócio

### RB-001: Perfil

- Nome é obrigatório
- Email é opcional
- Telefone é opcional
- LinkedIn é opcional
- Website é opcional
- Bio é opcional

### RB-002: Compartilhamento

- QR Code sempre disponível
- NFC requer dispositivo compatível
- vCard é formato padrão

### RB-003: Importação

- Dados são validados
- duplicados são ignorados
- Histórico é mantido

### RB-004: Segurança

- Biometria é opcional
- PIN é opcional
- Criptografia é obrigatória

## ADRs

| ADR | Descrição |
|-----|-----------|
| ADR-001 | Arquitetura Base |
| ADR-002 | State Management |
| ADR-003 | Navigation |
| ADR-004 | Local Storage |
| ADR-005 | Security |
| ... | ... |
| ADR-043 | Marca Consistente |

## Restrições

### Técnicas

- Min SDK: 21 (Android), 12.0 (iOS)
- Target SDK: 34 (Android), 17.0 (iOS)
- Arquitetura: arm64-v8a, armeabi-v7a

### de Negócio

- Sem coleta de dados
- Sem analytics
- Sem rastreamento
- Offline First

### de Segurança

- Criptografia AES-256
- Biometria via secure storage
- PIN via secure storage
- Sem logs sensíveis
