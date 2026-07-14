# Security Policy — VCardSmart

## Princípios

### 1. Confidencialidade

> Nenhuma informação sensível será exposta a partes não autorizadas.

**Implementação**:
- Criptografia AES-256 em todos os dados
- Secure Storage para chaves e secrets
- Autenticação obrigatória para acesso

### 2. Integridade

> Os dados serão protegidos contra alterações não autorizadas.

**Implementação**:
- Validação de todos os dados recebidos
- Versionamento de dados
- Checksum para verificação de integridade

### 3. Disponibilidade

> Os dados estarão acessíveis ao usuário autorizado.

**Implementação**:
- Armazenamento 100% local
- Sem dependência de servidores
- Funcionamento offline completo

### 4. Consentimento

> Nenhuma ação será executada sem consentimento explícito do usuário.

**Implementação**:
- Confirmação para compartilhamento
- Confirmação para importação
- Confirmação para alterações na agenda

### 5. Menor Privilégio

> O aplicativo solicitará apenas as permissões estritamente necessárias.

**Implementação**:
- Permissões sob demanda
- Justificativa clara para cada permissão
- Sem permissões preventivas

### 6. Fail Safe

> Em caso de falha, o aplicativo deve falhar de forma segura.

**Implementação**:
- Dados sempre preservados
- Sem exposição de informações
- Logging seguro

### 7. Secure by Default

> A configuração padrão deve ser a mais segura possível.

**Implementação**:
- Biometria desabilitada por padrão
- PIN desabilitado por padrão
- Permissões não concedidas por padrão

### 8. Privacy by Default

> A privacidade deve ser a configuração padrão.

**Implementação**:
- Sem analytics por padrão
- Sem telemetria por padrão
- Sem sharing por padrão

## Política de Dados

### O que NÃO coletamos

- ❌ Nome do dispositivo
- ❌ IMEI
- ❌ Localização
- ❌ Contacts (exceto com consentimento)
- ❌ Dados de uso
- ❌ Logs de erro
- ❌ Analytics
- ❌ Identificadores únicos

### O que armazenamos

- ✅ Perfil do usuário (no dispositivo)
- ✅ Configurações (no dispositivo)
- ✅ Contatos importados (no dispositivo)
- ✅ Dados de autenticação (no dispositivo)

### Onde armazenamos

- 📱 Exclusivamente no dispositivo
- 🔒 Criptografado com AES-256
- 🔐 Chaves em Secure Storage

## Política de Compartilhamento

### Regras

1. **Nunca automático** — Sempre com confirmação
2. **Nunca sem consentimento** — Usuário sempre ciente
3. **Nunca com terceiros** — Sem sharing com servidores
4. **Sempre controlado** — Usuário decide o que compartilhar

### Fluxo

```
Usuário seleciona dados
    ↓
Resumo exibido
    ↓
Confirmação solicitada
    ↓
Payload gerado
    ↓
Payload validado
    ↓
Transmissão segura
```

## Política de Senhas

### PIN

- 4 a 8 dígitos
- Hash com bcrypt
- Tentativas limitadas (5)
- Timeout após falhas
- Alteração mediante autenticação

### Biometria

- Face ID (iOS)
- Touch ID (iOS)
- Fingerprint (Android)
- Android Biometrics
- Fallback para PIN

## Política de Atualização

### Aplicativo

- Atualização apenas via lojas oficiais
- Sem in-app update
- Sem download de APKs externos

### Dados

- Versionamento de dados
- Migração segura
- Rollback possível
