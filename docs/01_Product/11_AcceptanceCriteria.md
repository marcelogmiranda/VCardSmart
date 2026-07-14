# Acceptance Criteria

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Objetivo

Definir os critérios oficiais que determinam quando uma funcionalidade é considerada concluída.

Nenhuma funcionalidade poderá ser considerada pronta sem atender integralmente aos critérios definidos neste documento.

---

## Modelo de Critério

Cada critério possui:
- Identificador único
- Nome da funcionalidade
- Objetivo
- Pré-condições
- Fluxo esperado
- Critérios obrigatórios
- Critérios de rejeição
- Casos de teste
- Resultado esperado
- Prioridade
- Versão
- Observações

---

## AC001 – Cadastro Inicial

**Objetivo:** Permitir que o usuário configure seu cartão digital pela primeira vez.

**Pré-condições:**
- Aplicativo recém-instalado
- Banco Hive vazio

**Fluxo Esperado:**
1. App detecta banco vazio
2. Exibe tela de boas-vindas
3. Solicita permissões necessárias
4. Solicita consentimento para acessar contatos
5. Exibe formulário de cadastro
6. Usuário preenche dados
7. Usuário confirma
8. Dados são salvos no Hive

**Critérios Obrigatórios:**
- ✅ Exibir tela de boas-vindas
- ✅ Solicitar permissões necessárias
- ✅ Solicitar consentimento para acessar contatos
- ✅ Nunca importar dados automaticamente
- ✅ Permitir preenchimento manual
- ✅ Salvar perfil somente após confirmação
- ✅ Armazenar exclusivamente no Hive
- ✅ Não acessar internet
- ✅ Não criar conta
- ✅ Não solicitar login
- ✅ Não enviar Analytics

**Critérios de Rejeição:**
- ❌ Salvar automaticamente
- ❌ Compartilhar dados
- ❌ Enviar informações externas
- ❌ Criar qualquer comunicação com servidor

**Casos de Teste:**
- Primeira instalação
- Reinstalação
- Permissões negadas
- Permissões concedidas
- Banco vazio
- Banco existente

**Prioridade:** P0
**Versão:** 1.0

---

## AC002 – Compartilhamento NFC

**Objetivo:** Compartilhar o cartão digital via NFC.

**Pré-condições:**
- Cartão criado
- Dispositivo com NFC

**Fluxo Esperado:**
1. Usuário acessa compartilhamento
2. Seleciona NFC
3. Confirma envio
4. Dispositivo ativa NFC
5. Detecta receptor
6. Transmite dados
7. Receptor confirma
8. Dados são importados

**Critérios Obrigatórios:**
- ✅ Funcionar offline
- ✅ Solicitar confirmação antes do envio
- ✅ Mostrar progresso
- ✅ Solicitar confirmação no destino
- ✅ Permitir cancelar
- ✅ Importar somente após confirmação
- ✅ Registrar somente após confirmação
- ✅ Atualizar agenda somente mediante autorização

**Critérios de Rejeição:**
- ❌ Compartilhar automaticamente
- ❌ Salvar automaticamente
- ❌ Sobrescrever contatos
- ❌ Compartilhar sem consentimento

**Casos de Teste:**
- Envio Android → Android
- Envio iOS → iOS
- Envio Android → iOS
- Envio iOS → Android
- Cancelamento durante envio
- Dispositivo sem NFC
- Transmissão interrompida

**Prioridade:** P0
**Versão:** 1.0

---

## AC003 – QR Code

**Objetivo:** Gerar e ler QR Code com dados do cartão.

**Pré-condições:**
- Cartão criado (para geração)
- Câmera disponível (para leitura)

**Fluxo Esperado (Geração):**
1. Usuário acessa compartilhamento
2. Seleciona QR Code
3. Sistema gera localmente
4. QR é exibido na tela

**Fluxo Esperado (Leitura):**
1. Usuário acessa importar
2. Seleciona ler QR
3. Câmera é ativada
4. QR é decodificado
5. Dados são exibidos
6. Usuário confirma importação

**Critérios Obrigatórios:**
- ✅ Gerar QR localmente
- ✅ Nunca utilizar servidor
- ✅ QR contendo vCard e metadados definidos
- ✅ Leitura em menos de 3 segundos (em condições normais)
- ✅ Solicitar confirmação antes da importação
- ✅ Compatível entre Android e iOS

**Critérios de Rejeição:**
- ❌ Utilizar servidor para geração
- ❌ QR sem dados da vCard
- ❌ Importar sem confirmação
- ❌ Incompatibilidade entre plataformas

**Casos de Teste:**
- Geração com dados completos
- Geração com dados parciais
- Leitura Android → Android
- Leitura iOS → iOS
- Leitura Android → iOS
- Leitura iOS → Android
- QR com baixa luminosidade
- QR com distância variável

**Prioridade:** P0
**Versão:** 1.0

---

## AC004 – vCard

**Objetivo:** Gerar e importar vCard padronizado.

**Pré-condições:**
- Cartão criado (para geração)
- vCard recebido (para importação)

**Critérios Obrigatórios:**
- ✅ Gerar vCard padrão RFC 6350
- ✅ Incluir apenas informações autorizadas pelo usuário
- ✅ Validar campos obrigatórios
- ✅ Compatível com Android
- ✅ Compatível com iOS
- ✅ Compatível com Outlook, Apple Contacts e Google Contacts

**Critérios de Rejeição:**
- ❌ Formato inválido de vCard
- ❌ Incluir dados não autorizados
- ❌ Falta de campos obrigatórios
- ❌ Incompatibilidade com plataformas

**Casos de Teste:**
- vCard com todos os campos
- vCard com campos obrigatórios apenas
- Importação em Outlook
- Importação em Apple Contacts
- Importação em Google Contacts
- vCard com caracteres especiais
- vCard com emojis

**Prioridade:** P0
**Versão:** 1.0

---

## AC005 – Biometria

**Objetivo:** Proteger acesso ao aplicativo com autenticação.

**Pré-condições:**
- Dispositivo com ou sem biometria

**Critérios Obrigatórios:**
- ✅ Detectar disponibilidade
- ✅ Utilizar Face ID quando disponível
- ✅ Utilizar impressão digital quando disponível
- ✅ Solicitar PIN quando biometria indisponível
- ✅ Nunca armazenar dados biométricos
- ✅ Utilizar apenas APIs oficiais

**Critérios de Rejeição:**
- ❌ Armazenar dados biométricos
- ❌ Utilizar bibliotecas não oficiais
- ❌ Bloquear acesso sem opção de fallback

**Casos de Teste:**
- Face ID disponível e funcionando
- Impressão digital disponível e funcionando
- Biometria indisponível (fallback PIN)
- Tentativas falhas de biometria
- Tentativas falhas de PIN
- Dispositivo sem hardware biométrico

**Prioridade:** P0
**Versão:** 1.0

---

## AC006 – Anúncios

**Objetivo:** Monetizar versão gratuita com anúncios não intrusivos.

**Critérios Obrigatórios:**
- ✅ Nunca mostrar anúncios durante: cadastro, compartilhamento, leitura QR, NFC, biometria, configurações
- ✅ Exibir somente em telas permitidas
- ✅ Seguir políticas da Google Play e App Store

**Critérios de Rejeição:**
- ❌ Anúncio durante compartilhamento
- ❌ Anúncio durante cadastro
- ❌ Anúncio durante leitura QR
- ❌ Anúncio durante NFC
- ❌ Anúncio durante biometria
- ❌ Anúncio durante configurações
- ❌ Violação de políticas das lojas

**Casos de Teste:**
- Anúncio exibido em tela permitida
- Anúncio NÃO exibido em todas as telas restritas
- Remoção de anúncio durante navegação
- Validação com políticas das lojas

**Prioridade:** P1
**Versão:** 1.0

---

## AC007 – Internacionalização

**Objetivo:** Suportar múltiplos idiomas.

**Critérios Obrigatórios:**
- ✅ Nenhuma string fixa
- ✅ Utilizar ARB
- ✅ Troca dinâmica de idioma
- ✅ Seguir idioma do sistema quando configurado

**Critérios de Rejeição:**
- ❌ Strings fixas no código
- ❌ Formato diferente de ARB
- ❌ Necessidade de reiniciar para trocar idioma

**Casos de Teste:**
- Troca para cada um dos 8 idiomas
- Verificação de strings faltantes
- Idioma do sistema detectado corretamente
- Troca dinâmica sem reinício

**Prioridade:** P1
**Versão:** 1.0

---

## AC008 – Tema

**Objetivo:** Permitir personalização visual.

**Critérios Obrigatórios:**
- ✅ Claro
- ✅ Escuro
- ✅ Sistema
- ✅ Alteração sem reiniciar aplicativo

**Critérios de Rejeição:**
- ❌ Falta de algum tema
- ❌ Necessidade de reiniciar para trocar tema
- ❌ Inconsistência visual entre temas

**Casos de Teste:**
- Troca para tema claro
- Troca para tema escuro
- Troca para tema do sistema
- Persistência entre sessões
- Todos os componentes adaptados

**Prioridade:** P1
**Versão:** 1.0

---

## AC009 – Privacidade

**Objetivo:** Garantir total privacidade do usuário.

**Critérios Obrigatórios:**
- ✅ Sem Analytics
- ✅ Sem Firebase
- ✅ Sem Cloud
- ✅ Sem Login
- ✅ Sem Rastreamento
- ✅ Sem Cookies
- ✅ Sem coleta de dados
- ✅ Todo armazenamento local

**Critérios de Rejeição:**
- ❌ Qualquer comunicação com servidor
- ❌ Qualquer coleta de dados
- ❌ Qualquer rastreamento
- ❌ Qualquer armazenamento em nuvem

**Casos de Teste:**
- Monitoramento de tráfego de rede (deve ser zero)
- Verificação de dependências (nenhuma de analytics)
- Verificação de logs (nenhum dado coletado)
- Verificação de armazenamento (apenas Hive)

**Prioridade:** P0
**Versão:** 1.0

---

## AC010 – Performance

**Objetivo:** Garantir experiência fluida e rápida.

**Critérios Obrigatórios:**
- ✅ Inicialização em até 2 segundos (dispositivos compatíveis)
- ✅ Compartilhamento NFC em até 5 segundos
- ✅ Geração de QR em até 1 segundo
- ✅ Leitura de QR em até 3 segundos
- ✅ Interface fluida a 60 FPS ou superior, quando suportado pelo hardware

**Critérios de Rejeição:**
- ❌ Inicialização > 2 segundos
- ❌ NFC > 5 segundos
- ❌ QR geração > 1 segundo
- ❌ QR leitura > 3 segundos
- ❌ Interface abaixo de 30 FPS

**Casos de Teste:**
- Benchmark de inicialização
- Benchmark de compartilhamento NFC
- Benchmark de geração de QR
- Benchmark de leitura de QR
- Teste de FPS em diferentes dispositivos
- Teste com dispositivos de baixa performance

**Prioridade:** P0
**Versão:** 1.0

---

## Critérios Gerais de Aceitação

Além dos critérios específicos, toda funcionalidade deverá cumprir obrigatoriamente:

1. Respeitar a Clean Architecture
2. Seguir os princípios SOLID
3. Ter cobertura de testes definida para o projeto
4. Passar em `flutter analyze` sem erros
5. Estar formatada com `dart format`
6. Não introduzir dependências não aprovadas
7. Atualizar a documentação correspondente
8. Atualizar o changelog quando houver alteração funcional
9. Manter compatibilidade com Android e iOS nas versões mínimas suportadas
10. Preservar o funcionamento offline

---

## Integração com o Restante da Documentação

Este documento não ficará isolado. Ele será referenciado por:

- **PRD** → cada requisito funcional apontará para um ou mais critérios de aceitação
- **Casos de Uso** → cada fluxo indicará quais critérios devem ser satisfeitos
- **Plano de Testes** → cada caso de teste validará critérios específicos
- **Prompts da IA** → antes de implementar qualquer funcionalidade, a IA deverá consultar os critérios correspondentes
- **CI/CD** → a pipeline poderá incluir uma etapa de verificação para garantir que toda nova funcionalidade esteja associada a critérios de aceitação documentados

---

## Decisão Arquitetural

**ADR-009:** Toda funcionalidade deve possuir critérios de aceitação documentados antes de sua implementação.

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [09_FunctionalRequirements.md](./09_FunctionalRequirements.md)
- [10_NonFunctionalRequirements.md](./10_NonFunctionalRequirements.md)
