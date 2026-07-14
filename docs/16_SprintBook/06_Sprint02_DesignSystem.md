# Sprint 2 — Design System

## Objetivo

Implementar o design system com Material Design 3.

## Pré-requisitos

- Sprint 1 concluída
- Estrutura base criada

## Documentos Obrigatórios

- Architecture.md
- Theme.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart
│       ├── app_shadows.dart
│       └── app_borders.dart
├── shared/
│   └── widgets/
│       ├── app_button.dart
│       ├── app_card.dart
│       ├── app_input.dart
│       ├── app_icon.dart
│       ├── app_avatar.dart
│       ├── app_divider.dart
│       ├── app_loading.dart
│       └── app_error.dart
```

### Arquivos Alterados

- lib/core/theme/app_theme.dart

## Modelos

### app_colors.dart

```dart
class AppColors {
  // Primary
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  
  // Background
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  
  // Surface
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  // Text
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}
```

### app_text_styles.dart

```dart
class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
}
```

### app_spacing.dart

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

### app_theme.dart

```dart
class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
      ),
      spacing: AppSpacing.md,
    );
  }
  
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
      ),
      spacing: AppSpacing.md,
    );
  }
}
```

### Widget Exemplo

```dart
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

## Critérios de Aceitação

- [x] Cores definidas
- [x] Tipografia definida
- [x] Espaçamentos definidos
- [x] Tema claro configurado
- [x] Tema escuro configurado
- [x] Componentes base criados
- [x] Componentes funcionando
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Cores definidas
- [x] Tipografia definida
- [x] Espaçamentos definidos
- [x] Tema claro configurado
- [x] Tema escuro configurado
- [x] Componentes base criados
- [x] Componentes funcionando
- [x] Build funcionando
- [x] Testes passando (40/40)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (100%)
- [x] CHANGELOG atualizado (v1.2.0)

## Próxima Sprint

Sprint 3 — Local Database
