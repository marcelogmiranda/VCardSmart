# Matriz de Riscos — VCardSmart

## Visão Geral

Identificação e mitigação de riscos técnicos do projeto.

## Matriz de Riscos

| # | Risco | Impacto | Probabilidade | Severidade | Mitigação |
|---|-------|---------|---------------|------------|-----------|
| R-01 | Perda de dados do usuário | Alto | Baixa | Crítica | Hive criptografado + backup local |
| R-02 | NFC incompatível | Médio | Média | Alta | Fallback para QR Code/vCard |
| R-03 | QR Code ilegível | Médio | Baixa | Média | Correção de erro alta + qualidade |
| R-04 | Permissões negadas | Médio | Alta | Alta | Fluxos alternativos claros |
| R-05 | Mudança nas APIs das lojas | Alto | Baixa | Alta | Atualizações contínuas |
| R-06 | Performance ruim | Alto | Média | Alta | Testes de performance + profiling |
| R-07 | Bugs em produção | Alto | Média | Alta | Suite de testes completa |
| R-08 | Incompatibilidade de devices | Médio | Média | Média | Testes de compatibilidade |
| R-09 | Ataques de segurança | Alto | Baixa | Crítica | Criptografia + autenticação |
| R-10 | Recusa nas lojas | Alto | Baixa | Crítica | Compliance total |
| R-11 | Dependências descontinuadas | Médio | Baixa | Média | Monitore + alternativas |
| R-12 | Problemas de acessibilidade | Médio | Média | Média | Testes de acessibilidade |
| R-13 | Problemas de i18n | Médio | Média | Média | Testes de internacionalização |
| R-14 | Memory leaks | Alto | Média | Alta | Testes de memória + profiling |
| R-15 | Crash em produção | Alto | Média | Crítica | Crash reporting + fix rápido |

## Detalhamento dos Riscos

### R-01: Perda de Dados do Usuário

**Impacto**: Alto — Perda de confiança do usuário
**Probabilidade**: Baixa — Criptografia e backup

**Causas**:
- Falha no armazenamento local
- Corrupção de dados
- Desinstalação do app

**Mitigação**:
- Hive criptografado com chave segura
- Backup automático em cloud (opcional)
- Validação de integridade dos dados
- Processo de recuperação

**Plano de Contingência**:
- Restaurar de backup
- Recuperar dados de NFC/QR Code
- Comunicar com usuário

---

### R-02: NFC Incompatível

**Impacto**: Médio — Funcionalidade indisponível
**Probabilidade**: Média — Diversos devices

**Causas**:
- Device sem NFC
- NFC desabilitado
- Formatos de tag incompatíveis

**Mitigação**:
- Verificar disponibilidade de NFC
- Fallback automático para QR Code
- Instruções claras para habilitar NFC
- Suporte a múltiplos formatos

**Plano de Contingência**:
- Usar QR Code como alternativa
- Usar vCard como alternativa
- Documentar limitação

---

### R-03: QR Code Ilegível

**Impacto**: Médio — Compartilhamento falha
**Probabilidade**: Baixa — Geração de qualidade

**Causas**:
- Baixa resolução
- Contraste insuficiente
- Tamanho inadequado
- Dano na imagem

**Mitigação**:
- Geração em alta resolução
- Correção de erro alta
- Tamanho adequado
- Validação de qualidade

**Plano de Contingência**:
- Regenerar QR Code
- Usar NFC como alternativa
- Compartilhar vCard diretamente

---

### R-04: Permissões Negadas

**Impacto**: Médio — Funcionalidade limitada
**Probabilidade**: Alta — Usuários preocupados com privacidade

**Causas**:
- Preocupação com privacidade
- Configuração incorreta
- Entendedimento inadequado

**Mitigação**:
- Solicitar permissões apenas quando necessário
- Explicar benefícios claramente
- Oferecer alternativas
- Fluxos de fallback

**Plano de Contingência**:
- Funcionalidade limitada
- Instruções para habilitar
- Alternativas disponíveis

---

### R-05: Mudança nas APIs das Lojas

**Impacto**: Alto — Build quebrado
**Probabilidade**: Baixa — APIs estáveis

**Causas**:
- Atualização de políticas
- Mudanças em APIs
- Novos requisitos

**Mitigação**:
- Monitorar mudanças
- Atualizações contínuas
- Testes automatizados
- CI/CD pipeline

**Plano de Contingência**:
- Correção emergencial
- Comunicar com lojas
- Publicar atualização

---

### R-09: Ataques de Segurança

**Impacto**: Alto — Perda de dados e confiança
**Probabilidade**: Baixa — Medidas de segurança

**Causas**:
- Vulnerabilidades no código
- Ataques de engenharia social
- Devices comprometidos

**Mitigação**:
- Criptografia de dados
- Autenticação forte
- Validação de input
- Testes de segurança
- Auditorias regulares

**Plano de Contingência**:
- Resposta a incidentes
- Comunicação com usuários
- Correção emergencial
- Notificação de autoridades

---

### R-10: Recusa nas Lojas

**Impacto**: Alto — Impossibilidade de distribuição
**Probabilidade**: Baixa — Compliance total

**Causas**:
- Violação de políticas
- Conteúdo inadequado
- Práticas enganosas

**Mitigação**:
- Seguir diretrizes das lojas
- Revisão de conteúdo
- Transparência
- Compliance com LGPD/GDPR

**Plano de Contingência**:
- Correção de violações
- Re-submissão
- Comunicação com lojas
- Distribuição alternativa

---

### R-14: Memory Leaks

**Impacto**: Alto — Performance degradada
**Probabilidade**: Média — Comum em apps Flutter

**Causas**:
- Controllers não descartados
- Streams não canceladas
- Referências circulares

**Mitigação**:
- dispose() adequado
- Testes de memória
- Profiling regular
- Code review

**Plano de Contingência**:
- Identificar fonte
- Corrigir leaks
- Publicar atualização

---

### R-15: Crash em Produção

**Impacto**: Alto — Experiência do usuário
**Probabilidade**: Média — Inevitável em algum grau

**Causas**:
- Bugs não detectados
- Condições de corrida
- Edge cases
- Incompatibilidades

**Mitigação**:
- Suite de testes completa
- Crash reporting
- Testes em múltiplos devices
- Rollout gradual

**Plano de Contingência**:
- Crash reporting ativo
- Fix emergencial
- Rollback se necessário
- Comunicação com usuários

## Matriz de Prioridade

```
Probabilidade
Alta   │ R-04   │        │
Média  │ R-02   │ R-06   │ R-14
       │ R-08   │ R-07   │ R-15
       │ R-12   │        │
       │ R-13   │        │
Baixa  │ R-03   │ R-01   │ R-09
       │ R-05   │        │ R-10
       │ R-11   │        │
       └────────┴────────┴──────
         Baixa   Média    Alta
              Impacto
```

## Processo de Gestão

1. **Identificação** — Listar todos os riscos
2. **Avaliação** — Impacto e probabilidade
3. **Priorização** — Severidade
4. **Mitigação** — Ações preventivas
5. **Monitoramento** — Acompanhamento contínuo
6. **Resposta** — Plano de contingência
7. **Revisão** — Lições aprendidas

## Atualização

- **Semanal**: Revisão de riscos ativos
- **Mensal**: Identificação de novos riscos
- **Por Release**: Atualização completa
