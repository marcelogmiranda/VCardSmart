# Features

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Modelo de Feature

Cada funcionalidade receberá:

- Identificador único
- Objetivo
- Descrição
- Prioridade (P0, P1, P2)
- Dependências
- Fluxo
- Critérios de Aceitação
- Testes
- Exemplo

---

## F01 – Cadastro de Perfil

### Objetivo
Permitir que o usuário crie e configure seu cartão digital profissional.

### Descrição
Formulário completo para dados profissionais, incluindo foto, logotipo, informações de contato e redes sociais.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Hive configurado
- Permissões de câmera (para foto)
- Permissões de contatos (opcional)

### Fluxo
```
Aplicativo aberto → Tela de boas-vindas → Preencher dados → Confirmar → Salvar no Hive → Cartão criado
```

### Critérios de Aceitação
- Exibir tela de boas-vindas na primeira execução
- Solicitar permissões necessárias antes de acessar
- Permitir preenchimento manual
- Salvar perfil somente após confirmação
- Armazenar exclusivamente no Hive
- Não acessar internet
- Não criar conta
- Não solicitar login

### Testes
- Primeira instalação
- Reinstalação
- Permissões negadas
- Permissões concedidas
- Banco vazio
- Banco existente

### Exemplo
Usuário preenche nome, cargo, empresa, telefone, e-mail, site e redes sociais. Confirma. Cartão está pronto para compartilhar.

---

## F02 – Compartilhamento NFC

### Objetivo
Compartilhar o cartão digital via aproximando dois dispositivos.

### Descrição
Utilização do protocolo NFC para transmissão do cartão de forma segura e instantânea.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Hardware NFC no dispositivo
- Permissão NFC
- Cartão criado (F01)

### Fluxo
```
Aproximar celulares → Confirmar envio → Transmitir dados → Receptor confirma → Importar → Salvar
```

### Critérios de Aceitação
- Funcionar 100% offline
- Solicitar confirmação antes do envio
- Mostrar progresso durante transmissão
- Solicitar confirmação no destino
- Permitir cancelar a qualquer momento
- Importar somente após confirmação
- Tempo inferior a 5 segundos

### Testes
- Dois dispositivos Android
- Dois dispositivos iOS
- Android para iOS
- iOS para Android
- Dispositivo sem NFC
- Cancelamento durante envio

### Exemplo
João aproxima seu iPhone do Android de Maria. Ambos confirmam. Maria recebe o cartão e importa seus contatos.

---

## F03 – QR Code Estático

### Objetivo
Gerar um QR Code contendo os dados do cartão para compartilhamento visual.

### Descrição
Geração local de QR Code com codificação vCard completa.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Cartão criado (F01)

### Fluxo
```
Abrir QR → Gerar localmente → Exibir → Outro dispositivo lê → Confirma importação → Salva
```

### Critérios de Aceitação
- Gerar QR localmente
- Nunca utilizar servidor
- QR contendo vCard e metadados definidos
- Compatível entre Android e iOS
- Solicitar confirmação antes da importação

### Testes
- Geração com dados completos
- Geração com dados parciais
- Leitura Android → Android
- Leitura iOS → iOS
- Leitura Android → iOS
- Leitura iOS → Android

### Exemplo
Usuário abre tela de QR. Código é gerado instantaneamente. Outro usuário aponta a câmera. Dados são importados.

---

## F04 – Leitura de QR Code

### Objetivo
Ler QR Codes de outros dispositivos e importar o cartão.

### Descrição
Utilização da câmera para decodificar QR Code com dados vCard.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Permissão de câmera
- QR Code válido

### Fluxo
```
Abrir leitor → Apontar câmera → Decodificar → Exibir dados → Confirmar importação → Salvar
```

### Critérios de Aceitação
- Leitura em menos de 3 segundos (em condições normais)
- Exibir dados antes da importação
- Solicitar confirmação antes de salvar
- Compatível entre Android e iOS

### Testes
- Leitura rápida
- Leitura com baixa luminosidade
- Leitura com distância variável
- QR danificado parcialmente

### Exemplo
Usuário aponta câmera para QR Code. Dados são decodificados. Tela mostra informações. Usuário confirma importação.

---

## F05 – Geração de vCard

### Objetivo
Gerar arquivo vCard padronizado a partir dos dados do cartão.

### Descrição
Criação de vCard compatível com RFC 6350.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Cartão criado (F01)

### Fluxo
```
Cartão criado → Gerar vCard → Formatar RFC 6350 → Disponibilizar para compartilhamento
```

### Critérios de Aceitação
- Gerar vCard padrão RFC 6350
- Incluir apenas informações autorizadas pelo usuário
- Validar campos obrigatórios
- Compatível com Android
- Compatível com iOS
- Compatível com Outlook, Apple Contacts e Google Contacts

### Testes
- vCard com todos os campos
- vCard com campos obrigatórios apenas
- Importação em Outlook
- Importação em Apple Contacts
- Importação em Google Contacts

### Exemplo
Cartão com nome, cargo, empresa, telefone e e-mail é convertido para vCard válido.

---

## F06 – Importação de vCard

### Objetivo
Importar vCard de outros dispositivos e salvar como contato.

### Descrição
Recebimento e processamento de vCard.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- vCard recebido (via NFC ou QR)
- Permissão de contatos (opcional)

### Fluxo
```
vCard recebido → Validar → Exibir dados → Confirmar → Salvar no Hive → (Opcional) Atualizar agenda
```

### Critérios de Aceitação
- Validar formato vCard
- Exibir dados antes de salvar
- Solicitar confirmação
- Salvar no Hive
- Oferecer opção de atualizar agenda do dispositivo

### Testes
- Importação com sucesso
- Importação com dados inválidos
- Importação duplicada
- Atualização de agenda

### Exemplo
Usuário recebe vCard via NFC. Dados são exibidos. Confirma. Contato é salvo no app e opcionalmente na agenda.

---

## F07 – Biometria/PIN

### Objetivo
Proteger acesso ao aplicativo com autenticação biométrica ou PIN.

### Descrição
Utilização de Face ID, impressão digital ou PIN como fallback.

### Prioridade
P0 (Obrigatório para V1)

### Dependências
- Dispositivo com biometria (ou não)

### Fluxo
```
Abrir app → Detectar biometria → Solicitar autenticação → Permitir acesso
```

### Critérios de Aceitação
- Detectar disponibilidade de biometria
- Utilizar Face ID quando disponível
- Utilizar impressão digital quando disponível
- Solicitar PIN quando biometria indisponível
- Nunca armazenar dados biométricos
- Utilizar apenas APIs oficiais

### Testes
- Face ID disponível
- Impressão digital disponível
- Biometria indisponível (fallback PIN)
- Tentativas falhas

### Exemplo
Usuário abre app. Face ID é solicitada. Autenticado. Acesso liberado.

---

## F08 – Temas

### Objetivo
Permitir personalização visual do aplicativo.

### Descrição
Temas claro, escuro e automático (sistema).

### Prioridade
P1 (Desejável para V1)

### Dependências
- Nenhuma

### Fluxo
```
Configurações → Temas → Selecionar → Aplicar imediatamente
```

### Critérios de Aceitação
- Tema claro
- Tema escuro
- Tema do sistema
- Alteração sem reiniciar aplicativo
- Manter preferência entre sessões

### Testes
- Troca de tema
- Persistência de preferência
- Compatibilidade com todos os componentes

### Exemplo
Usuário muda para tema escuro. Interface muda imediatamente. App fecha e reabre. Tema é mantido.

---

## F09 – Internacionalização

### Objetivo
Suportar múltiplos idiomas.

### Descrição
Sistema de tradução via ARB.

### Prioridade
P1 (Desejável para V1)

### Dependências
- Arquivos ARB configurados

### Fluxo
```
Configurações → Idioma → Selecionar → Aplicar imediatamente
```

### Critérios de Aceitação
- Nenhuma string fixa no código
- Utilizar ARB para todas as strings
- Troca dinâmica de idioma
- Seguir idioma do sistema quando configurado

### Testes
- Troca de idioma
- Todos os 8 idiomas
- Strings faltantes

### Exemplo
Usuário muda para espanhol. Toda a interface é traduzida instantaneamente.

---

## F10 – Compartilhamento WhatsApp

### Objetivo
Enviar cartão via WhatsApp.

### Descrição
Geração de link ou vCard para envio via WhatsApp.

### Prioridade
P1 (Desejável para V1)

### Dependências
- WhatsApp instalado

### Fluxo
```
Cartão → Compartilhar → WhatsApp → Selecionar contato → Enviar
```

### Critérios de Aceitação
- Abrir WhatsApp diretamente
- Enviar dados formatados
- Funcionar offline (preparação)

### Testes
- Envio Android
- Envio iOS
- WhatsApp não instalado

### Exemplo
Usuário seleciona compartilhar via WhatsApp. App abre. Seleciona contato. Envia.

---

## F11 – Anúncios AdMob

### Objetivo
Monetizar a versão gratuita com anúncios.

### Descrição
Integração com Google Mobile Ads.

### Prioridade
P1 (Desejável para V1)

### Dependências
- Conta Google AdMob
- google_mobile_ads configurado

### Fluxo
```
App carrega → Anúncio exibido em telas permitidas → Usuário interage (opcional)
```

### Critérios de Aceitação
- Nunca mostrar durante: cadastro, compartilhamento, leitura QR, NFC, biometria, configurações
- Exibir somente em telas permitidas
- Seguir políticas da Google Play e App Store

### Testes
- Anúncio em tela permitida
- Anúncio NÃO exibido em telas restritas
- Remoção de anúncio durante navegação

### Exemplo
Usuário está na tela principal. Anúncio é exibido na parte inferior. Usuário navega para compartilhamento. Anúncio desaparece.

---

## F12 – Atualização da Agenda

### Objetivo
Atualizar contatos existentes na agenda do dispositivo.

### Descrição
Sincronização de dados importados com a agenda nativa.

### Prioridade
P2 (Futuro)

### Dependências
- Permissão de contatos

### Fluxo
```
Contato importado → Detectar duplicata → Confirmar atualização → Atualizar agenda
```

### Critérios de Aceitação
- Detectar duplicatas
- Solicitar confirmação antes de atualizar
- Não sobrescrever sem autorização

### Testes
- Atualização de contato existente
- Novo contato
- Contato com dados parcialmente diferentes

### Exemplo
Usuário importa vCard. App detecta contato existente. Pergunta se deseja atualizar. Confirma. Agenda é atualizada.

---

## Documentos Relacionados

- [04_PRD.md](./04_PRD.md)
- [06_UserStories.md](./06_UserStories.md)
- [07_UseCases.md](./07_UseCases.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
