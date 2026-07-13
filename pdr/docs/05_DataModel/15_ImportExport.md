# Import Export

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Operações

| Operação | Métodos |
|----------|---------|
| **Importar** | QR Code, NFC, vCard |
| **Exportar** | QR Code, NFC, vCard |

---

## Importação

### Via QR Code
```
Ler QR Code
    ↓
Decodificar payload
    ↓
Validar dados
    ↓
Exibir ao usuário
    ↓
Confirmar importação
    ↓
Salvar como ReceivedCard
```

### Via NFC
```
Receber transmissão NFC
    ↓
Decodificar payload
    ↓
Validar dados
    ↓
Exibir ao usuário
    ↓
Confirmar importação
    ↓
Salvar como ReceivedCard
```

### Via vCard
```
Receber vCard
    ↓
Parsear campos
    ↓
Validar dados
    ↓
Exibir ao usuário
    ↓
Confirmar importação
    ↓
Salvar como ReceivedCard
```

---

## Exportação

### Via QR Code
```
Obter perfil
    ↓
Filtrar campos (ShareOptions)
    ↓
Gerar vCard
    ↓
Gerar JSON
    ↓
Gerar QR Code
    ↓
Exibir na tela
```

### Via NFC
```
Obter perfil
    ↓
Filtrar campos (ShareOptions)
    ↓
Gerar vCard
    ↓
Gerar JSON
    ↓
Confirmar envio
    ↓
Transmitir NFC
```

### Via vCard
```
Obter perfil
    ↓
Filtrar campos (ShareOptions)
    ↓
Gerar vCard
    ↓
Compartilhar (WhatsApp, etc.)
```

---

## Validação na Importação

| Validação | Ação |
|-----------|------|
| Formato inválido | Rejeitar |
| Campos faltantes | Aceitar parcialmente |
| Dados corrompidos | Rejeitar |
| Versão incompatível | Aceitar com aviso |

---

## Confirmação

### Regra
> Toda importação exige confirmação explícita do usuário.

### Fluxo
```
Dados recebidos
    ↓
Exibir dados ao usuário
    ↓
Usuário confirma
    ↓
Salvar
```

---

## Documentos Relacionados

- [15_ImportExport.md](./15_ImportExport.md)
- [09_NFCArchitecture.md](../04_Architecture/09_NFCArchitecture.md)
- [10_QRCodeArchitecture.md](../04_Architecture/10_QRCodeArchitecture.md)
