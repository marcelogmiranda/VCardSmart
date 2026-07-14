# Use Cases

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Legenda

| Símbolo | Significado |
|---------|-------------|
| [Sistema] | VCardSmart |
| [Usuário] | Pessoa que utiliza o app |
| [Receptor] | Pessoa que recebe o cartão |
| → | Fluxo principal |
| ✅ | Sucesso |
| ❌ | Falha / Exceção |

---

## UC001 – Primeira Execução

**Nome:** Primeira Execução do Aplicativo
**Descrição:** Inicialização do app pela primeira vez após instalação.
**Ator:** Usuário
**Pré-condições:** App recém-instalado. Banco Hive vazio.
**Pós-condições:** Cartão inicial criado (ou app em espera).

### Fluxo Principal
1. [Sistema] Detecta banco vazio
2. [Sistema] Exibe tela de boas-vindas
3. [Usuário] Visualiza introdução
4. [Usuário] Prossegue para cadastro
5. [Sistema] Exibe formulário de cadastro
6. [Usuário] Preenche dados
7. [Usuário] Confirma cadastro
8. [Sistema] Salva no Hive
9. [Sistema] Exibe tela principal

### Exceções
- **3a.** Usuário fecha app → Salva progresso parcial
- **6a.** Campos obrigatórios não preenchidos → Validação em tempo real
- **8a.** Erro ao salvar → Exibe mensagem de erro

---

## UC002 – Editar Perfil

**Nome:** Edição de Perfil
**Descrição:** Usuário modifica dados do cartão existente.
**Ator:** Usuário
**Pré-condições:** Cartão já criado.
**Pós-condições:** Cartão atualizado.

### Fluxo Principal
1. [Usuário] Acessa configurações
2. [Usuário] Seleciona "Editar Perfil"
3. [Sistema] Exibe dados atuais
4. [Usuário] Modifica campos
5. [Usuário] Confirma alterações
6. [Sistema] Salva alterações
7. [Sistema] Confirma sucesso

### Exceções
- **4a.** Campos inválidos → Validação em tempo real
- **6a.** Erro ao salvar → Exibe mensagem

---

## UC003 – Gerar QR Code

**Nome:** Geração de QR Code
**Descrição:** Geração de QR Code estático com dados do cartão.
**Ator:** Usuário
**Pré-condições:** Cartão criado.
**Pós-condições:** QR Code exibido na tela.

### Fluxo Principal
1. [Usuário] Acessa "Compartilhar"
2. [Usuário] Seleciona "QR Code"
3. [Sistema] Gera QR localmente
4. [Sistema] Exibe QR na tela
5. [Usuário] Apresenta tela ao receptor

### Exceções
- **3a.** Dados do cartão incompletos → Avisa sobre campos faltantes

---

## UC004 – Ler QR Code

**Nome:** Leitura de QR Code
**Descrição:** Leitura de QR Code de outro dispositivo.
**Ator:** Receptor
**Pré-condições:** Câmera disponível. QR Code válido.
**Pós-condições:** Cartão importado (após confirmação).

### Fluxo Principal
1. [Receptor] Acessa "Importar"
2. [Receptor] Seleciona "Ler QR Code"
3. [Sistema] Abre câmera
4. [Receptor] Aponta para QR Code
5. [Sistema] Decodifica dados
6. [Sistema] Exibe dados do cartão
7. [Receptor] Confirma importação
8. [Sistema] Salva no Hive

### Exceções
- **3a.** Câmera indisponível → Solicita permissão
- **5a.** QR inválido → Exibe mensagem de erro
- **7a.** Receptor cancela → Nada é salvo

---

## UC005 – Enviar NFC

**Nome:** Envio via NFC
**Descrição:** Transmissão de cartão via aproximação NFC.
**Ator:** Usuário (envia)
**Pré-condições:** Dispositivo com NFC. Cartão criado.
**Pós-condições:** Cartão transmitido (após confirmação).

### Fluxo Principal
1. [Usuário] Acessa "Compartilhar"
2. [Usuário] Seleciona "NFC"
3. [Sistema] Exibe dados do cartão
4. [Usuário] Confirma envio
5. [Sistema] Ativa NFC
6. [Sistema] Detecta dispositivo receptor
7. [Sistema] Transmite dados
8. [Sistema] Exibe progresso
9. [Sistema] Confirma sucesso

### Exceções
- **2a.** NFC indisponível → Informa limitação
- **4a.** Usuário cancela → Nada é transmitido
- **7a.** Transmissão falha → Repete ou cancela

---

## UC006 – Receber NFC

**Nome:** Recepção via NFC
**Descrição:** Recebimento de cartão via NFC.
**Ator:** Receptor
**Pré-condições:** Dispositivo com NFC.
**Pós-condições:** Cartão recebido e salvo (após confirmação).

### Fluxo Principal
1. [Sistema] Detecta transmissão NFC
2. [Sistema] Recebe dados
3. [Sistema] Exibe dados do cartão recebido
4. [Receptor] Confirma importação
5. [Sistema] Salva no Hive

### Exceções
- **3a.** Dados inválidos → Exibe erro
- **4a.** Receptor cancela → Nada é salvo

---

## UC007 – Criar vCard

**Nome:** Criação de vCard
**Descrição:** Geração de arquivo vCard a partir dos dados do cartão.
**Ator:** Sistema
**Pré-condições:** Cartão criado.
**Pós-condições:** vCard válido gerado.

### Fluxo Principal
1. [Sistema] Recebe dados do cartão
2. [Sistema] Valida campos obrigatórios
3. [Sistema] Formata vCard (RFC 6350)
4. [Sistema] Retorna vCard válido

### Exceções
- **2a.** Campos obrigatórios faltantes → Retorna erro

---

## UC008 – Importar vCard

**Nome:** Importação de vCard
**Descrição:** Processamento de vCard recebido.
**Ator:** Receptor
**Pré-condições:** vCard recebido válido.
**Pós-condições:** Dados importados para o Hive.

### Fluxo Principal
1. [Sistema] Recebe vCard
2. [Sistema] Valida formato
3. [Sistema] Exibe dados extraídos
4. [Receptor] Confirma importação
5. [Sistema] Salva no Hive

### Exceções
- **2a.** Formato inválido → Exibe erro
- **4a.** Receptor cancela → Nada é salvo

---

## UC009 – Enviar WhatsApp

**Nome:** Envio via WhatsApp
**Descrição:** Compartilhamento do cartão via WhatsApp.
**Ator:** Usuário
**Pré-condições:** WhatsApp instalado.
**Pós-condições:** Mensagem enviada.

### Fluxo Principal
1. [Usuário] Acessa "Compartilhar"
2. [Usuário] Seleciona "WhatsApp"
3. [Sistema] Prepara dados
4. [Sistema] Abre WhatsApp
5. [Usuário] Seleciona contato
6. [Usuário] Envia

### Exceções
- **4a.** WhatsApp não instalado → Informa

---

## UC010 – Alterar Idioma

**Nome:** Alteração de Idioma
**Descrição:** Troca do idioma da interface.
**Ator:** Usuário
**Pré-condições:** Nenhuma.
**Pós-condições:** Interface traduzida.

### Fluxo Principal
1. [Usuário] Acessa configurações
2. [Usuário] Seleciona idioma
3. [Sistema] Aplica tradução
4. [Sistema] Atualiza interface

### Exceções
- **3a.** Idioma não suportado → Mantém atual

---

## UC011 – Alterar Tema

**Nome:** Alteração de Tema
**Descrição:** Troca do tema visual.
**Ator:** Usuário
**Pré-condições:** Nenhuma.
**Pós-condições:** Interface atualizada.

### Fluxo Principal
1. [Usuário] Acessa configurações
2. [Usuário] Seleciona tema (claro/escuro/sistema)
3. [Sistema] Aplica tema
4. [Sistema] Atualiza interface

### Exceções
- **3a.** Tema do sistema → Detecta preferência do SO

---

## UC012 – Backup (Cancelado nesta versão)

**Nome:** Backup de Dados
**Descrição:** Criação de backup dos dados locais.
**Ator:** Usuário
**Status:** Cancelado para V1
**Motivo:** Manter princípio de zero cloud

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [06_UserStories.md](./06_UserStories.md)
- [08_BusinessRules.md](./08_BusinessRules.md)
