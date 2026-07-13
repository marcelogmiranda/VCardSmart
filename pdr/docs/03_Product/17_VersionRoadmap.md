# Version Roadmap

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Visão Geral

O VCardSmart seguirá um roadmap de versões incrementais, cada uma adicionando funcionalidades significativas.

---

## V1 – Offline

**Status:** Em desenvolvimento
**Foco:** Funcionalidade core 100% offline

### Funcionalidades
- ✅ Cadastro de perfil completo
- ✅ Compartilhamento NFC
- ✅ QR Code estático
- ✅ Leitura de QR Code
- ✅ Geração de vCard (RFC 6350)
- ✅ Importação de vCard
- ✅ Biometria / PIN
- ✅ Temas (claro/escuro/sistema)
- ✅ Internacionalização (8 idiomas)
- ✅ Compartilhamento WhatsApp
- ✅ Anúncios AdMob (não intrusivos)

### Restrições
- Um cartão por usuário
- Sem backup
- Sem exportação de arquivo

---

## V2 – Múltiplos Cartões

**Status:** Planejado
**Foco:** Perfis profissionais múltiplos

### Funcionalidades Adicionais
- ✅ Múltiplos cartões ativos
- ✅ Troca rápida entre cartões
- ✅ Cartão pessoal e cartão profissional
- ✅ Cartão para diferentes eventos
- ✅ Estatísticas locais de compartilhamento

### Dependências
- V1 concluída
- Refatoração do banco de dados

---

## V3 – Premium

**Status:** Planejado
**Foco:** Monetização avançada

### Funcionalidades Adicionais
- ✅ Remoção de anúncios
- ✅ Templates premium
- ✅ Exportar vCard como arquivo
- ✅ Suporte prioritário
- ✅ Personalização avançada

### Dependências
- V2 concluída
- Integração in_app_purchase
- Validação local de compra

---

## V4 – Empresa

**Status:** Planejado
**Foco:** Gestão corporativa

### Funcionalidades Adicionais
- ✅ Múltiplos colaboradores
- ✅ Gestão centralizada
- ✅ Cartão corporativo padronizado
- ✅ Dashboard de uso (local)
- ✅ Exportação de dados

### Dependências
- V3 concluída
- Arquitetura multi-usuário

---

## V5 – Cloud Opcional

**Status:** Planejado
**Foco:** Sincronização opcional

### Funcionalidades Adicionais
- ✅ Backup opcional em nuvem
- ✅ Sincronização entre dispositivos
- ✅ Compartilhamento via link
- ✅ Integração com Google Contacts
- ✅ Integração com Apple Contacts

### Dependências
- V4 concluída
- Definição de provider cloud
- Política de privacidade atualizada

---

## Linha do Tempo Estimada

```
V1 (Offline)          → Q3 2026
V2 (Múltiplos)        → Q4 2026
V3 (Premium)          → Q1 2027
V4 (Empresa)          → Q2 2027
V5 (Cloud Opcional)   → Q3 2027
```

*Datas sujeitas a ajuste baseado no progresso.*

---

## Princípios de Versão

| Princípio | Descrição |
|-----------|-----------|
| Incremental | Cada versão adiciona funcionalidades sem quebrar as anteriores |
| Compatível | Dados de versões anteriores devem ser migráveis |
| Documentado | Cada versão possui changelog completo |
| Testado | Cada versão passa por todos os testes antes do lançamento |

---

## Changelog

### V1.0.0 (Em desenvolvimento)
- Cadastro de perfil
- Compartilhamento NFC
- QR Code
- vCard
- Biometria
- Temas
- Internacionalização
- Anúncios

---

## Documentos Relacionados

- [04_PRD.md](./04_PRD.md)
- [03_ProductObjectives.md](./03_ProductObjectives.md)
- [14_Monetization.md](./14_Monetization.md)
