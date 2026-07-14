# Security Overview — VCardSmart

## Objetivos

| Princípio | Descrição |
|-----------|-----------|
| Privacy First | Privacidade é a prioridade máxima |
| Offline First | Dados nunca saem do dispositivo |
| Zero Cloud | Sem servidores, sem nuvem |
| Zero Tracking | Sem rastreamento de usuários |
| Zero Analytics | Sem coleta de dados |
| Dados Locais | Exclusivamente no dispositivo |
| Criptografia | AES-256 obrigatória |
| Consentimento | Sempre explícito e informado |

## Arquitetura de Segurança

```
┌─────────────────────────────────────┐
│         Interface do Usuário        │
├─────────────────────────────────────┤
│      Autenticação (Biometria/PIN)   │
├─────────────────────────────────────┤
│        Validação de Input           │
├─────────────────────────────────────┤
│      Criptografia (AES-256)         │
├─────────────────────────────────────┤
│    Secure Storage (Chaves/Secrets)  │
├─────────────────────────────────────┤
│      Hive (Dados Criptografados)    │
└─────────────────────────────────────┘
```

## Pilares de Segurança

### 1. Confidencialidade

- Dados criptografados em repouso
- Dados criptografados em trânsito (quando aplicável)
- Acesso restrito por autenticação

### 2. Integridade

- Validação de todos os dados recebidos
- Versionamento de dados
- Checksum para verificação

### 3. Disponibilidade

- Funcionamento offline completo
- Sem dependência de servidores
- Dados sempre acessíveis ao usuário

### 4. Privacidade

- Sem coleta de dados
- Sem compartilhamento com terceiros
- Controle total do usuário

## Stack de Segurança

| Camada | Tecnologia |
|--------|------------|
| Armazenamento | Hive com AES-256 |
| Secrets | Flutter Secure Storage |
| Autenticação | local_auth (Biometria) |
| Validação | Validators customizados |
| Criptografia | AES-256-GCM |

## ADRs

- **ADR-025**: Security by Design
- **ADR-026**: Privacy by Default
- **ADR-027**: Consentimento Obrigatório
- **ADR-028**: Zero Trust Local
- **ADR-029**: Segurança Preparada para Evolução
