# Accessibility

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Princípios de Acessibilidade

| Princípio | Descrição |
|-----------|-----------|
| **Fonte Dinâmica** | Suportar tamanho de fonte definido pelo usuário |
| **Leitor de Tela** | Todos os componentes interativos devem ter labels |
| **Contraste** | WCAG 2.1 AA (4.5:1 para texto normal) |
| **Dark Mode** | Tema escuro para reduzir fadiga visual |
| **Touch Mínimo** | Alvos de toque ≥ 48x48 dp |
| **Sem Dependência de Cores** | Informações não transmitidas apenas por cor |

---

## Requisitos de Acessibilidade

### Fonte Dinâmica

| Requisito | Descrição |
|-----------|-----------|
| Tamanho de fonte responsivo | Usar unidades relativas (sp) |
| Suporte a fonte do sistema | Respeitar configuração do usuário |
| Não truncar texto | Texto deve ser legível em qualquer tamanho |

### Leitor de Tela

| Componente | Label Obrigatório |
|------------|-------------------|
| Botões | Descrição da ação |
| Campos de texto | Descrição do campo |
| Ícones | Descrição do ícone |
| Cards | Conteúdo resumido |
| Navegação | Destino da navegação |

### Contraste

| Elemento | Contraste Mínimo |
|----------|-----------------|
| Texto normal (< 18pt) | 4.5:1 |
| Texto grande (≥ 18pt) | 3:1 |
| Componentes interativos | 3:1 |
| Ícones | 3:1 |

### Touch

| Requisito | Valor |
|-----------|-------|
| Tamanho mínimo do alvo | 48x48 dp |
| Espaçamento entre alvos | ≥ 8 dp |
| Gestos alternativos | Sem dependência exclusiva de gestos complexos |

---

## Implementação no Flutter

### Texto Responsivo
```dart
Text(
  'Texto acessível',
  style: TextStyle(
    fontSize: MediaQuery.of(context).textScaleFactor * 16,
  ),
)
```

### Labels para Leitor de Tela
```dart
Semantics(
  label: 'Botão de compartilhar cartão',
  child: IconButton(
    icon: Icon(Icons.share),
    onPressed: () {},
  ),
)
```

### Contraste
```dart
// Tema claro
ColorScheme(
  primary: Color(0xFF1565C0), // Azul escuro
  onPrimary: Colors.white,     // Branco
  surface: Colors.white,
  onSurface: Color(0xFF212121), // Texto escuro
)

// Tema escuro
ColorScheme(
  primary: Color(0xFF90CAF9), // Azul claro
  onPrimary: Colors.black,     // Preto
  surface: Color(0xFF121212),
  onSurface: Color(0xFFE0E0E0), // Texto claro
)
```

### Touch Targets
```dart
// Botão com tamanho mínimo garantido
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(
    icon: Icon(Icons.share),
    onPressed: () {},
  ),
)
```

---

## Testes de Acessibilidade

| Teste | Descrição |
|-------|-----------|
| Leitor de tela | Navegar por todas as telas com TalkBack/VoiceOver |
| Contraste | Verificar contraste de todos os textos |
| Tamanho de fonte | Testar com fonte maior e menor |
| Touch | Verificar tamanho dos alvos de toque |
| Navegação | Navegar apenas com teclado |
| Cores | Verificar se informações não dependem apenas de cor |

---

## Ferramentas

| Ferramenta | Uso |
|-----------|-----|
| TalkBack (Android) | Teste de leitor de tela |
| VoiceOver (iOS) | Teste de leitor de tela |
| Accessibility Scanner (Android) | Verificação de touch e contraste |
| Xcode Accessibility Inspector (iOS) | Verificação de acessibilidade |

---

## Documentos Relacionados

- [10_NonFunctionalRequirements.md](./10_NonFunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
- [15_Internationalization.md](./15_Internationalization.md)
