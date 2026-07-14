# Ciclo de Vida de Bugs — VCardSmart

## Fluxo

```
Novo → Triagem → Em Desenvolvimento → Em Teste → Resolvido → Fechado
```

## Estados

### 1. Novo

**Descrição**: Bug reportado, aguardando triagem

**Responsável**: QA ou Usuário

**Ações**:
- Preencher template completo
- Adicionar evidências (screenshot, log)
- Classificar prioridade

**Template**:
```markdown
## Título
[Descrição concisa do bug]

## Ambiente
- Dispositivo: [Modelo]
- OS: [Versão]
- App: [Versão]

## Passos para Reproduzir
1. [Passo 1]
2. [Passo 2]
3. [Passo 3]

## Resultado Esperado
[O que deveria acontecer]

## Resultado Obtido
[O que aconteceu]

## Evidências
[Screenshots, logs]

## Prioridade
- [ ] P0 - Crítico
- [ ] P1 - Alto
- [ ] P2 - Médio
- [ ] P3 - Baixo
```

### 2. Triagem

**Descrição**: Bug analisado e priorizado

**Responsável**: Tech Lead / Product Owner

**Ações**:
- Confirmar reprodução
- Definir prioridade e severidade
- Alocar para desenvolvedor

**Critérios de Triagem**:

| Severidade | Descrição | Prazo de Correção |
|------------|-----------|-------------------|
| Crítica | App inutilizável, perda de dados | 24h |
| Alta | Funcionalidade importante não funciona | 3 dias |
| Média | Funcionalidade com workaround | 1 semana |
| Baixa | Problema cosmético | Próximo release |

### 3. Em Desenvolvimento

**Descrição**: Bug sendo corrigido

**Responsável**: Desenvolvedor

**Ações**:
- Investigar causa raiz
- Implementar correção
- Adicionar teste de regressão
- Atualizar documentação

### 4. Em Teste

**Descrição**: Correção enviada para teste

**Responsável**: QA

**Ações**:
- Verificar correção
- Testar cenários relacionados
- Executar regressão
- Aprovar ou rejeitar

### 5. Resolvido

**Descrição**: Correção aprovada pelo QA

**Responsável**: QA

**Ações**:
- Documentar correção
- Atualizar changelog
- Marcar como resolvido

### 6. Fechado

**Descrição**: Bug confirmado como resolvido

**Responsável**: QA ou Product Owner

**Ações**:
- Verificar em produção
- Fechar ticket
- Documentar lições aprendidas

## Classificação

### Severidade

| Nível | Descrição | Exemplo |
|-------|-----------|---------|
| Crítica | App crash, perda de dados | App crasha ao abrir |
| Alta | Funcionalidade bloqueante | QR Code não gera |
| Média | Funcionalidade com problema | Tema não aplica corretamente |
| Baixa | Problema cosmético | Alinhamento incorreto |

### Prioridade

| Nível | Descrição | Prazo |
|-------|-----------|-------|
| P0 | Correção imediata | 24h |
| P1 | Correção urgente | 3 dias |
| P2 | Correção normal | 1 semana |
| P3 | Correção futura | Próximo release |

### Componente

| Componente | Tags |
|------------|------|
| Perfil | profile, create, edit |
| QR Code | qrcode, generate, scan |
| NFC | nfc, read, write |
| vCard | vcard, import, export |
| Agenda | contacts, import, export |
| Configurações | settings, theme, language |
| Segurança | security, biometric, pin |
| UI | ui, layout, design |
| Performance | performance, memory, cpu |
| Offline | offline, sync |

## Métricas

| Métrica | Descrição |
|---------|-----------|
| MTTR | Mean Time To Repair |
| Bugs por release | Total de bugs encontrados |
| Bugs abertos | Bugs aguardando correção |
| Bugs recorrentes | Bugs que retornaram |
| Taxa de resolução | Bugs resolvidos / total |

## Dashboard

```
═══════════════════════════════════════
       VCardSmart Bug Dashboard
═══════════════════════════════════════

Novos:           3  🔴
Em Triagem:      2  🟡
Em Desenvolvimento: 5  🔵
Em Teste:        4  🟣
Resolvidos:     12  🟢
Fechados:       45  ✅

═══════════════════════════════════════
MTTR: 2.3 dias
Taxa de Resolução: 89%
═══════════════════════════════════════
```

## Processo de Escalation

```
Bug reportado
    ↓
Triagem (24h)
    ↓
Alocado para dev
    ↓
Correção (prazo conforme severidade)
    ↓
Teste (24h)
    ↓
Aprovado? ──→ Fechado
    ↓ Não
Rejeitado
    ↓
Return to dev
    ↓
Nova correção
    ↓
Novo teste
```

## Boas Práticas

1. **Bug Reports Claros** — Sempre incluir passos para reproduzir
2. **Evidências** — Screenshots e logs sempre que possível
3. **Um Bug por Ticket** — Não misturar problemas
4. **Atualizar Status** — Manter ticket atualizado
5. **Documentar Correção** — Explicar o que foi feito
6. **Testes de Regressão** — Sempre adicionar teste ao corrigir
