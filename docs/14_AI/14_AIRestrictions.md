# Restrições de IA — VCardSmart

## Restrições Absolutas

### IA NUNCA poderá

| Restrição | Motivo |
|-----------|--------|
| Adicionar dependências sem aprovação | Segurança e estabilidade |
| Alterar arquitetura sem aprovação | Consistência |
| Alterar banco sem aprovação | Integridade dos dados |
| Alterar modelo de dados sem aprovação | Compatibilidade |
| Alterar ADRs sem aprovação | Histórico de decisões |
| Ignorar testes | Qualidade |
| Pular revisão | Qualidade |
| Comprometer segurança | Segurança |
| Comprometer privacidade | Privacidade |
| Quebrar API pública | Compatibilidade |

## Restrições Condicionais

### IA poderá, SE aprovado

| Restrição | Condição |
|-----------|----------|
| Adicionar dependência | Aprovação do Tech Lead |
| Alterar arquitetura | ADR aprovado |
| Alterar banco | ADR aprovado |
| Alterar modelo de dados | ADR aprovado |
| Alterar API pública | ADR aprovado |
| Adicionar feature | PO aprovado |
| Mudar prioridade | PO aprovado |

## Regras de Implementação

### Sempre

| Regra | Descrição |
|-------|-----------|
| Consultar Acceptance Criteria | Antes de implementar |
| Seguir padrões existentes | Manter consistência |
| Executar testes | Antes de commit |
| Atualizar CHANGELOG | Após implementação |
| Documentar mudanças | Manter histórico |

### Nunca

| Regra | Descrição |
|-------|-----------|
| Pular testes | Qualidade |
| Ignorar lints | Padrão |
| Comprometer performance | Usuário |
| Comprometer segurança | Usuário |
| Comprometer privacidade | Usuário |
| Quebrar compatibilidade | Usuário |

## Regras de Código

### Sempre

| Regra | Descrição |
|-------|-----------|
| Usar tipos | Type safety |
| Tratar erros | Robustez |
| Documentar | Manutenibilidade |
| Testar | Qualidade |
| Seguir lints | Padrão |

### Nunca

| Regra | Descrição |
|-------|-----------|
| Usar dynamic | Type safety |
| Ignorar erros | Robustez |
| Copiar código | Manutenibilidade |
| Pular validações | Segurança |
| Hardcoded secrets | Segurança |

## Regras de Documentação

### Sempre

| Regra | Descrição |
|-------|-----------|
| Atualizar CHANGELOG | Histórico |
| Documentar ADRs | Decisões |
| Atualizar README | Visão geral |
| Documentar features | Funcionalidades |

### Nunca

| Regra | Descrição |
|-------|-----------|
| Documentar sem mudar | Honestidade |
| Prometer sem entregar | Confiança |
| Ocultar limitações | Transparência |

## Consequências de Violação

### Leve

- Código rejeitado
- Revisão obrigatória
- Documentação adicional

### Média

- feature revertida
- ADR necessário
- Revisão de segurança

### Grave

- Revert imediato
- Investigação
- Ações corretivas
