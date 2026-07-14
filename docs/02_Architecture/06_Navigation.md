# Navigation

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Stack de Navegação

| Componente | Papel |
|-----------|-------|
| **GoRouter** | Sistema de roteamento declarativo |
| **Rotas Nomeadas** | Navegação por nome de rota |
| **Deep Links** | Preparado para links profundos |
| **Proteção Biometria** | Rotas protegidas por autenticação |

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
| `/contacts` | Contatos | Sim |
| `/settings` | Configurações | Não |
| `/settings/theme` | Temas | Não |
| `/settings/language` | Idioma | Não |
| `/about` | Sobre | Não |

---

## Implementação

### App Router
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
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/share',
        builder: (context, state) => const SharePage(),
      ),
      GoRoute(
        path: '/share/nfc',
        builder: (context, state) => const NfcSharePage(),
      ),
      GoRoute(
        path: '/share/qr',
        builder: (context, state) => const QrSharePage(),
      ),
      GoRoute(
        path: '/import',
        builder: (context, state) => const ImportPage(),
      ),
      GoRoute(
        path: '/import/qr',
        builder: (context, state) => const QrImportPage(),
      ),
      GoRoute(
        path: '/import/nfc',
        builder: (context, state) => const NfcImportPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/settings/theme',
        builder: (context, state) => const ThemePage(),
      ),
      GoRoute(
        path: '/settings/language',
        builder: (context, state) => const LanguagePage(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutPage(),
      ),
    ],
  );
});
```

---

## Rotas Protegidas

| Rota | Proteção |
|------|----------|
| `/profile` | Biometria/PIN |
| `/profile/edit` | Biometria/PIN |
| `/share` | Biometria/PIN |
| `/share/nfc` | Biometria/PIN |
| `/share/qr` | Biometria/PIN |
| `/import` | Biometria/PIN |
| `/import/qr` | Biometria/PIN |
| `/import/nfc` | Biometria/PIN |
| `/contacts` | Biometria/PIN |

---

## Deep Links

| Deep Link | Rota | Descrição |
|-----------|------|-----------|
| `vcardsmart://profile` | `/profile` | Abrir perfil |
| `vcardsmart://share` | `/share` | Compartilhar |
| `vcardsmart://import` | `/import` | Importar |

---

## Navegação entre Features

```dart
// ✅ CORRETO - Usando GoRouter
context.go('/profile');

// ✅ CORRETO - Push
context.push('/profile/edit');

// ❌ INCORRETO - Navigator direto
Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
```

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [05_StateManagement.md](./05_StateManagement.md)
- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
