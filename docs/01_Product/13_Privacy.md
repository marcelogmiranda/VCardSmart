# Privacy

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Princípios de Privacidade

| Princípio | Descrição |
|-----------|-----------|
| **Não Rastrear** | Nenhum dado de uso é coletado ou rastreado |
| **Não Coletar** | Nenhuma informação pessoal é coletada |
| **Não Enviar** | Nenhum dado é transmitido para servidores |
| **Não Sincronizar** | Nenhum dado é sincronizado entre dispositivos |
| **Sem Analytics** | Nenhuma ferramenta de analytics integrada |
| **Sem Cloud** | Nenhum armazenamento em nuvem |
| **Sem Login** | Nenhuma autenticação de servidor necessária |

---

## O Que NÃO Fazemos

| # | Não Fazemos | Justificativa |
|---|------------|---------------|
| 1 | Coletar dados de uso | Privacidade do usuário |
| 2 | Enviar dados para analytics | Privacidade do usuário |
| 3 | Utilizar Firebase | Privacidade do usuário |
| 4 | Rastrear comportamento | Privacidade do usuário |
| 5 | Compartilhar dados com terceiros | Privacidade do usuário |
| 6 | Armazenar dados em nuvem | Privacidade do usuário |
| 7 | Criar perfis de usuário | Privacidade do usuário |
| 8 | Utilizar cookies | Privacidade do usuário |
| 9 | Enviar crash reports automaticamente | Privacidade do usuário |
| 10 | Vender dados | Privacidade do usuário |

---

## O Que Fazemos

| # | Fazemos | Como |
|---|---------|------|
| 1 | Armazenar dados localmente | Hive Database |
| 2 | Proteger acesso | Biometria / PIN |
| 3 | Criptografar dados sensíveis | Hive + criptografia nativa |
| 4 | Respeitar permissões | Solicitar apenas quando necessário |
| 5 | Oferecer controle | Usuário decide o que compartilhar |

---

## Dados Armazenados

### Dados do Usuário
| Dado | Local | Criptografado | Compartilhado |
|------|-------|---------------|---------------|
| Nome | Hive | Não | Somente quando usuário compartilha |
| E-mail | Hive | Não | Somente quando usuário compartilha |
| Telefone(s) | Hive | Não | Somente quando usuário compartilha |
| Empresa | Hive | Não | Somente quando usuário compartilha |
| Cargo | Hive | Não | Somente quando usuário compartilha |
| Foto | Hive | Não | Somente quando usuário compartilha |
| Logotipo | Hive | Não | Somente quando usuário compartilha |
| Redes sociais | Hive | Não | Somente quando usuário compartilha |

### Dados de Configuração
| Dado | Local | Criptografado | Compartilhado |
|------|-------|---------------|---------------|
| Tema | Hive | Não | Nunca |
| Idioma | Hive | Não | Nunca |
| Biometria ativa | Hive | Não | Nunca |
| PIN | Hive | Sim | Nunca |

### Dados de Cartões Recebidos
| Dado | Local | Criptografado | Compartilhado |
|------|-------|---------------|---------------|
| Cartões importados | Hive | Não | Nunca |

---

## Ciclo de Vida dos Dados

```
Criação → Armazenamento → Uso → Compartilhamento (opcional) → Exclusão
```

### Criação
- Dados são criados pelo usuário
- Nenhum dado é gerado automaticamente

### Armazenamento
- Exclusivamente no Hive
- Sem sincronização
- Sem backup em nuvem

### Uso
- Apenas pelo usuário no dispositivo
- Sem analytics
- Sem rastreamento

### Compartilhamento
- Somente mediante confirmação explícita
- Somente dados selecionados pelo usuário
- Sem envio para servidores

### Exclusão
- Ao desinstalar, todos os dados são removidos
- Usuário pode excluir dados individualmente

---

## Política de Privacidade

Este documento servirá como base para a Política de Privacidade oficial do aplicativo.

### Versão da Política
- Versão: 1.0
- Data: 2026-07-13

### Resumo da Política
O VCardSmart respeita a privacidade dos seus usuários. Nenhum dado é coletado, armazenado em nuvem ou compartilhado com terceiros. Todo o armazenamento ocorre exclusivamente no dispositivo do usuário.

---

## Conformidade

| Regulamentação | Status |
|---------------|--------|
| LGPD (Brasil) | Em conformidade (sem coleta de dados) |
| GDPR (Europa) | Em conformidade (sem coleta de dados) |
| CCPA (Califórnia) | Em conformidade (sem coleta de dados) |

---

## Documentos Relacionados

- [08_BusinessRules.md](./08_BusinessRules.md)
- [12_Permissions.md](./12_Permissions.md)
- [09_FunctionalRequirements.md](./09_FunctionalRequirements.md)
