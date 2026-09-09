# Prompt Reverso — Gerador de Artefatos e Controles de Evolução

> **O que é**: um prompt-mestre parametrizado que, executado em qualquer repositório GIT existente,
> regenera o conjunto completo de artefatos, PRD, controles de evolução (AGENTS.md, NEXT_STEPS.md)
> e roadmap de um produto — exatamente na estrutura que usamos no projeto VCardSmart.
>
> **Como usar**: copie o bloco abaixo, substitua as variáveis entre `{{ }}` pelos dados do novo
> produto/repositório e execute em um agente de IA (OpenCode, Claude Code, GPT, Cursor, etc.) com
> acesso de escrita ao repositório de destino.

---

## PROMPT REVERSO (copie este bloco)

```
Você é um engenheiro de software sênior e arquiteto de produto. Sua tarefa é criar, a partir do
ZERO, o sistema completo de documentação, artefatos de produto e controles de evolução de um novo
projeto, em um repositório GIT JÁ EXISTENTE e já configurado.

O objetivo é reproduzir a mesma arquitetura documental e de governança que utilizamos
com sucesso no projeto de referência VCardSmart (um app Flutter de cartões de visita digitais).
Há um padrão consolidado composto por: PRD, um conjunto de artefatos organizados em pastas
doc/arquitetura/produto, e controles de evolução (AGENTS.md, NEXT_STEPS.md, roadmap, pendências).

Você deve SEMPRE usar os parâmetros abaixo substituindo as variáveis {{ }} pelos valores reais
do novo produto. Se algum valor não for informado, pergunte ao usuário antes de continuar.

=======================================================================
PARÂMETROS DO NOVO PRODUTO
=======================================================================
- NOME DO PRODUTO (curto, para nomes de arquivos/rotas):  {{NOME_PRODUTO}}
- NOME DE EXIBIÇÃO (nome do app/produto):                 {{NOME_EXIBICAO}}
- CATEGORIA:                                               {{CATEGORIA}}        (ex.: Business/Networking)
- PLATAFORMAS:                                             {{PLATAFORMAS}}      (ex.: Android, iOS)
- FRAMEWORK / LINGUAGEM:                                   {{FRAMEWORK}}        (ex.: Flutter/Dart)
- STACK PRINCIPAL:                                         {{STACK}}            (estado, navegação, DB local, plugins)
- MODELO DE DADOS / PERSISTÊNCIA:                          {{PERSISTENCIA}}     (ex.: local-only, nuvem, híbrido)
- PRINCÍPIOS NÃO NEGOCIÁVEIS:                              {{PRINCIPIOS}}       (ex.: offline-first, privacy-first)
- MONETIZAÇÃO:                                             {{MONETIZACAO}}      (ex.: ads, premium, IAP)
- PÚBLICO-ALVO / SEGMENTOS:                                {{PUBLICO_ALVO}}
- FUNCIONALIDADES CORE (priorizadas):                      {{FUNCIONALIDADES}}
- VERSÃO INICIAL:                                          {{VERSAO_INICIAL}}   (ex.: 1.0.0+1)
- CONTA/PRESENÇA NAS LOJAS (se aplicável):                 {{LOJAS}}            (Google Play, App Store)
- URL DE SUPORTE:                                          {{URL_SUPORTE}}
- RESTRIÇÕES TÉCNICAS CONHECIDAS:                          {{RESTRICOES}}

=======================================================================
1. ESTRUTURA DE DOCUMENTAÇÃO A CRIAR
=======================================================================
Crie a pasta `docs/` na raiz do repositório com exatamente a seguinte árvore e
cada arquivo correspondente. Reproduza o ESQUEMA (nomes, numeração, hierarquia) do projeto de
referência VCardSmart, adaptando TODO o conteúdo aos parâmetros do novo produto. Cada arquivo
deve ter cabeçalho de metadados (Versão, Projeto, Última atualização, Status) e seção
"Documentos Relacionados".

docs/
├── 01_Product/          # PRD, visão do produto, requisitos
├── 02_Architecture/     # Arquitetura, Clean Architecture, ADRs
├── 03_DataModel/        # Modelo de dados, persistência, entidades
├── 04_UX_UI/            # Design system, componentes, fluxos
├── 05_Development/      # Guia de desenvolvimento, padrões, CI/CD
├── 08_Testing/          # Estratégia, planos, tipos de teste
├── 09_Deployment/       # Build, release, CI/CD, monitoramento
├── 10_Security/         # Criptografia, autenticação, compliance
├── 11_Legal/            # LGPD, GDPR, termos, políticas
├── 12_Marketing/        # ASO, lojas, marca, lançamento
├── 13_Roadmap/          # Visão, estratégia, evolução do produto
├── 14_AI/               # Prompts, regras, workflows de IA
├── 15_Appendix/         # Índices, glossário, ADRs, diagramas
└── 16_SprintBook/       # Sprint Book para execução via IA

Detalhamento por pasta (use como checklist de arquivos a criar; ajuste nomes técnicos ao
framework — ex.: troque referências a Hive/Riverpod/GoRouter pelos equivalentes do {{STACK}}):

{INSIRA ABAIXO A LISTA DE ARQUIVOS DE CADA FASE — veja a seção "Anexo: índice real de arquivos"
no final deste prompt e replique fielmente os nomes/numeração}

=======================================================================
2. ARTEFATO CENTRAL: PRD
=======================================================================
Gere o PRD completo (formato do arquivo 01_Product/04_PRD.md do projeto de referência) com:
1. Visão geral (nome, categoria, modelo, plataformas, framework)
2. Público-alvo e segmentos (pessoas e ambientes)
3. Funcionalidades principais priorizadas (P0/P1/P2) com tabela + status
4. Restrições (offline, sem servidor, sem analytics, sem login, etc.)
5. Premissas e dependências externas
6. Análise de risco (impacto/probabilidade/mitigação)
7. Cronograma estimado por fase (semanas)
8. Documentos relacionados

=======================================================================
3. CONTROLES DE EVOLUÇÃO (OBRIGATÓRIOS NA RAIZ)
=======================================================================
Crie na raiz do repositório (como no projeto de referência):

A) AGENTS.md — memória de contexto do projeto para agentes de IA, com:
   - Contexto do projeto (build/device, plataformas, comandos chave)
   - Stack e arquitetura
   - Estratégia de testes (suíte determinística e comandos)
   - CI/CD (GitHub Actions, secrets, pin de versão do framework)
   - Histórico de decisões técnicas relevantes (ADR resumido)
   - Versões publicadas (numeração sincronizada entre lojas)
   - Política de versão
   - PENDÊNCIAS (lista de itens abertos para a próxima interação)
   - Histórico de commits recente

B) NEXT_STEPS.md — próximos passos com:
   - Status atual (versão, branch, último commit, ambiente, analyze/test)
   - Commits recentes
   - O que foi feito na sessão
   - Comandos para testar e publicar
   - Checklist de publicação (Google Play / App Store) com itens marcados
   - Pendências antes de publicar
   - URLs importantes (suporte)
   - Ambiente local e comandos úteis

C) ROADMAP — versão seriada do produto (artefato 01_Product/17_VersionRoadmap.md + 13_Roadmap/):
   - V1 (core offline), V2, V3..., cada versão com foco, status e funcionalidades
   - Linha do tempo estimada (trimestre/ano)
   - Princípios de versão (incremental, compatível, documentado, testado)
   - Changelog por versão

=======================================================================
4. SPRINT BOOK (EXECUÇÃO VIA IA)
=======================================================================
Crie docs/16_SprintBook/ replicando:
- 00_READ_FIRST.md com "Instrução para IA" (leia tudo antes, cada sprint independente,
  nunca avance sem completar, sempre rode testes, sempre atualize docs, sempre pare ao terminar)
- Ordens de leitura obrigatórias, fluxo de trabalho, prompts de início/fim de sprint
- 01_DevelopmentRules.md, 02_DefinitionOfReady.md, 03_DefinitionOfDone.md
- Uma sprint por módulo/fase: 00_Setup, 01_Foundation, ... até a sprint de publicação nas lojas
- SprintChecklist.md e SprintMetrics.md

=======================================================================
5. MÓDULO DE IA (14_AI)
=======================================================================
Crie docs/14_AI/ replicando a estrutura de prompts do projeto de referência:
- AI_CONTEXT.md (system prompt do projeto: regras, stack, proibições)
- Bootstraps (OpenCode, GPT, Codex) com system prompt + context pack + workflow
- Prompts por módulo (criar feature, corrigir bug, refatorar, revisar)
- Prompts de teste, revisão, refatoração, documentação, debug, release
- PromptLibrary, ContextChecklist, AIRestrictions, MultiAgentWorkflow

=======================================================================
6. ÍNDICE MASTER e GLOSSÁRIO
=======================================================================
Gere docs/15_Appendix/01_MasterIndex.md indexando TODOS os arquivos criados, organizados por
fase (01–16), com a tabela de fases e status. Gere também 02_Glossary.md e os demais artefatos
da pasta Appendix (mapa de documentos, ADRs, checklists, templates, changelog, etc.).

=======================================================================
7. REGRAS DE EXECUÇÃO
=======================================================================
1. Documentation First: gere TODA a documentação/artefatos ANTES de qualquer código.
2. Use nomes de arquivo e numeração IDÊNTICOS ao padrão de referência (0x_ prefixo).
3. Todo conteúdo deve ser coerente com {{FRAMEWORK}}/{{STACK}} e {{PRINCIPIOS}}.
4. Adapte os artefatos de segurança/legal a LGPD/GDPR e aos requisitos das lojas {{LOJAS}}.
5. Ao final, gere o índice master e verifique que nenhum arquivo listado está faltando.
6. NÃO crie código de aplicação — apenas documentação, artefatos e controles de evolução.
7. Se houver repositório GIT, crie os arquivos na branch atual e sugira commit ao final.
8. Entregue um resumo: quantos arquivos por fase, total de arquivos, e a lista de pendências
   iniciais para a primeira interação de desenvolvimento.
```

---

## Anexo: índice real de arquivos (padrão de referência do VCardSmart)

Replique fielmente a numeração e os nomes abaixo, adaptando apenas os detalhes técnicos
(Hive/Riverpod/GoRouter → equivalentes do `{{STACK}}`) e o conteúdo de produto.

### 01 — Product
`01_PRD_Visao_do_Produto.md`, `01_ProductVision.md`, `02_ProductMission.md`,
`03_ProductObjectives.md`, `04_PRD.md`, `05_Especificacao_Funcional.md`, `05_Features.md`,
`06_UserStories.md`, `07_UseCases.md`, `08_BusinessRules.md`, `09_FunctionalRequirements.md`,
`10_NonFunctionalRequirements.md`, `11_AcceptanceCriteria.md`, `12_Permissions.md`,
`13_Privacy.md`, `14_Monetization.md`, `15_Internationalization.md`, `16_Accessibility.md`,
`17_VersionRoadmap.md`, `18_Glossary.md`, `PROJECT_CONSTITUTION.md`

### 02 — Architecture
`01_ArchitectureOverview.md`, `02_Arquitetura.md`, `02_CleanArchitecture.md`,
`03_ProjectStructure.md`, `04_DependencyRules.md`, `05_StateManagement.md`, `06_Navigation.md`,
`07_DatabaseArchitecture.md`, `08_LocalStorage.md`, `09_NFCArchitecture.md`,
`10_QRCodeArchitecture.md`, `11_VCardArchitecture.md`, `12_ContactsArchitecture.md`,
`13_SecurityArchitecture.md`, `14_AdsArchitecture.md`, `15_InternationalizationArchitecture.md`,
`16_ErrorHandling.md`, `17_Logging.md`, `18_OfflineStrategy.md`, `19_Performance.md`,
`20_PackageStandards.md`, `21_ArchitectureDecisionRecords.md`

### 03 — Data Model
`01_DataModelOverview.md`, `02_HiveArchitecture.md`, `03_Entities.md`, `03_Modelo_de_Dados.md`,
`04_ValueObjects.md`, `05_DTOs.md`, `06_JSONSchema.md`, `07_VCardSchema.md`, `08_HiveBoxes.md`,
`09_Relationships.md`, `10_ValidationRules.md`, `11_DataLifecycle.md`, `12_Migrations.md`,
`13_BackupStrategy.md`, `14_DataSecurity.md`, `15_ImportExport.md`, `16_SequenceDiagrams.md`,
`17_ERDiagram.md`, `18_ClassDiagram.md`, `19_Versioning.md`

### 04 — UX/UI
`01_UXVision.md`, `02_DesignSystem.md`, `03_ColorPalette.md`, `04_Typography.md`,
`04_UX_UI.md`, `05_Icons.md`, `06_Spacing.md`, `07_Components.md`, `08_Layouts.md`,
`09_Navigation.md`, `10_Screens.md`, `11_UserFlows.md`, `12_States.md`, `13_Dialogs.md`,
`14_Animations.md`, `15_DarkMode.md`, `16_Accessibility.md`, `17_ResponsiveDesign.md`,
`18_Notifications.md`, `19_Onboarding.md`, `20_Wireframes.md`, `21_Prototype.md`, `ADR-017.md`

### 05 — Development
`01_DevelopmentGuide.md`, `02_FlutterStandards.md`, `03_DirectoryStructure.md`,
`04_CodingStandards.md`, `05_NamingConvention.md`, `06_ArchitectureLayers.md`,
`07_DependencyInjection.md`, `08_StateManagement.md`, `09_Routing.md`, `10_Repositories.md`,
`11_UseCases.md`, `12_Services.md`, `13_Providers.md`, `14_Controllers.md`,
`15_ErrorHandling.md`, `16_Logging.md`, `17_TestStrategy.md`, `18_CodeReview.md`,
`19_GitStrategy.md`, `20_CICD.md`, `21_DefinitionOfDone.md`, `22_AIImplementationRules.md`,
`23_OpenCodeWorkflow.md`, ADRs e guias de engenharia/workshop

### 08 — Testing
`01_TestStrategy.md`, `02_TestPlan.md`, `03_TestLevels.md`, `04_UnitTests.md`,
`05_WidgetTests.md`, `06_IntegrationTests.md`, `07_GoldenTests.md`, `08_EndToEndTests.md`,
`09_PerformanceTests.md`, `10_SecurityTests.md`, `11_CompatibilityTests.md`,
`12_AccessibilityTests.md`, `13_InternationalizationTests.md`, `14_RegressionTests.md`,
`15_UserAcceptanceTests.md`, `16_TestData.md`, `17_BugLifecycle.md`, `18_QAChecklists.md`,
`19_ReleaseChecklist.md`, `20_TestCoverage.md`, `21_RiskMatrix.md`

### 09 — Deployment
`01_DeploymentOverview.md`, `02_DevelopmentEnvironment.md`, `03_VSCodeSetup.md`,
`04_FlutterSetup.md`, `05_ProjectBootstrap.md`, `06_Dependencies.md`, `07_BuildProfiles.md`,
`07_Build_Deploy.md`, `08_AndroidBuild.md`, `09_iOSBuild.md`, `10_CodeSigning.md`,
`11_GooglePlay.md`, `12_AppStore.md`, `13_Fastlane.md`, `14_GitHubActions.md`,
`15_Versioning.md`, `16_ReleaseProcess.md`, `17_HotfixProcess.md`, `18_Rollback.md`,
`19_Monitoring.md`, `20_UpdatePolicy.md`, `21_DisasterRecovery.md`, `VERSIONING.md`

### 10 — Security
`01_SecurityOverview.md`, `02_SecurityPolicy.md`, `03_PrivacyPolicySpecification.md`,
`04_ThreatModel.md`, `05_RiskAssessment.md`, `06_DataProtection.md`, `07_Cryptography.md`,
`08_BiometricAuthentication.md`, `08_Seguranca.md`, `09_PINAuthentication.md`,
`10_SecureStorage.md`, `11_HiveSecurity.md`, `12_Permissions.md`, `13_ContactPermissions.md`,
`14_QRSecurity.md`, `15_NFCSecurity.md`, `16_VCardSecurity.md`, `17_ApplicationHardening.md`,
`18_PrivacyByDesign.md`, `19_LGPDCompliance.md`, `20_SecurityChecklist.md`,
`21_IncidentResponse.md`

### 11 — Legal
`01_LegalOverview.md`, `02_PrivacyPolicy.md`, `03_TermsOfUse.md`, `04_LGPDCompliance.md`,
`05_GDPRCompliance.md`, `06_GooglePlayCompliance.md`, `07_AppleGuidelinesCompliance.md`,
`08_OpenSourceLicenses.md`, `09_ThirdPartyLibraries.md`, `10_AdsCompliance.md`,
`11_ConsentManagement.md`, `12_DataRetention.md`, `13_DataDeletion.md`, `14_ChildrenPolicy.md`,
`15_IntellectualProperty.md`, `16_TrademarkPolicy.md`, `17_CopyrightPolicy.md`,
`18_Disclaimer.md`, `19_SupportPolicy.md`, `20_ComplianceChecklist.md`,
`21_LegalReviewChecklist.md`

### 12 — Marketing
`01_MarketingOverview.md`, `02_BrandIdentity.md`, `03_BrandGuidelines.md`, `04_Naming.md`,
`05_ASOStrategy.md`, `06_GooglePlayListing.md`, `07_AppStoreListing.md`,
`08_MultilingualStoreTexts.md`, `09_Keywords.md`, `10_VisualAssets.md`, `11_Screenshots.md`,
`12_FeatureGraphic.md`, `13_AppIcon.md`, `14_SplashScreen.md`, `15_WebsiteSpecification.md`,
`16_SupportCenter.md`, `17_FeedbackStrategy.md`, `18_LaunchPlan.md`, `19_PostLaunch.md`,
`20_KPIs.md`, `21_Monetization.md`

### 13 — Roadmap
`01_ProductVision.md`, `02_ProductStrategy.md`, `03_ProductLifecycle.md`,
`04_VersionRoadmap.md`, `05_FreeVersion.md`, `06_PremiumVersion.md`, `07_FeatureBacklog.md`,
`08_PriorityMatrix.md`, `09_ProductMetrics.md`, `09_Roadmap.md`, `10_UserFeedback.md`,
`11_ArchitectureEvolution.md`, `12_MonetizationRoadmap.md`, `13_APIReadiness.md`,
`14_CloudReadiness.md`, `15_PlatformExpansion.md`, `16_EnterpriseEdition.md`,
`17_ReleaseTimeline.md`, `18_DeprecationPolicy.md`, `19_RiskManagement.md`,
`20_LongTermVision.md`, `21_RoadmapADRs.md`

### 14 — AI
`01_AIOverview.md`, `02_SystemPrompt.md`, `03_ProjectContext.md`, `04_CodingRules.md`,
`05_ImplementationWorkflow.md`, `06_Guia_IA.md`, `06_ModulePrompts.md`, `07_TestPrompts.md`,
`08_ReviewPrompts.md`, `09_RefactoringPrompts.md`, `10_DocumentationPrompts.md`,
`11_DebugPrompts.md`, `12_ReleasePrompts.md`, `13_ContextChecklist.md`, `14_AIRestrictions.md`,
`15_PromptLibrary.md`, `16_OpenCodeBootstrap.md`, `17_GPTBootstrap.md`, `18_CodexBootstrap.md`,
`19_MultiAgentWorkflow.md`, `20_ContextCompression.md`, `AI_ARCHITECTURE.md`,
`AI_CHECKLISTS.md`, `AI_CONTEXT.md`, `AI_DECISIONS.md`, `AI_DEVELOPMENT_FLOW.md`,
`AI_MEMORY.md`, `AI_PROMPTS.md`, `AI_RULES.md`, `prompts.md`, `roteiro-opencode.md`

### 15 — Appendix
`01_MasterIndex.md`, `02_Glossary.md`, `03_ADRIndex.md`, `04_ArchitectureIndex.md`,
`05_DocumentMap.md`, `06_MermaidDiagrams.md`, `07_UML.md`, `08_ERD.md`,
`09_SequenceDiagrams.md`, `10_ComponentDiagrams.md`, `11_PackageDiagrams.md`,
`12_DecisionMatrix.md`, `13_Checklists.md`, `14_Templates.md`, `15_FAQ.md`,
`16_Troubleshooting.md`, `17_References.md`, `18_VersionHistory.md`, `19_WorkspaceAudit.md`,
`20_FinalReview.md`, `CHANGELOG.md`, `CODE_OF_CONDUCT.md`, `PROJECT_STATUS.md`, `TODO.md`,
`contributing.md`, `decisions.md`, `license.md`

### 16 — Sprint Book
`00_READ_FIRST.md`, `01_DevelopmentRules.md`, `02_DefinitionOfReady.md`,
`03_DefinitionOfDone.md`, `04_Sprint0_Setup.md`, `05_Sprint01_Foundation.md`,
`06_Sprint02_DesignSystem.md`, `07_Sprint03_LocalDatabase.md`, `08_Sprint04_ProfileModule.md`,
`09_Sprint05_PhotoModule.md`, `10_Sprint06_QRCode.md`, `11_Sprint07_vCard.md`,
`12_Sprint08_NFC.md`, `13_Sprint09_Contacts.md`, `14_Sprint10_Security.md`,
`15_Sprint11_Settings.md`, `16_Sprint12_Multilanguage.md`, `17_Sprint13_Ads.md`,
`18_Sprint14_Testing.md`, `19_Sprint15_Optimization.md`, `20_Sprint16_StoreRelease.md`,
`SprintChecklist.md`, `SprintMetrics.md`

### Na raiz do repositório
`AGENTS.md`, `NEXT_STEPS.md`, `README.md`

---

## Como preencher as variáveis

| Variável | Exemplo (VCardSmart) |
|----------|----------------------|
| `{{NOME_PRODUTO}}` | `VCardSmart` |
| `{{NOME_EXIBICAO}}` | `VCardSmart` |
| `{{CATEGORIA}}` | `Business / Networking` |
| `{{PLATAFORMAS}}` | `Android, iOS` |
| `{{FRAMEWORK}}` | `Flutter / Dart` |
| `{{STACK}}` | `Riverpod, GoRouter, Hive (AES-256), NFC, QR, vCard, flutter_contacts, local_auth, google_mobile_ads` |
| `{{PERSISTENCIA}}` | `100% local (offline-first), sem nuvem` |
| `{{PRINCIPIOS}}` | `Offline First, Privacy First, Security First, AI Driven, Documentation First` |
| `{{MONETIZACAO}}` | `AdMob (banner + interstitial) + premium futuro` |
| `{{PUBLICO_ALVO}}` | `Empresários, consultores, profissionais liberais, executivos — eventos, BNI, feiras` |
| `{{FUNCIONALIDADES}}` | `Perfil, NFC, QR, vCard, biometria/PIN, temas, i18n (8 idiomas), WhatsApp, ads` |
| `{{VERSAO_INICIAL}}` | `1.0.0+1` |
| `{{LOJAS}}` | `Google Play + App Store` |
| `{{URL_SUPORTE}}` | `https://sites.google.com/...` |
| `{{RESTRICOES}}` | `Sem servidor, sem analytics, sem login, armazenamento apenas local` |

---

## Uso prático (exemplo de invocação)

Copie o bloco **PROMPT REVERSO**, preencha as variáveis, e cole em um agente com acesso de
escrita ao repositório GIT de destino. Exemplo de abertura:

> "Crie neste repositório o sistema completo de artefatos e controles de evolução.
> NOME_PRODUTO=MeuApp; CATEGORIA=Productivity; FRAMEWORK=Flutter/Dart; ..."

O agente deve gerar toda a árvore `docs/` + `AGENTS.md` + `NEXT_STEPS.md` + `README.md`,
propondo um commit inicial ao final.
