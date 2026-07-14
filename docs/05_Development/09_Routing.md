# Routing

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack

| Componente | Papel |
|-----------|-------|
| **GoRouter** | Sistema de rotas |
| **Named Routes** | Roteamento por nome |
| **ShellRoute** | Layouts compartilhados |
| **Redirect** | Proteção de rotas |
| **Deep Link Ready** | Preparado para links profundos |

---

## Rotas

| Rota | Tela | Protegida |
|------|------|-----------|
| `/` | Home | Não |
| `/profile` | Perfil | Sim |
| `/profile/edit` | Editar Perfil | Sim |
| `/share` | Compartilhar | Sim |
| `/share/nfc` | NFC | Sim |
| `/share/qr` | QR Code | Sim |
| `/import` | Importar | Sim |
| `/import/qr` | Ler QR | Sim |
| `/import/nfc` | Receber NFC | Sim |
| `/settings` | Configurações | Não |
| `/settings/theme` | Temas | Não |
| `/settings/language` | Idioma | Não |
| `/about` | Sobre | Não |

---

## Implementação

```dart
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isProtected = protectedRoutes.contains(state.matchedLocation);
      final isAuthenticated = authState.isAuthenticated;

      if (isProtected && !isAuthenticated) {
        return '/auth';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      // ...
    ],
  );
});
```

---

## Regras

| # | Regra |
|---|-------|
| 1 | Rotas nomeadas sempre |
| 2 | Proteção por biometria quando necessário |
| 3 | Deep links preparados |
| 4 | Sem Navigator.push direto |
| 5 | Transições padronizadas |

---

## Documentos Relacionados

- [06_Navigation.md](../04_Architecture/06_Navigation.md)
- [09_Navigation.md](../06_UX_UI/09_Navigation.md)
