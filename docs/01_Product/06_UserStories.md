# User Stories

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Modelo

```
Como [persona]
Quero [funcionalidade]
Para [benefício]
```

Cada User Story possui:
- Identificador único
- Persona
- Funcionalidade desejada
- Benefício esperado
- Prioridade
- Critérios de aceitação
- Feature vinculada

---

## Cadastro e Perfil

### US001 – Cadastro Inicial
**Como** usuário,
**Quero** preencher meu cartão na primeira vez,
**Para** poder compartilhar meu contato profissional.

**Prioridade:** P0
**Feature:** F01

**Critérios de Aceitação:**
- Exibir tela de boas-vindas
- Permitir preenchimento manual
- Salvar somente após confirmação
- Armazenar no Hive

---

### US002 – Editar Perfil
**Como** usuário,
**Quero** editar meus dados a qualquer momento,
**Para** manter meu cartão atualizado.

**Prioridade:** P0
**Feature:** F01

**Critérios de Aceitação:**
- Permitir edição de todos os campos
- Salvar alterações imediatamente
- Manter histórico de versões (futuro)

---

### US003 – Adicionar Foto
**Como** usuário,
**Quero** adicionar minha foto ao cartão,
**Para** tornar meu contato mais pessoal.

**Prioridade:** P1
**Feature:** F01

**Critérios de Aceitação:**
- Permitir selecionar da galeria
- Permitir tirar foto
- Redimensionar automaticamente
- Comprimir para economia de espaço

---

### US004 – Adicionar Logotipo
**Como** usuário,
**Quero** adicionar o logotipo da minha empresa,
**Para** identificar minha marca profissional.

**Prioridade:** P1
**Feature:** F01

**Critérios de Aceitação:**
- Permitir selecionar da galeria
- Redimensionar automaticamente
- Exibir no cartão

---

## Compartilhamento

### US005 – Compartilhar via NFC
**Como** usuário,
**Quero** compartilhar meu cartão aproximando meu celular do outro,
**Para** trocar contatos rapidamente.

**Prioridade:** P0
**Feature:** F02

**Critérios de Aceitação:**
- Funcionar offline
- Solicitar confirmação antes do envio
- Tempo inferior a 5 segundos

---

### US006 – Receber via NFC
**Como** usuário,
**Quero** receber cartões via NFC,
**Para** importar contatos sem digitar.

**Prioridade:** P0
**Feature:** F02

**Critérios de Aceitação:**
- Receber dados
- Exibir antes de salvar
- Solicitar confirmação

---

### US007 – Gerar QR Code
**Como** usuário,
**Quero** gerar um QR Code do meu cartão,
**Para** compartilhar quando NFC não estiver disponível.

**Prioridade:** P0
**Feature:** F03

**Critérios de Aceitação:**
- Gerar localmente
- QR contendo vCard completa
- Exibir na tela

---

### US008 – Ler QR Code
**Como** usuário,
**Quero** ler QR Codes de outros dispositivos,
**Para** importar contatos digitais.

**Prioridade:** P0
**Feature:** F04

**Critérios de Aceitação:**
- Utilizar câmera
- Decodificar em menos de 3 segundos
- Exibir dados antes de importar

---

### US009 – Compartilhar via WhatsApp
**Como** usuário,
**Quero** enviar meu cartão pelo WhatsApp,
**Para** compartilhar com quem não está presente.

**Prioridade:** P1
**Feature:** F10

**Critérios de Aceitação:**
- Abrir WhatsApp
- Enviar dados formatados

---

## Segurança

### US010 – Proteger com Biometria
**Como** usuário,
**Quero** proteger meu app com biometria,
**Para** impedir acesso não autorizado.

**Prioridade:** P0
**Feature:** F07

**Critérios de Aceitação:**
- Detectar Face ID
- Detectar impressão digital
- Fallback para PIN

---

### US011 – Proteger com PIN
**Como** usuário,
**Quero** usar PIN quando biometria não está disponível,
**Para** manter meu app protegido.

**Prioridade:** P0
**Feature:** F07

**Critérios de Aceitação:**
- Permitir criação de PIN
- Validar PIN corretamente
- Bloquear após tentativas falhas

---

## Personalização

### US012 – Alterar Tema
**Como** usuário,
**Quero** alternar entre tema claro e escuro,
**Para** usar o app de forma confortável.

**Prioridade:** P1
**Feature:** F08

**Critérios de Aceitação:**
- Tema claro
- Tema escuro
- Tema do sistema
- Alteração imediata

---

### US013 – Alterar Idioma
**Como** usuário,
**Quero** usar o app em meu idioma,
**Para** compreender todas as funcionalidades.

**Prioridade:** P1
**Feature:** F09

**Critérios de Aceitação:**
- 8 idiomas disponíveis
- Troca dinâmica
- Seguir idioma do sistema

---

## Importação

### US014 – Importar Cartão
**Como** usuário,
**Quero** importar cartões recebidos,
**Para** construir minha rede de contatos.

**Prioridade:** P0
**Feature:** F06

**Critérios de Aceitação:**
- Validar dados recebidos
- Exibir antes de salvar
- Confirmar importação

---

### US015 – Atualizar Contato na Agenda
**Como** usuário,
**Quero** atualizar contatos existentes na agenda,
**Para** manter meus dados sempre atualizados.

**Prioridade:** P2
**Feature:** F12

**Critérios de Aceitação:**
- Detectar duplicatas
- Solicitar confirmação
- Não sobrescrever sem autorização

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [07_UseCases.md](./07_UseCases.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
