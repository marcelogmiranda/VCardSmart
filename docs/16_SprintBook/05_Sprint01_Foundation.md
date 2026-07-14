# Sprint 1 — Foundation

## Objetivo

Criar a estrutura base do projeto.

## Pré-requisitos

- Sprint 0 concluída
- Ambiente configurado

## Documentos Obrigatórios

- README.md
- Architecture.md
- DirectoryStructure.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── errors/
│   │   └── app_exception.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart
│   └── utils/
│       └── app_utils.dart
├── features/
│   └── home/
│       ├── presentation/
│       │   ├── pages/
│       │   │   └── home_page.dart
│       │   └── widgets/
│       │       └── home_widget.dart
│       └── providers/
│           └── home_provider.dart
├── l10n/
│   └── app_en.arb
├── app.dart
└── main.dart
```

### Arquivos Alterados

- pubspec.yaml

## Modelos

### app_constants.dart

```dart
class AppConstants {
  static const String appName = 'VCardSmart';
  static const String appVersion = '1.0.0';
  
  // Hive Boxes
  static const String profileBox = 'profiles';
  static const String contactBox = 'contacts';
  static const String settingsBox = 'settings';
  static const String historyBox = 'history';
  
  // Routes
  static const String homeRoute = '/';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
}
```

### app_exception.dart

```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  AppException(this.message, [this.code]);
}

class ProfileNotFoundException extends AppException {
  ProfileNotFoundException(String id)
      : super('Profile not found: $id', 'PROFILE_NOT_FOUND');
}

class DatabaseException extends AppException {
  DatabaseException(String message)
      : super(message, 'DATABASE_ERROR');
}
```

### app_theme.dart

```dart
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      brightness: Brightness.light,
    );
  }
  
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      brightness: Brightness.dark,
    );
  }
}
```

### app_router.dart

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
```

### main.dart

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  // ...
  
  runApp(const ProviderScope(child: VCardSmartApp()));
}
```

### app.dart

```dart
class VCardSmartApp extends ConsumerWidget {
  const VCardSmartApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
```

## Critérios de Aceitação

- [x] Estrutura de pastas criada
- [x] Constants definidas
- [x] Exceptions definidas
- [x] Theme configurado
- [x] Router configurado
- [x] main.dart funcional
- [x] app.dart funcional
- [x] HomePage exibida
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (100%)
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Estrutura criada
- [x] Constants definidas
- [x] Exceptions definidas
- [x] Theme configurado
- [x] Router configurado
- [x] main.dart funcional
- [x] app.dart funcional
- [x] HomePage exibida
- [x] Build funcionando
- [x] Testes passando (22/22)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (100%)
- [x] CHANGELOG atualizado

## Prompt

```
Leia:
- README.md
- Architecture.md
- DirectoryStructure.md

Implemente somente esta Sprint.
Não avance para a próxima.
Não altere arquitetura.
Execute todos os testes.
Atualize documentação.
Pare ao terminar.
```

## Auditoria

```
Faça uma auditoria ao final.

Liste:
- Arquivos criados
- Arquivos alterados
- Cobertura
- Lints
- Pendências
- Riscos
- Melhorias
- Próxima Sprint
```

## Próxima Sprint

Sprint 2 — Design System
