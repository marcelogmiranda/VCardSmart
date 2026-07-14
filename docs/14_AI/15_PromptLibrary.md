# Biblioteca de Prompts — VCardSmart

## Flutter

### Criar Widget

```
Crie um widget [tipo] chamado [nome].

Funcionalidades:
- [funcionalidade 1]
- [funcionalidade 2]

Parâmetros:
- [parâmetro 1]: [tipo]
- [parâmetro 2]: [tipo]

Estilo:
- Material Design 3
- Tema do app
```

### Criar Page

```
Crie uma page chamada [nome].

Funcionalidades:
- [funcionalidade 1]
- [funcionalidade 2]

Navegação:
- Chega de [rota]
- Navega para [rota]

Estado:
- Provider: [provider]
- Estado: [estado]
```

### Criar Provider

```
Crie um provider chamado [nome].

Tipo:
- StateNotifierProvider
- Provider
- FutureProvider

Estado:
- Tipo: [tipo]
- Inicial: [valor]

Métodos:
- [método 1]: [descrição]
- [método 2]: [descrição]
```

## Hive

### Criar Model

```
Crie um model Hive chamado [nome].

Campos:
- [campo 1]: [tipo]
- [campo 2]: [tipo]

Métodos:
- fromJson/toJson
- toDomain/fromDomain

Box:
- Nome: [nome]
- Chave: [chave]
```

### Criar Datasource

```
Crie um datasource Hive chamado [nome].

Métodos:
- get([id]): [tipo]
- getAll(): [tipo]
- save([item]): void
- delete([id]): void

Box:
- Nome: [nome]
```

## Riverpod

### Criar StateNotifier

```
Crie um StateNotifier chamado [nome].

Estado:
- Tipo: [tipo]
- Inicial: [valor]

Métodos:
- [método 1]: [descrição]
- [método 2]: [descrição]

Dependências:
- [dependência 1]
- [dependência 2]
```

### Criar Provider

```
Crie um provider chamado [nome].

Tipo: [tipo]

Dependências:
- [dependência 1]
- [dependência 2]

Lógica:
- [lógica]
```

## GoRouter

### Criar Rota

```
Crie uma rota [tipo] chamada [nome].

Caminho: [caminho]

Parâmetros:
- [parâmetro 1]: [tipo]

Página: [página]

Guards:
- [guard 1]
```

### Criar ShellRoute

```
Crie um ShellRoute chamado [nome].

Rotas filhas:
- [rota 1]
- [rota 2]

Shell: [shell]
```

## NFC

### Criar NFC Service

```
Crie um serviço NFC chamado [nome].

Métodos:
- isAvailable(): Future<bool>
- send([data]): Future<void>
- receive(): Future<[tipo]>

Dados:
- Formato: [formato]
- Tamanho máximo: [tamanho]
```

## QR Code

### Criar QR Service

```
Crie um serviço QR Code chamado [nome].

Métodos:
- generate([data]): [tipo]
- scan(): Future<[tipo]>

Dados:
- Formato: [formato]
- Tamanho: [tamanho]
```

## vCard

### Criar vCard Service

```
Crie um serviço vCard chamado [nome].

Métodos:
- toVCard([profile]): String
- fromVCard([string]): Profile

Formato:
- vCard 3.0
- UTF-8
```

## Segurança

### Criar Encryption Service

```
Crie um serviço de criptografia chamado [nome].

Métodos:
- encrypt([data]): [tipo]
- decrypt([data]): [tipo]

Algoritmo:
- AES-256
- Chave: [local]
```

### Criar Auth Service

```
Crie um serviço de autenticação chamado [nome].

Métodos:
- authenticate(): Future<bool>
- isAuthenticated(): Future<bool>

Métodos:
- Biometria
- PIN
```

## Testes

### Criar Unit Test

```
Crie unit tests para [componente].

Casos de teste:
- [caso 1]: [descrição]
- [caso 2]: [descrição]

Cobertura: > 80%
```

### Criar Widget Test

```
Crie widget tests para [widget].

Casos de teste:
- [caso 1]: [descrição]
- [caso 2]: [descrição]

Cobertura: > 70%
```

### Criar Integration Test

```
Crie integration tests para [fluxo].

Fluxo:
1. [passo 1]
2. [passo 2]
3. [passo 3]

Cobertura: > 60%
```

## Documentação

### Criar CHANGELOG

```
Atualize o CHANGELOG:

## [Versão] - YYYY-MM-DD

### Adicionado
- [item 1]

### Alterado
- [item 1]

### Corrigido
- [item 1]
```

### Criar ADR

```
Crie um ADR:

## ADR-[número] - [título]

### Contexto
[contexto]

### Decisão
[decisão]

### Consequências
[positivas e negativas]

### Status
Aceito
```
