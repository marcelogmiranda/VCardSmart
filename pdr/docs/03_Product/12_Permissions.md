# Permissions

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Princípio

Permissões são solicitadas somente quando necessárias. O app funciona com funcionalidade degradada quando permissões são negadas.

---

## Android

| Permissão | Uso | Obrigatória | Fallback |
|-----------|-----|-------------|----------|
| NFC | Compartilhamento via NFC | Não (funcionalidade degrada) | Usar QR Code |
| Câmera | Leitura de QR Code | Não (funcionalidade degrada) | Usar NFC |
| Contatos | Atualizar agenda do dispositivo | Não (funcionalidade degrada) | Não atualiza agenda |
| Biometria | Proteção do app | Não (funcionalidade degrada) | Usar PIN |
| Notificações | Alertas de compartilhamento | Não (funcionalidade degrada) | Sem notificações |

### Fluxo de Permissão Android

1. App solicita permissão apenas quando o usuário inicia a ação correspondente
2. Se negada, informa limitação e oferece alternativa
3. Nunca solicita permissão na inicialização

---

## iOS

| Permissão | Uso | Obrigatória | Fallback |
|-----------|-----|-------------|----------|
| Contacts | Atualizar agenda do dispositivo | Não (funcionalidade degrada) | Não atualiza agenda |
| Camera | Leitura de QR Code | Não (funcionalidade degrada) | Usar NFC |
| NFC | Compartilhamento via NFC | Não (funcionalidade degrada) | Usar QR Code |
| FaceID | Proteção do app | Não (funcionalidade degrada) | Usar Touch ID ou PIN |

### Fluxo de Permissão iOS

1. App solicita permissão apenas quando o usuário inicia a ação correspondente
2. Se negada, informa limitação e oferece alternativa
3. Nunca solicita permissão na inicialização

---

## Mapeamento de Permissões por Feature

| Feature | Android | iOS |
|---------|---------|-----|
| F01 – Cadastro | Contatos (opcional) | Contacts (opcional) |
| F02 – NFC | NFC | NFC |
| F03 – QR Code | Câmera | Camera |
| F04 – Leitura QR | Câmera | Camera |
| F07 – Biometria | Biometria | FaceID / TouchID |
| F12 – Agenda | Contatos | Contacts |

---

## Tratamento de Permissão Negada

| Permissão | Comportamento |
|-----------|---------------|
| NFC | Informa que NFC indisponível. Oferece QR Code como alternativa. |
| Câmera | Informa que câmera indisponível. Oferece NFC como alternativa. |
| Contatos | Informa que não pode atualizar agenda. Dados são salvos apenas no app. |
| Biometria | Informa que biometria indisponível. Oferece PIN como alternativa. |
| Notificações | App funciona sem notificações. |

---

## Declaração de Permissões

As permissões devem ser declaradas nos arquivos de manifesto:

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.NFC" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

### iOS (Info.plist)
```xml
<key>NSContactsUsageDescription</key>
<string>VCardSmart precisa acessar seus contatos para atualizar sua agenda.</string>
<key>NSCameraUsageDescription</key>
<string>VCardSmart precisa da câmera para ler QR Codes.</string>
<key>NSSiriUsageDescription</key>
<string>VCardSmart não utiliza Siri.</string>
```

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [08_BusinessRules.md](./08_BusinessRules.md)
- [13_Privacy.md](./13_Privacy.md)
