# NFC Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Plugin

| Propriedade | Valor |
|-------------|-------|
| **Plugin** | nfc_manager |
| **Plataformas** | Android, iOS |
| **Payload** | JSON + vCard |

---

## Fluxo NFC

### Envio
```
Validar dados do cartão
    ↓
Confirmar envio com usuário
    ↓
Ativar sessão NFC
    ↓
Aguardar detecção de receptor
    ↓
Transmitir payload (JSON + vCard)
    ↓
Confirmar transmissão bem-sucedida
```

### Recebimento
```
Detectar transmissão NFC
    ↓
Receber payload
    ↓
Validar dados recebidos
    ↓
Exibir dados ao receptor
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
    "timestamp": "2026-07-13T00:00:00Z",
    "deviceId": "uuid_do_dispositivo"
  }
}
```

---

## Regras NFC

| # | Regra | Descrição |
|---|-------|-----------|
| 1 | Offline | NFC funciona 100% offline |
| 2 | Confirmação | Todo envio exige confirmação |
| 3 | Validação | Dados são validados antes do envio |
| 4 | Cancelamento | Usuário pode cancelar a qualquer momento |
| 5 | Progresso | Exibir progresso durante transmissão |
| 6 | Timeout | Timeout de 30 segundos |
| 7 | Erro | Tratar erros graciosamente |

---

## Tratamento de Erros

| Erro | Ação |
|------|------|
| NFC indisponível | Informar e sugerir QR Code |
| Transmissão falhou | Oferecer retry |
| Timeout | Cancelar e informar |
| Dados inválidos | Rejeitar e informar |
| Receptor cancelou | Cancelar graciosamente |

---

## Compatibilidade

| Plataforma | NFC | Status |
|------------|-----|--------|
| Android 6+ | ✅ | Suportado |
| iOS 13+ | ✅ | Suportado (iPhone 7+) |
| Dispositivo sem NFC | ❌ | Funcionalidade degrada |

---

## Permissões

| Plataforma | Permissão | Obrigatória |
|------------|-----------|-------------|
| Android | NFC | Sim |
| iOS | Core NFC | Sim |

---

## Documentos Relacionados

- [09_NFCArchitecture.md](./09_NFCArchitecture.md)
- [11_VCardArchitecture.md](./11_VCardArchitecture.md)
- [12_ContactsArchitecture.md](./12_ContactsArchitecture.md)
