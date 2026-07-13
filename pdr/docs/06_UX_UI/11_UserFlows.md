# User Flows

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fluxo 1: Primeira Utilização

```
SplashScreen
    ↓
OnboardingScreen (5 telas)
    ↓
PermissionsScreen
    ↓
AuthenticationScreen
    ↓
HomeScreen
```

---

## Fluxo 2: Criar Perfil

```
HomeScreen
    ↓
ProfileEditScreen
    ↓
Preencher dados
    ↓
Confirmar
    ↓
Salvar (Hive)
    ↓
ProfileScreen
```

---

## Fluxo 3: Compartilhar via QR Code

```
ProfileScreen
    ↓
ShareScreen
    ↓
Selecionar QR Code
    ↓
QRCodeScreen (Gerar)
    ↓
Outro dispositivo lê
    ↓
Confirmar importação
    ↓
Importar
```

---

## Fluxo 4: Compartilhar via NFC

```
ProfileScreen
    ↓
ShareScreen
    ↓
Selecionar NFC
    ↓
Confirmar envio
    ↓
NFCScreen (Enviar)
    ↓
Aproximar dispositivos
    ↓
Receptor confirma
    ↓
Importar
```

---

## Fluxo 5: Receber Cartão

```
HomeScreen
    ↓
Receber (QR ou NFC)
    ↓
ReceiveScreen
    ↓
Exibir dados
    ↓
Confirmar importação
    ↓
Salvar (ReceivedCard)
    ↓
ReceivedCardsScreen
```

---

## Fluxo 6: Editar Perfil

```
ProfileScreen
    ↓
ProfileEditScreen
    ↓
Modificar dados
    ↓
Confirmar
    ↓
Salvar (Hive)
    ↓
ProfileScreen atualizado
```

---

## Fluxo 7: Configurar Tema

```
SettingsScreen
    ↓
ThemeScreen
    ↓
Selecionar tema
    ↓
Aplicar imediatamente
    ↓
SettingsScreen atualizado
```

---

## Fluxo 8: Configurar Idioma

```
SettingsScreen
    ↓
LanguageScreen
    ↓
Selecionar idioma
    ↓
Aplicar imediatamente
    ↓
Todas as telas atualizadas
```

---

## Fluxo 9: Compartilhar via WhatsApp

```
ProfileScreen
    ↓
ShareScreen
    ↓
Selecionar WhatsApp
    ↓
WhatsApp abre
    ↓
Selecionar contato
    ↓
Enviar
```

---

## Documentos Relacionados

- [11_UserFlows.md](./11_UserFlows.md)
- [09_Navigation.md](./09_Navigation.md)
- [10_Screens.md](./10_Screens.md)
