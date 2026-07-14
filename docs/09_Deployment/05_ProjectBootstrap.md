# Bootstrap do Projeto — VCardSmart

## Fluxo de Inicialização

```
1. Criar Projeto Flutter
    ↓
2. Aplicar Estrutura do Workspace
    ↓
3. Configurar l10n
    ↓
4. Configurar Riverpod
    ↓
5. Configurar GoRouter
    ↓
6. Configurar Hive
    ↓
7. Executar Testes Iniciais
```

## 1. Criar Projeto Flutter

```bash
# Criar projeto
flutter create vcardsmart --org com.vcardsmart

# Entrar no diretório
cd vcardsmart

# Verificar versão
flutter --version
```

## 2. Aplicar Estrutura do Workspace

```bash
# Criar estrutura de pastas
mkdir -p lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── theme/
  │   ├── utils/
  │   └── extensions/
  ├── domain/
  │   ├── entities/
  │   ├── value_objects/
  │   ├── validators/
  │   └── repositories/
  ├── data/
  │   ├── datasources/
  │   ├── models/
  │   ├── repositories/
  │   └── services/
  ├── presentation/
  │   ├── app.dart
  │   ├── router/
  │   ├── screens/
  │   ├── components/
  │   └── providers/
  └── l10n/
      ├── app_en.arb
      ├── app_pt.arb
      └── ...
```

## 3. Configurar l10n

```yaml
# pubspec.yaml
flutter_intl:
  enabled: true
  class_name: AppLocalizations
  output_dir: lib/generated
  main_locale: pt
  supported_locales:
    - pt
    - en
    - es
    - fr
    - it
    - de
    - ja
    - zh
```

```bash
# Gerar localização
flutter gen-l10n
```

## 4. Configurar Riverpod

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VCardSmartApp(),
    ),
  );
}
```

## 5. Configurar GoRouter

```dart
// lib/presentation/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // Adicionar rotas aqui
  ],
);
```

## 6. Configurar Hive

```dart
// lib/data/services/hive_service.dart
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Registrar adaptes
    // Hive.registerAdapter(ProfileAdapter());
    
    // Abrir boxes
    // await Hive.openBox('profiles');
  }
}
```

## 7. Executar Testes Iniciais

```bash
# Formatar código
dart format .

# Analisar código
flutter analyze

# Rodar testes
flutter test

# Verificar cobertura
flutter test --coverage
```

## Script de Bootstrap

### Windows (PowerShell)

```powershell
# bootstrap.ps1
Write-Host "🚀 Iniciando bootstrap do VCardSmart..."

# Verificar Flutter
flutter --version

# Criar projeto
flutter create vcardsmart --org com.vcardsmart
cd vcardsmart

# Instalar dependências
flutter pub get

# Gerar código
dart run build_runner build --delete-conflicting-outputs

# Gerar localização
flutter gen-l10n

# Formatar
dart format .

# Analisar
flutter analyze

# Testar
flutter test

Write-Host "✅ Bootstrap concluído!"
```

### macOS/Linux (Bash)

```bash
#!/bin/bash
# bootstrap.sh
echo "🚀 Iniciando bootstrap do VCardSmart..."

# Verificar Flutter
flutter --version

# Criar projeto
flutter create vcardsmart --org com.vcardsmart
cd vcardsmart

# Instalar dependências
flutter pub get

# Gerar código
dart run build_runner build --delete-conflicting-outputs

# Gerar localização
flutter gen-l10n

# Formatar
dart format .

# Analisar
flutter analyze

# Testar
flutter test

echo "✅ Bootstrap concluído!"
```

## Verificação Pós-Bootstrap

```bash
# Verificar estrutura
tree lib/

# Verificar dependências
flutter pub deps

# Verificar dispositivos
flutter devices

# Rodar app
flutter run
```

## Checklist de Bootstrap

- [ ] Projeto criado
- [ ] Estrutura de pastas aplicada
- [ ] Dependências instaladas
- [ ] l10n configurado
- [ ] Riverpod configurado
- [ ] GoRouter configurado
- [ ] Hive configurado
- [ ] Código gerado
- [ ] Formatação executada
- [ ] Análise passando
- [ ] Testes passando
- [ ] App rodando
