# Layouts

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Layout Base

```
┌─────────────────────┐
│      AppBar         │  ← Título + ações
├─────────────────────┤
│                     │
│       Body          │  ← Conteúdo principal
│                     │
│                     │
├─────────────────────┤
│ NavigationBar       │  ← Navegação inferior
└─────────────────────┘
```

---

## Estrutura de uma Tela

```dart
class SomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
        actions: [...],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Spacing.lg),
          child: Column(
            children: [...],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(),
      floatingActionButton: FloatingActionButton(),
    );
  }
}
```

---

## Layouts por Tipo

### Tela com Lista
```dart
Scaffold(
  appBar: AppBar(title: Text('Cartões')),
  body: ListView.separated(
    padding: EdgeInsets.all(Spacing.lg),
    itemCount: items.length,
    itemBuilder: (context, index) => Card(),
    separatorBuilder: (_, __) => SizedBox(height: Spacing.sm),
  ),
);
```

### Tela com Formulário
```dart
Scaffold(
  appBar: AppBar(title: Text('Editar Perfil')),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(Spacing.lg),
    child: Column(
      children: [
        AppTextField(label: 'Nome'),
        SizedBox(height: Spacing.md),
        AppTextField(label: 'E-mail'),
        SizedBox(height: Spacing.md),
        PrimaryButton(label: 'Salvar'),
      ],
    ),
  ),
);
```

### Tela com Detalhes
```dart
Scaffold(
  appBar: AppBar(title: Text('Detalhes')),
  body: Column(
    children: [
      // Header com foto
      // Informações
      // Ações
    ],
  ),
);
```

---

## SafeArea

```dart
SafeArea(
  child: SingleChildScrollView(
    padding: EdgeInsets.all(Spacing.lg),
    child: Column(...),
  ),
)
```

---

## ScrollView

```dart
SingleChildScrollView(
  padding: EdgeInsets.all(Spacing.lg),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [...],
  ),
)
```

---

## Documentos Relacionados

- [01_UXVision.md](./01_UXVision.md)
- [06_Spacing.md](./06_Spacing.md)
- [17_ResponsiveDesign.md](./17_ResponsiveDesign.md)
