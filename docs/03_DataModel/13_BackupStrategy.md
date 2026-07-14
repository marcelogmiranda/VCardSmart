# Backup Strategy

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Status da Estratégia

| Componente | Status | Descrição |
|-----------|--------|-----------|
| **Backup** | ❌ Cancelado | Não será implementado em V1 |
| **Cloud** | ❌ Não | Sem armazenamento externo |
| **Exportação Automática** | ❌ Não | Sem exportação automática |

---

## Justificativa

| # | Justificativa |
|---|---------------|
| 1 | Manter princípio de zero cloud |
| 2 | Privacidade total do usuário |
| 3 | Simplicidade da arquitetura |
| 4 | Zero dependência externa |

---

## O que Acontece ao Desinstalar

```
App desinstalado
    ↓
SO remove todos os dados
    ↓
Hive box removida
    ↓
Dados desaparecem permanentemente
```

---

## Backup Manual (V1)

### O que o Usuário Pode Fazer
| Ação | Como |
|------|------|
| Compartilhar cartão | NFC, QR Code, WhatsApp |
| Anotar dados | Manualmente |

### O que o Usuário NÃO Pode Fazer
| Ação | Status |
|------|--------|
| Backup automático | ❌ |
| Backup em nuvem | ❌ |
| Exportação de arquivo | ❌ (V1) |
| Sincronização | ❌ |

---

## Futuro (V5)

| Funcionalidade | Status |
|---------------|--------|
| Backup opcional em nuvem | Planejado |
| Sincronização entre dispositivos | Planejado |
| Exportação de arquivo | Planejado |

---

## Documentos Relacionados

- [13_BackupStrategy.md](./13_BackupStrategy.md)
- [14_DataSecurity.md](./14_DataSecurity.md)
- [18_OfflineStrategy.md](../04_Architecture/18_OfflineStrategy.md)
