# Wireframes

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fluxo de Wireframes

```
Splash
    ↓
Onboarding
    ↓
Permissões
    ↓
Home
    ├── Meu Cartão
    │     ├── Editar Perfil
    │     ├── Telefones
    │     ├── Redes
    │     └── Compartilhar
    │
    ├── Cartões Recebidos
    │     └── Detalhes
    │
    └── Configurações
          ├── Idioma
          ├── Tema
          ├── Segurança
          ├── Sobre
          └── Licenças
```

---

## SplashScreen

```
┌─────────────────────┐
│                     │
│                     │
│    [Logo VCard]     │
│                     │
│   VCardSmart        │
│                     │
│      ⏳             │
│                     │
└─────────────────────┘
```

---

## HomeScreen

```
┌─────────────────────┐
│  VCardSmart    [👤] │
├─────────────────────┤
│ ┌─────────────────┐ │
│ │ [Foto] Nome     │ │
│ │ Cargo - Empresa │ │
│ │ 📧 email        │ │
│ │ 🌐 site         │ │
│ │ 📱 📸 💼        │ │
│ └─────────────────┘ │
│                     │
│ [📤 Compartilhar]   │
│ [✏️ Editar]         │
│                     │
│ Cartões Recebidos   │
│ ┌─────────────────┐ │
│ │ [Cartão 1]      │ │
│ │ [Cartão 2]      │ │
│ │ [Cartão 3]      │ │
│ └─────────────────┘ │
│                     │
├─────────────────────┤
│  🏠    📋    ⚙️    │
│ Home  Cartões Config│
└─────────────────────┘
```

---

## ShareScreen

```
┌─────────────────────┐
│  ← Compartilhar     │
├─────────────────────┤
│                     │
│  Como deseja        │
│  compartilhar?      │
│                     │
│ ┌─────────────────┐ │
│ │ 📷 QR Code      │ │
│ └─────────────────┘ │
│ ┌─────────────────┐ │
│ │ 📱 NFC          │ │
│ └─────────────────┘ │
│ ┌─────────────────┐ │
│ │ 💬 WhatsApp     │ │
│ └─────────────────┘ │
│ ┌─────────────────┐ │
│ │ 📋 vCard        │ │
│ └─────────────────┘ │
│                     │
└─────────────────────┘
```

---

## QRCodeScreen

```
┌─────────────────────┐
│  ← QR Code          │
├─────────────────────┤
│                     │
│    ┌───────────┐    │
│    │           │    │
│    │  QR Code  │    │
│    │           │    │
│    └───────────┘    │
│                     │
│  Aponte a câmera    │
│  do outro           │
│  dispositivo        │
│                     │
└─────────────────────┘
```

---

## SettingsScreen

```
┌─────────────────────┐
│  ← Configurações    │
├─────────────────────┤
│                     │
│  🌐 Idioma          │
│  🎨 Tema            │
│  🔒 Segurança       │
│                     │
│  ─────────────────  │
│                     │
│  💡 Sugestões       │
│  ℹ️ Sobre           │
│  📄 Licenças        │
│                     │
└─────────────────────┘
```

---

## Documentos Relacionados

- [20_Wireframes.md](./20_Wireframes.md)
- [10_Screens.md](./10_Screens.md)
- [21_Prototype.md](./21_Prototype.md)
