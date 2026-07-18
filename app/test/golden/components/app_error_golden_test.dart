import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_error.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppError Golden', () {
    testWidgets('error with retry light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppError(
              message: 'Não foi possível carregar os dados.',
              onRetry: null,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppError),
        matchesGoldenFile('golden_files/components/error_light.png'),
      );
    });

    testWidgets('error dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: AppError(
              message: 'Não foi possível carregar os dados.',
              onRetry: null,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppError),
        matchesGoldenFile('golden_files/components/error_dark.png'),
      );
    });

    testWidgets('error with retry button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppError(
              message: 'Erro de conexão',
              onRetry: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppError),
        matchesGoldenFile('golden_files/components/error_with_retry_light.png'),
      );
    });
  });

  group('AppEmpty Golden', () {
    testWidgets('empty state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppEmpty(
              message: 'Nenhum contato encontrado',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppEmpty),
        matchesGoldenFile('golden_files/components/empty_light.png'),
      );
    });

    testWidgets('empty state dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: AppEmpty(
              message: 'Nenhum contato encontrado',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppEmpty),
        matchesGoldenFile('golden_files/components/empty_dark.png'),
      );
    });

    testWidgets('empty with action button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppEmpty(
              message: 'Crie seu primeiro perfil',
              onAction: () {},
              actionLabel: 'Criar Perfil',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppEmpty),
        matchesGoldenFile('golden_files/components/empty_with_action_light.png'),
      );
    });
  });
}
