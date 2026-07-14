# Avaliação de Riscos — VCardSmart

## Matriz de Riscos

| Risco | Severidade | Probabilidade | Impacto | Mitigação |
|-------|------------|---------------|---------|-----------|
| Perda do aparelho | Alta | Média | Alto | Biometria + PIN + Timeout |
| Roubo do aparelho | Alta | Baixa | Alto | Biometria + PIN + Lock |
| Acesso indevido | Alta | Média | Alto | Autenticação + Tentativas |
| Captura de tela | Média | Média | Médio | Flag de segurança |
| Compartilhamento acidental | Média | Média | Médio | Confirmação obrigatória |
| Permissões excessivas | Média | Baixa | Médio | Permissões sob demanda |
| QR malicioso | Média | Baixa | Médio | Validação + Sanitização |
| vCard inválido | Média | Baixa | Médio | Validação RFC 6350 |
| NFC inválido | Média | Baixa | Médio | Validação + Confirmação |
| Corrupção Hive | Baixa | Baixa | Baixo | Versionamento + Migração |
| Ataque Man-in-the-Middle | Baixa | Muito Baixa | Alto | Dados 100% locais |
| Malware no dispositivo | Baixa | Baixa | Alto | Validação de input |

## Detalhamento

### Risco: Perda do Dispositivo

**Severidade**: Alta
**Probabilidade**: Média
**Impacto**: Alto

**Cenário**:
- Usuário perde o dispositivo
- Dados ficam inacessíveis
- Possível acesso por terceiro

**Mitigação**:
- Biometria para acesso
- PIN como fallback
- Timeout de 5 minutos
- Bloqueio automático
- Ocultar conteúdo no app switcher

**Plano de Contingência**:
- Usuário reinstala app
- Cria novo perfil
- Dados anteriores inacessíveis

---

### Risco: QR Code Malicioso

**Severidade**: Média
**Probabilidade**: Baixa
**Impacto**: Médio

**Cenário**:
- QR Code contém dados maliciosos
- App tenta processar dados inválidos
- Possível exploração de vulnerabilidade

**Mitigação**:
- Validação de todos os dados recebidos
- Sanitização de strings
- Limites de tamanho (máx. 4KB)
- Rejeição de formato inválido
- Sem execução de código

**Plano de Contingência**:
- Log do erro (sem dados sensíveis)
- Mensagem de erro ao usuário
- Rejeição dos dados

---

### Risco: NFC Inválido

**Severidade**: Média
**Probabilidade**: Baixa
**Impacto**: Médio

**Cenário**:
- Tag NFC contém dados corrompidos
- App tenta processar dados inválidos
- Possível corrupção de dados

**Mitigação**:
- Validação de payload
- Versionamento de dados
- Confirmação antes de salvar
- Backup dos dados existentes
- Rollback em caso de erro

**Plano de Contingência**:
- Rejeição dos dados
- Dados existentes preservados
- Mensagem de erro ao usuário

---

### Risco: Corrupção Hive

**Severidade**: Baixa
**Probabilidade**: Baixa
**Impacto**: Baixo

**Cenário**:
- Banco de dados corrompido
- Perda de dados locais
- App instável

**Mitigação**:
- Versionamento de dados
- Migração segura
- Backup automático (local)
- Validação de integridade

**Plano de Contingência**:
- Reconstrução do banco
- Perda de dados (esperada)
- Usuário cria novo perfil

## Processo de Avaliação

### 1. Identificação

```markdown
- Listar todas as ameaças
- Classificar por severidade
- Definir probabilidade
```

### 2. Análise

```markdown
- Avaliar impacto
- Identificar mitigações
- Definir plano de contingência
```

### 3. Priorização

```markdown
- Riscos altos: Ação imediata
- Riscos médios: Ação planejada
- Riscos baixos: Monitoramento
```

### 4. Monitoramento

```markdown
- Revisão trimestral
- Atualização conforme novas ameaças
- Documentação de incidentes
```

## Métricas

| Métrica | Meta |
|---------|------|
| Riscos identificados | 100% |
| Riscos mitigados | 100% |
| Riscos altos | 0 abertos |
| Incidentes | 0 por trimestre |
