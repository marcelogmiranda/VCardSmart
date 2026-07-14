# VCardSmart

## Cartão de Visita Digital

**Versão:** 1.0.0

---

## Objetivo

O VCardSmart é um aplicativo multiplataforma (Android e iOS) desenvolvido em Flutter que permite compartilhar cartões de visita digitais de maneira segura, privada e totalmente offline.

Todo o armazenamento ocorre exclusivamente no dispositivo do usuário utilizando Hive Database.

- Não existe armazenamento em nuvem.
- Não existe login.
- Não existe sincronização.
- Não existe coleta de dados.

O aplicativo foi concebido utilizando o conceito **Offline First**.

---

## Características

- Flutter + Dart
- Clean Architecture
- Material Design 3
- Riverpod (State Management)
- GoRouter (Navigation)
- Hive Database (Armazenamento local com AES-256)
- NFC (Compartilhamento por proximidade)
- QR Code (Compartilhamento visual)
- vCard (Formato padrão de contato)
- Biometria + PIN (Autenticação)
- Internacionalização (pt-BR, en, es)
- AdMob (Monetização)

---

## Princípios

- **Offline First** — Tudo funciona sem internet
- **Privacy First** — Zero dados coletados
- **Security First** — Criptografia AES-256, biometria, PIN
- **AI Driven Development** — Desenvolvimento assistido por IA
- **Documentation First** — Documentação completa antes do código

---

## Estrutura do Projeto

```
VCardSmart/
├── app/                    # Código Flutter
│   ├── lib/                # Código fonte
│   │   ├── core/           # Configurações centrais
│   │   ├── data/           # Data layer
│   │   ├── features/       # Features por módulo
│   │   ├── infrastructure/ # Infraestrutura
│   │   └── shared/         # Componentes compartilhados
│   ├── test/               # Testes unitários
│   └── integration_test/   # Testes de integração
├── assets/                 # Recursos estáticos
│   ├── fonts/
│   ├── icons/
│   ├── images/
│   └── l10n/               # Traduções
└── docs/                   # Documentação completa
    ├── 01_Product/         # PRD, requisitos, visão
    ├── 02_Architecture/    # Arquitetura, ADRs
    ├── 03_DataModel/       # Modelo de dados
    ├── 04_UX_UI/           # Design system, fluxos
    ├── 05_Development/     # Guia de desenvolvimento
    ├── 08_Testing/         # Estratégia e planos de teste
    ├── 09_Deployment/      # Build, release, CI/CD
    ├── 10_Security/        # Segurança e criptografia
    ├── 11_Legal/           # LGPD, GDPR, termos
    ├── 12_Marketing/       # ASO, lojas, marca
    ├── 13_Roadmap/         # Estratégia e evolução
    ├── 14_AI/              # Prompts e workflows de IA
    ├── 15_Appendix/        # Índices, glossário, ADRs
    └── 16_SprintBook/      # Sprint Book para execução via IA
```

---

## Tecnologias

| Camada | Tecnologia |
|--------|-----------|
| Framework | Flutter 3.x |
| State Management | Riverpod |
| Navigation | GoRouter |
| Armazenamento | Hive (AES-256) |
| Secure Storage | Flutter Secure Storage |
| NFC | nfc_manager |
| QR Code | mobile_scanner |
| Contatos | flutter_contacts |
| Biometria | local_auth |
| Ads | google_mobile_ads |
| Testes | flutter_test, mockito |

---

## Como Começar

### Pré-requisitos

- Flutter SDK >= 3.x
- Dart SDK >= 3.x
- Android Studio / VS Code
- Dispositivo ou emulador Android/iOS

### Instalação

```bash
git clone https://github.com/seu-usuario/VCardSmart.git
cd VCardSmart/app
flutter pub get
flutter run
```

### Testes

```bash
cd app
flutter analyze
flutter test
flutter test --coverage
```

---

## Documentação

Consulte `docs/15_Appendix/01_MasterIndex.md` para o índice completo da documentação.

Para começar a desenvolver, leia `docs/16_SprintBook/00_READ_FIRST.md`.

---

## Status

Em desenvolvimento — Sprint 0 (Setup)

---

## Licença

Definida em `docs/15_Appendix/license.md`
