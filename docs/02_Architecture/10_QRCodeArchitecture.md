# QR Code Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Plugin

| Propriedade | Valor |
|-------------|-------|
| **Geração** | qr_flutter |
| **Leitura** | mobile_scanner |
| **Conteúdo** | JSON + vCard |
| **Offline** | ✅ 100% |

---

## Fluxo QR Code

### Geração
```
Obter dados do cartão
    ↓
Serializar para JSON + vCard
    ↓
Gerar QR Code localmente
    ↓
Exibir na tela
```

### Leitura
```
Ativar câmera
    ↓
Detectar QR Code
    ↓
Decodificar payload
    ↓
Validar dados
    ↓
Exibir ao usuário
    ↓
Confirmar importação
    ↓
Salvar no Hive
```

---

## Payload

### Formato JSON
```json
{
  "type": "vcardsmart",
  "version": "1.0",
  "vcard": "BEGIN:VCARD\nVERSION:3.0\nFN:João Silva\nTEL:+5511999999999\nEMAIL:joao@exemplo.com\nEND:VCARD",
  "metadata": {
    "timestamp": "2026-07-13T00:00:00Z"
  }
}
```

---

## Regras QR Code

| # | Regra | Descrição |
|---|-------|-----------|
| 1 | Offline | Geração 100% local |
| 2 | Sem servidor | Nunca utiliza backend |
| 3 | Sem URLs | QR não contém links externos |
| 4 | Validação | Dados validados antes de importar |
| 5 | Confirmação | Importação exige confirmação |
| 6 | Compatibilidade | Funciona entre Android e iOS |

---

## Tratamento de Erros

| Erro | Ação |
|------|------|
| Câmera indisponível | Informar limitação |
| QR inválido | Informar erro |
| Dados corrompidos | Rejeitar |
| QR danificado | Tentar novamente |

---

## Compatibilidade

| Plataforma | Geração | Leitura |
|------------|---------|---------|
| Android | ✅ | ✅ |
| iOS | ✅ | ✅ |

---

## Permissões

| Plataforma | Permissão | Obrigatória |
|------------|-----------|-------------|
| Android | CAMERA | Sim (para leitura) |
| iOS | Camera | Sim (para leitura) |

---

## Documentos Relacionados

- [10_QRCodeArchitecture.md](./10_QRCodeArchitecture.md)
- [11_VCardArchitecture.md](./11_VCardArchitecture.md)
- [09_NFCArchitecture.md](./09_NFCArchitecture.md)
