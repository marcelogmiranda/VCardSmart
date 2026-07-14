# Architecture Decision Records

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## O que são ADRs

Architecture Decision Records (ADRs) documentam decisões arquiteturais importantes do projeto. Cada ADR contém:

- **Título** da decisão
- **Status** (aceita, proposta, obsoleta)
- **Contexto** da decisão
- **Decisão** tomada
- **Consequências** positivas e negativas

---

## ADR-001: Flutter

**Status:** Aceita

**Contexto:** Projeto multiplataforma (Android e iOS) com equipe enxuta.

**Decisão:** Utilizar Flutter como framework principal.

**Consequências:**
- ✅ Uma única codebase para Android e iOS
- ✅ Hot reload acelera desenvolvimento
- ✅ Performance nativa
- ❌ Depende do ecossistema Flutter

---

## ADR-002: Hive

**Status:** Aceita

**Contexto:** Necessidade de banco de dados local rápido e leve.

**Decisão:** Utilizar Hive como banco de dados.

**Consequências:**
- ✅ Alto performance
- ✅ Simplicidade de uso
- ✅ 100% local
- ❌ Não suporta SQL complexo

---

## ADR-003: Riverpod

**Status:** Aceita

**Contexto:** Necessidade de gerenciamento de estado robusto.

**Decisão:** Utilizar Riverpod para estado.

**Consequências:**
- ✅ Tipagem forte
- ✅ Testabilidade
- ✅ Suporte a dependências
- ❌ Curva de aprendizado

---

## ADR-004: GoRouter

**Status:** Aceita

**Contexto:** Necessidade de navegação declarativa.

**Decisão:** Utilizar GoRouter para rotas.

**Consequências:**
- ✅ Rotas declarativas
- ✅ Deep links
- ✅ Proteção de rotas
- ❌ Configuração inicial complexa

---

## ADR-005: Offline First

**Status:** Aceita

**Contexto:** Privacidade é prioridade máxima.

**Decisão:** App deve funcionar 100% offline.

**Consequências:**
- ✅ Privacidade total
- ✅ Funciona sem internet
- ❌ Sem backup em nuvem
- ❌ Sem sincronização

---

## ADR-006: NFC

**Status:** Aceita

**Contexto:** Compartilhamento rápido e físico.

**Decisão:** Utilizar NFC para compartilhamento.

**Consequências:**
- ✅ Compartilhamento instantâneo
- ✅ Experiência natural
- ❌ Requer hardware NFC

---

## ADR-007: QR Code

**Status:** Aceita

**Contexto:** Alternativa ao NFC.

**Decisão:** Utilizar QR Code para compartilhamento.

**Consequências:**
- ✅ Funciona em qualquer dispositivo
- ✅ Não requer hardware especial
- ❌ Requer câmera

---

## ADR-008: vCard

**Status:** Aceita

**Contexto:** Formato padrão para contatos.

**Decisão:** Utilizar vCard (RFC 6350) como formato.

**Consequências:**
- ✅ Compatível com todas as plataformas
- ✅ Padrão estabelecido
- ❌ Campos limitados

---

## ADR-009: Acceptance Criteria

**Status:** Aceita

**Contexto:** Necessidade de qualidade e documentação.

**Decisão:** Toda funcionalidade deve ter critérios de aceitação.

**Consequências:**
- ✅ Qualidade consistente
- ✅ Testes mais fáceis
- ❌ Mais documentação

---

## ADR-010: Material Design 3

**Status:** Aceita

**Contexto:** Design moderno e acessível.

**Decisão:** Utilizar Material Design 3.

**Consequências:**
- ✅ Design moderno
- ✅ Acessibilidade
- ✅ Temas claros/escuros

---

## ADR-011: Google Mobile Ads

**Status:** Aceita

**Contexto:** Monetização da versão gratuita.

**Decisão:** Utilizar AdMob para anúncios.

**Consequências:**
- ✅ Receita com versão gratuita
- ❌ Requer internet para anúncios

---

## ADR-012: Local Authentication

**Status:** Aceita

**Contexto:** Segurança do app.

**Decisão:** Utilizar local_auth para biometria.

**Consequências:**
- ✅ Segurança nativa
- ✅ Sem dados biométricos armazenados

---

## ADR-013: No Backend

**Status:** Aceita

**Contexto:** Privacidade é prioridade.

**Decisão:** Não utilizar backend/servidor.

**Consequências:**
- ✅ Privacidade total
- ❌ Sem funcionalidades de rede

---

## ADR-014: No Analytics

**Status:** Aceita

**Contexto:** Privacidade é prioridade.

**Decisão:** Não utilizar analytics.

**Consequências:**
- ✅ Privacidade total
- ❌ Sem dados de uso

---

## ADR-015: No Cloud

**Status:** Aceita

**Contexto:** Privacidade é prioridade.

**Decisão:** Não utilizar cloud/armazenamento externo.

**Consequências:**
- ✅ Privacidade total
- ❌ Sem backup/sync

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [20_PackageStandards.md](./20_PackageStandards.md)
- [02_CleanArchitecture.md](./02_CleanArchitecture.md)
