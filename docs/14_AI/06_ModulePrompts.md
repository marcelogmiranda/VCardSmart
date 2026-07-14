# Prompts por Módulo — VCardSmart

## Profile

### Criar Profile

```
Implemente o módulo Profile completo.

Entity:
- id: String
- name: String (obrigatório)
- email: String?
- phone: String?
- linkedin: String?
- website: String?
- bio: String?
- createdAt: DateTime
- updatedAt: DateTime

Model:
- fromJson/toJson
- toDomain/fromDomain

Repository:
- getProfile(id)
- getAllProfiles()
- saveProfile(profile)
- deleteProfile(id)

UseCase:
- GetProfileUseCase
- CreateProfileUseCase
- UpdateProfileUseCase
- DeleteProfileUseCase

Provider:
- profileProvider
- profileListProvider

Page:
- ProfilePage
- ProfileEditPage

Widget:
- ProfileCard
- ProfileForm

Test:
- Unit tests para domain e data
- Widget tests para presentation
```

### Editar Profile

```
Implemente edição de Profile.

Funcionalidades:
- Editar nome (obrigatório)
- Editar email
- Editar telefone
- Editar LinkedIn
- Editar website
- Editar bio
- Salvar alterações

Validações:
- Nome não pode ser vazio
- Email deve ser válido (se preenchido)
- Telefone deve ser válido (se preenchido)

UI:
- Formulário com validação
- Botão salvar
- Botão cancelar
- Loading state
- Error state
```

## QR Code

### Gerar QR Code

```
Implemente geração de QR Code.

Funcionalidades:
- Gerar QR Code a partir do perfil
- Personalizar tamanho
- Salvar como imagem
- Compartilhar

Dados do QR Code:
- vCard format
- URL de perfil (futuro)
- JSON com dados

UI:
- Tela com QR Code
- Botão salvar
- Botão compartilhar
- Loading state
```

### Escanear QR Code

```
Implemente escaneamento de QR Code.

Funcionalidades:
- Abrir câmera
- Escanear QR Code
- Validar dados
- Importar contato

Validações:
- QR Code deve conter vCard
- Dados devem ser válidos
- Não duplicar contatos

UI:
- Tela com câmera
- Overlay de escaneamento
- Loading state
- Success/error state
```

## NFC

### Enviar via NFC

```
Implemente envio via NFC.

Funcionalidades:
- Verificar compatibilidade
- Enviar perfil via NFC
- Confirmar envio
- Histórico de envios

Dados enviados:
- vCard format
- Dados compactados

UI:
- Tela de preparação
- Instruções de uso
- Loading state
- Success/error state
```

### Receber via NFC

```
Implemente recebimento via NFC.

Funcionalidades:
- Verificar compatibilidade
- Receber dados via NFC
- Validar dados
- Importar contato

Validações:
- Dados devem ser vCard
- Dados devem ser válidos
- Não duplicar contatos

UI:
- Tela de preparação
- Instruções de uso
- Loading state
- Success/error state
```

## Import

### Importar Contato

```
Implemente importação de contato.

Funcionalidades:
- Importar via QR Code
- Importar via NFC
- Importar via vCard
- Validar dados
- Evitar duplicatas

Dados importados:
- Nome
- Email
- Telefone
- LinkedIn
- Website
- Bio

UI:
- Tela de confirmação
- Preview dos dados
- Botão importar
- Loading state
- Success/error state
```

### Histórico de Importações

```
Implemente histórico de importações.

Funcionalidades:
- Listar importações
- Buscar importações
- Excluir importações
- Re-importar

Dados:
- Data da importação
- Nome do contato
- Fonte (QR/NFC/vCard)

UI:
- Lista de importações
- Busca
- Ações (excluir, re-importar)
```

## Theme

### Tema Claro/Escuro

```
Implemente tema claro e escuro.

Funcionalidades:
- Detectar tema do sistema
- Alternar manualmente
- Salvar preferência

Cores:
- Primary: #1976D2
- Background light: #FFFFFF
- Background dark: #121212
- Surface light: #F5F5F5
- Surface dark: #1E1E1E

UI:
- Toggle tema
- Transição suave
```

## Localization

### Suporte a Idiomas

```
Implemente suporte a 8 idiomas.

Idiomas:
- pt-BR (nativo)
- en
- es
- fr
- it
- de
- ja
- zh

Funcionalidades:
- Detectar idioma do sistema
- Alternar manualmente
- Salvar preferência

Textos:
- Todos os textos da UI
- Mensagens de erro
- Validações
```
