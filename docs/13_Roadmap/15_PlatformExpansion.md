# Expansão de Plataformas — VCardSmart

## Visão Geral

Evolução do VCardSmart para múltiplas plataformas, mantendo a experiência consistente.

## Plataformas

### Atuais

| Plataforma | Status | Versão |
|------------|--------|--------|
| Android | ✅ Lançado | 1.0 |
| iOS | ✅ Lançado | 1.0 |

### Planejadas

| Plataforma | Status | Versão |
|------------|--------|--------|
| Tablet | ⏳ Planejado | 1.1 |
| Foldables | ⏳ Planejado | 1.1 |
| Apple Watch | ⏳ Planejado | 2.2 |
| Wear OS | ⏳ Planejado | 2.2 |
| Web | ⏳ Planejado | 3.0 |
| Desktop | ⏳ Planejado | Futuro |
| CarPlay | ⏳ Planejado | Futuro |
| Android Auto | ⏳ Planejado | Futuro |

## Android

### Dispositivos

| Tipo | Suporte |
|------|---------|
| Smartphone | ✅ |
| Tablet | ⏳ |
| Foldable | ⏳ |
| TV | ❌ |
| Auto | ⏳ |

### Especificações

| Campo | Valor |
|-------|-------|
| Mínimo | API 21 (Android 5.0) |
| Alvo | API 34 (Android 14) |
| Arquitetura | arm64-v8a, armeabi-v7a |

## iOS

### Dispositivos

| Tipo | Suporte |
|------|---------|
| iPhone | ✅ |
| iPad | ⏳ |
| Apple Watch | ⏳ |
| Apple TV | ❌ |
| CarPlay | ⏳ |

### Especificações

| Campo | Valor |
|-------|-------|
| Mínimo | iOS 12.0 |
| Alvo | iOS 17.0 |

## Tablet

### Adaptações

| Elemento | Adaptação |
|----------|-----------|
| Layout | Master-detail |
| Grid | Mais colunas |
| Tipografia | Maior |
| Espaçamento | Maior |

### Implementação

```dart
// Layout responsivo
class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return TabletLayout();
        } else if (constraints.maxWidth > 600) {
          return SmallTabletLayout();
        } else {
          return PhoneLayout();
        }
      },
    );
  }
}
```

## Foldables

### Adaptações

| Estado | Layout |
|--------|--------|
| Fechado | Phone |
| Semi-aberto | Dual pane |
| Aberto | Tablet |

### Implementação

```dart
// Foldable support
class FoldableLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FoldableDetector(
      onFoldChanged: (isFolded) {
        // Adaptar layout
      },
      builder: (context, isFolded) {
        if (isFolded) {
          return PhoneLayout();
        } else {
          return DualPaneLayout();
        }
      },
    );
  }
}
```

## Apple Watch

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Compartilhar | Compartilhar perfil |
| QR Code | Exibir QR Code |
| NFC | Compartilhar via NFC |
| Contatos | Ver contatos importados |

### Implementação

```swift
// WatchKit
class ProfileInterfaceController: WKInterfaceController {
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var shareButton: WKInterfaceButton!
    
    @IBAction func share() {
        // Compartilhar via NFC/QR
    }
}
```

## Wear OS

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Compartilhar | Compartilhar perfil |
| QR Code | Exibir QR Code |
| NFC | Compartilhar via NFC |
| Contatos | Ver contatos importados |

### Implementação

```kotlin
// Wear OS
class ProfileActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ProfileScreen(
                onShare = { shareProfile() }
            )
        }
    }
}
```

## Web

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Perfil | Visualizar perfil |
| QR Code | Exibir QR Code |
| Download | Baixar vCard |
| Compartilhar | Compartilhar link |

### Implementação

```dart
// Flutter Web
class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}
```

## Desktop

### Plataformas

| Plataforma | Status |
|------------|--------|
| Windows | ⏳ Futuro |
| macOS | ⏳ Futuro |
| Linux | ⏳ Futuro |

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Perfil | Gerenciar perfil |
| QR Code | Exibir/gerar QR Code |
| NFC | Compartilhar (se suportado) |
| Contatos | Gerenciar contatos |

## CarPlay

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Perfil | Visualizar perfil |
| Compartilhar | Compartilhar via NFC |

## Android Auto

### Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| Perfil | Visualizar perfil |
| Compartilhar | Compartilhar via NFC |

## Roadmap

### v1.1 — Tablets e Foldables

- [ ] Layout responsivo
- [ ] Dual pane
- [ ] Testes em dispositivos

### v2.2 — Wearables

- [ ] Apple Watch
- [ ] Wear OS
- [ ] Compartilhamento

### v3.0 — Web

- [ ] Flutter Web
- [ ] Perfil público
- [ ] Download vCard

### Futuro — Desktop e Auto

- [ ] Windows
- [ ] macOS
- [ ] Linux
- [ ] CarPlay
- [ ] Android Auto

## Métricas

### KPIs

| Métrica | Meta |
|---------|------|
| Plataformas suportadas | > 5 |
| Consistência | > 95% |
| Performance | > 30fps |
| Satisfação | > 4.0 |
