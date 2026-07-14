# Dependências — VCardSmart

## Dependências Obrigatórias

### State Management

| Pacote | Versão | Uso |
|--------|--------|-----|
| flutter_riverpod | ^2.4.0 | Gerenciamento de estado |

### Navigation

| Pacote | Versão | Uso |
|--------|--------|-----|
| go_router | ^13.0.0 | Navegação declarativa |

### Local Storage

| Pacote | Versão | Uso |
|--------|--------|-----|
| hive | ^2.2.3 | Armazenamento local |
| hive_flutter | ^1.1.0 | Integração Flutter |
| flutter_secure_storage | ^9.0.0 | Dados sensíveis |

### Native Features

| Pacote | Versão | Uso |
|--------|--------|-----|
| local_auth | ^2.1.7 | Autenticação biométrica |
| flutter_contacts | ^1.1.7+1 | Acesso à agenda |
| mobile_scanner | ^3.5.5 | Leitura de QR Code |
| nfc_manager | ^3.1.3 | Leitura/escrita NFC |

### Sharing

| Pacote | Versão | Uso |
|--------|--------|-----|
| share_plus | ^7.2.1 | Compartilhamento nativo |
| url_launcher | ^6.2.1 | Abrir URLs |

### Ads

| Pacote | Versão | Uso |
|--------|--------|-----|
| google_mobile_ads | ^4.0.0 | Anúncios Google |

### Utils

| Pacote | Versão | Uso |
|--------|--------|-----|
| uuid | ^4.2.1 | Geração de IDs únicos |

### Code Generation

| Pacote | Versão | Uso |
|--------|--------|-----|
| json_annotation | ^4.8.1 | Anotações JSON |
| freezed_annotation | ^2.4.1 | Anotações Freezed |

## Dev Dependencies

### Testing

| Pacote | Versão | Uso |
|--------|--------|-----|
| flutter_test | sdk | Testes unit/widget |
| mockito | ^5.4.3 | Mocking |
| patrol | ^3.4.1 | Testes E2E |

### Code Generation

| Pacote | Versão | Uso |
|--------|--------|-----|
| build_runner | ^2.4.7 | Geração de código |
| freezed | ^2.4.5 | Modelos imutáveis |
| json_serializable | ^6.7.1 | Serialização JSON |

### Linting

| Pacote | Versão | Uso |
|--------|--------|-----|
| flutter_lints | ^3.0.1 | Regras de lint |

## Gerenciamento de Dependências

### Comandos

```bash
# Instalar dependências
flutter pub get

# Atualizar dependências
flutter pub upgrade

# Verificar dependências desatualizadas
flutter pub outdated

# Remover dependências não utilizadas
flutter pub cache clean

# Verificar conflitos
flutter pub deps
```

### Atualização Segura

```bash
# Atualizar uma dependência específica
flutter pub upgrade package_name

# Atualizar todas as dependências
flutter pub upgrade

# Atualizar com versões principais
flutter pub upgrade --major-versions
```

### Verificação de Segurança

```bash
# Verificar vulnerabilidades
dart pub audit

# Verificar licenças
dart pub deps --no-dev --style=compact
```

## Estrutura de Dependências

```
VCardSmart
├── flutter_riverpod
│   └── Gerenciamento de estado
├── go_router
│   └── Navegação
├── hive
│   └── Armazenamento local
├── flutter_secure_storage
│   └── Dados sensíveis
├── local_auth
│   └── Biometria
├── flutter_contacts
│   └── Agenda
├── mobile_scanner
│   └── QR Code
├── nfc_manager
│   └── NFC
├── share_plus
│   └── Compartilhamento
├── google_mobile_ads
│   └── Anúncios
└── uuid
    └── IDs únicos
```
