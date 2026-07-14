# States

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Estados de Interface

| Estado | Descrição | Componente |
|--------|-----------|------------|
| **Loading** | Carregando dados | LoadingIndicator |
| **Success** | Dados carregados | Conteúdo |
| **Empty** | Lista vazia | EmptyState |
| **Offline** | Sem internet | EmptyState (específico) |
| **PermissionDenied** | Permissão negada | EmptyState + CTA |
| **Error** | Erro ao carregar | ErrorState |
| **Locked** | App bloqueado | AuthenticationScreen |
| **Importing** | Importando cartão | LoadingIndicator |
| **Exporting** | Exportando cartão | LoadingIndicator |

---

## Loading

```dart
if (state.isLoading) {
  return LoadingIndicator(message: 'Carregando...');
}
```

| Elemento | Comportamento |
|----------|--------------|
| Indicador | CircularProgressIndicator |
| Mensagem | "Carregando..." (opcional) |
| Fundo | Transparente ou sobreposto |

---

## Success

```dart
if (state.hasData) {
  return ProfileWidget(profile: state.data);
}
```

---

## Empty

```dart
if (state.isEmpty) {
  return EmptyState(
    icon: Icons.inbox,
    title: 'Nenhum cartão',
    message: 'Compartilhe seu cartão para começar',
    actionLabel: 'Criar Perfil',
    onAction: () => context.push('/profile/edit'),
  );
}
```

---

## Error

```dart
if (state.hasError) {
  return ErrorState(
    title: 'Erro',
    message: 'Não foi possível carregar',
    actionLabel: 'Tentar novamente',
    onAction: () => ref.refresh(provider),
  );
}
```

---

## PermissionDenied

```dart
EmptyState(
  icon: Icons.lock,
  title: 'Permissão necessária',
  message: 'Conceda a permissão nas configurações',
  actionLabel: 'Abrir Configurações',
  onAction: () => openAppSettings(),
)
```

---

## Locked

```dart
// App bloqueado por biometria/PIN
AuthenticationScreen(
  onAuthenticated: () => unlock(),
)
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Sempre mostrar estado de carregamento |
| 2 | Sempre mostrar estado de erro |
| 3 | Sempre mostrar estado vazio |
| 4 | Sempre oferecer retry quando possível |
| 5 | Mensagens amigáveis em todos os estados |

---

## Documentos Relacionados

- [07_Components.md](./07_Components.md)
- [16_ErrorHandling.md](../04_Architecture/16_ErrorHandling.md)
