# Data Lifecycle

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Ciclo de Vida dos Dados

```
Criar → Validar → Salvar → Compartilhar → Editar → Atualizar → Excluir
```

---

## Estágios

### 1. Criar
| Ação | Descrição |
|------|-----------|
| Inicializar | Usuário preenche dados |
| Gerar UUID | Criar identificador único |
| Definir timestamps | createdAt e updatedAt |
| Definir schemaVersion | Versão do schema |

### 2. Validar
| Ação | Descrição |
|------|-----------|
| Validar campos | Obrigatórios e formatos |
| Validar regras | Únicos, limites |
| Retornar erros | Mensagens amigáveis |

### 3. Salvar
| Ação | Descrição |
|------|-----------|
| Serializar | Model → JSON |
| Salvar Hive | box.put() |
| Confirmar | Sucesso ou erro |

### 4. Compartilhar
| Ação | Descrição |
|------|-----------|
| Filtrar | Campos autorizados |
| Gerar payload | JSON + vCard |
| Transmitir | NFC ou QR Code |
| Confirmar | Recebedor autoriza |

### 5. Editar
| Ação | Descrição |
|------|-----------|
| Carregar dados | Hive.get() |
| Modificar | Campos alterados |
| Atualizar timestamp | updatedAt |
| Salvar | box.put() |

### 6. Atualizar
| Ação | Descrição |
|------|-----------|
| Receber dados | NFC, QR, vCard |
| Validar | Formato e dados |
| Confirmar | Usuário autoriza |
| Salvar | box.put() |

### 7. Excluir
| Ação | Descrição |
|------|-----------|
| Confirmar | Usuário autoriza |
| Remover Hive | box.delete() |
| Limpar cache | Arquivos temporários |

---

## Fluxo de Compartilhamento

```
UserProfile
    ↓
Filter (ShareOptions)
    ↓
VCardGenerator
    ↓
JSON Generator
    ↓
NFC / QR Code
    ↓
Receiver
    ↓
Validate
    ↓
Save (ReceivedCard)
```

---

## Documentos Relacionados

- [11_DataLifecycle.md](./11_DataLifecycle.md)
- [12_Migrations.md](./12_Migrations.md)
- [15_ImportExport.md](./15_ImportExport.md)
