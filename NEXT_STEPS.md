# Plano de Mudanças - VCardSmart

## Contexto

### iOS - Guideline 5.6 (Developer Code of Conduct)
O app foi rejeitado com "Review Suspended" por não atender aos padrões de qualidade da App Store. A seção 5.6.4 (App Quality) estabelece:

> "Customers expect the highest quality from the App Store, and maintaining high quality content, services, and experiences promotes customer trust. Indications that this expectation is not being met include excessive customer reports about concerns with your app, such as negative customer reviews, and excessive refund requests."

**Ações necessárias:**
- Garantir experiência polida e confiável
- Eliminar inconsistências, conteúdo placeholder, elementos inacabados
- Estabilidade em todos os dispositivos suportados
- Design pensado e testado em cada tela

### Android - Edge-to-Edge
Já implementado via `WindowCompat.setDecorFitsSystemWindows(window, false)` no `MainActivity.kt` para API 30+. Para API 35+ (Android 15+), o edge-to-edge é forçado pelo sistema. **Nenhuma ação adicional necessária.**

---

## 1. Nova Aba NFC na Barra de Navegação

### Objetivo
Mover a funcionalidade NFC de dentro da página QR Share para uma aba dedicada na barra de navegação inferior.

### Especificações da Nova Página NFC (`/nfc`)

**Detecção Automática:**
- Ao acessar a página, verificar se o dispositivo tem NFC disponível
- Usar o `NfcManager.instance.isAvailable()` existente

**Caso NFC disponível:**
- Mostrar duas opções:
  1. **Gravar Cartão** - Grava vCard em cartão NFC externo
  2. **Receber Contato** - Lê vCard de cartão NFC externo

**Caso NFC não disponível:**
- Mostrar mensagem amigável: "NFC não disponível neste dispositivo"
- Explicar que a funcionalidade requer hardware NFC
- Botão "Voltar" para navegação

### Mudanças na Barra de Navegação (ShellPage)

**Antes (3 abas):**
1. Home (/)
2. Contatos (/contacts)
3. Configurações (/settings)

**Depois (4 abas):**
1. Home (/)
2. Contatos (/contacts)
3. **NFC (/nfc)** - NOVA (antes de Configurações)
4. Configurações (/settings)

**Ícone sugerido:** `Icons.contactless` (já usado no botão atual)

### Arquivos a Modificar

1. **Criar:** `lib/features/nfc/presentation/pages/nfc_main_page.dart`
   - Página centralizada com detecção automática
   - Interface limpa e intuitiva

2. **Modificar:** `lib/core/router/shell_page.dart`
   - Adicionar 4ª aba na NavigationBar
   - Adicionar rota `/nfc` no ShellRoute

3. **Modificar:** `lib/core/router/app_router.dart`
   - Mover `/nfc` para dentro do ShellRoute
   - Manter sub-rotas `/nfc/share` e `/nfc/receive` fora do shell

4. **Modificar:** `lib/core/constants/app_constants.dart`
   - Adicionar constante `nfcRoute = '/nfc'`

5. **Modificar:** `lib/features/qr_code/presentation/pages/qr_share_page.dart`
   - Remover botão "Gravar em Cartão NFC"
   - Manter apenas QR Code + Copiar + Enviar

---

## 2. Revisão de Qualidade iOS (Guideline 5.6)

### Áreas Críticas para Revisar

1. **Consistência Visual**
   - Cores, tipografia, espaçamento em todas as telas
   - Estados vazios (sem perfil, sem contatos)
   - Feedback visual (loading, sucesso, erro)

2. **UX/Usabilidade**
   - Fluxo de onboarding claro
   - Navegação intuitiva
   - Mensagens de erro amigáveis
   - Confirmações antes de ações destrutivas

3. **Estabilidade**
   - Tratamento de erros em todas as operações
   - Loading states adequados
   - Sem crashes ou comportamentos inesperados

4. **Conteúdo**
   - Textos claros e sem placeholder
   - Instruções de uso quando necessário
   - Localização adequada (pt-BR)

5. **Performance**
   - Imagens otimizadas (ResizeImage já implementado)
   - Sem Memory leaks
   - Carregamento eficiente

### Ações Específicas

- Revisar todas as telas principais
- Verificar estados vazios
- Testar fluxos completos
- Validar mensagens de erro
- Verificar acessibilidade básica

---

## Ordem de Implementação

1. **Fase 1: NFC (Prioridade)**
   - Criar nova página NFC
   - Atualizar navegação
   - Remover botão da QR Share

2. **Fase 2: Qualidade iOS**
   - Revisão visual completa
   - Ajustes de UX
   - Testes de estabilidade

3. **Fase 3: Validação**
   - Testar em Android (Redmi)
   - Testar em iOS (iPhone)
   - Submeter às lojas

---

## Resumo das Decisões

- **Posição da aba NFC:** Posição 3 (antes de Configurações)
- **Detecção automática:** Sim, com mensagem amigável quando não disponível
- **Revisão de qualidade:** Completa, focada nos requisitos da Guideline 5.6