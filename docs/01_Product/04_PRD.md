# PRD – Product Requirements Document

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |
| **Status** | Em elaboração |

---

## 1. Visão Geral

| Campo | Valor |
|-------|-------|
| **Nome** | VCardSmart |
| **Categoria** | Business |
| **Subcategoria** | Networking |
| **Modelo** | Offline First |
| **Plataformas** | Android, iOS |
| **Framework** | Flutter |
| **Linguagem** | Dart |

---

## 2. Público-Alvo

### 2.1 Profissionais

| Segmento | Descrição |
|----------|-----------|
| Empresários | Donos de empresas que frequentemente fazem networking |
| Consultores | Profissionais que dependem de contatos para gerar negócios |
| Profissionais liberais | Advogados, médicos, engenheiros, arquitetos |
| Representantes comerciais | Vendedores que visitam clientes e prospects |
| Executivos | C-levels e diretores que participam de eventos |

### 2.2 Eventos e Ambientes

| Segmento | Descrição |
|----------|-----------|
| Networking | Encontros profissionais |
| BNI | Grupos de networking estruturado |
| Feiras | Eventos de negócios |
| Congressos | Encontros acadêmicos e profissionais |
| Eventos | Conferências, seminários, workshops |

---

## 3. Funcionalidades Principais

| # | Funcionalidade | Prioridade | Status |
|---|---------------|------------|--------|
| F01 | Cadastro de perfil | P0 | A definir |
| F02 | Compartilhamento NFC | P0 | A definir |
| F03 | QR Code estático | P0 | A definir |
| F04 | Leitura de QR Code | P0 | A definir |
| F05 | Geração de vCard | P0 | A definir |
| F06 | Importação de vCard | P0 | A definir |
| F07 | Biometria/PIN | P0 | A definir |
| F08 | Temas (claro/escuro/sistema) | P1 | A definir |
| F09 | Internacionalização (8 idiomas) | P1 | A definir |
| F10 | Compartilhamento WhatsApp | P1 | A definir |
| F11 | Anúncios AdMob | P1 | A definir |
| F12 | Atualização da agenda | P2 | A definir |

---

## 4. Restrições

| # | Restrição | Justificativa |
|---|-----------|---------------|
| R01 | 100% offline | Princípio de privacidade |
| R02 | Sem servidor | Zero dependência externa |
| R03 | Sem analytics | Privacidade do usuário |
| R04 | Sem login | Zero cadastro |
| R05 | Armazenamento apenas via Hive | Consistência de dados locais |
| R06 | Compatível com Android 6+ | Cobertura de mercado |
| R07 | Compatível com iOS 13+ | Cobertura de mercado |

---

## 5. Premissas

| # | Premissa |
|---|----------|
| P01 | O dispositivo possui hardware NFC (funcionalidade degrada sem) |
| P02 | O dispositivo possui câmera para QR Code |
| P03 | O usuário possui pelo menos um dispositivo móvel |
| P04 | O usuário deseja compartilhar informações profissionais |

---

## 6. Dependências Externas

| Dependência | Tipo | Status |
|------------|------|--------|
| Flutter SDK | Framework | Estável |
| Hive | Banco local | Estável |
| NFC Manager | Plugin NFC | Estável |
| Mobile Scanner | Plugin QR | Estável |
| Local Auth | Plugin Biometria | Estável |
| Google Mobile Ads | Plugin Anúncios | Estável |

---

## 7. Análise de Risco

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| Dispositivo sem NFC | Alto | Média | Funcionalidade degrada gracefulmente |
| QR Code não lido | Médio | Baixa | Validação de formato vCard |
| Atualização Flutter quebra compatibilidade | Alto | Baixa | Testes automatizados |
| Política de privacidade rejeitada | Alto | Baixa | Documentação completa |

---

## 8. Cronograma Estimado

| Fase | Descrição | Duração Estimada |
|------|-----------|-----------------|
| Fase 1 | Setup e arquitetura | 2 semanas |
| Fase 2 | Cadastro e perfil | 2 semanas |
| Fase 3 | NFC e QR Code | 3 semanas |
| Fase 4 | vCard e importação | 2 semanas |
| Fase 5 | Biometria e segurança | 1 semana |
| Fase 6 | UI/UX e temas | 2 semanas |
| Fase 7 | Internacionalização | 2 semanas |
| Fase 8 | Anúncios e monetização | 1 semana |
| Fase 9 | Testes e validação | 2 semanas |
| Fase 10 | Publicação | 1 semana |
| **Total** | | **18 semanas** |

---

## Documentos Relacionados

- [01_ProductVision.md](./01_ProductVision.md)
- [05_Features.md](./05_Features.md)
- [06_UserStories.md](./06_UserStories.md)
- [09_FunctionalRequirements.md](./09_FunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
