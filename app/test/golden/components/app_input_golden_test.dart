import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_input.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppInput Golden', () {
    testWidgets('default light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppInput(
                label: 'Nome',
                hint: 'Digite seu nome',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppInput),
        matchesGoldenFile('golden_files/components/input_light.png'),
      );
    });

    testWidgets('default dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppInput(
                label: 'Nome',
                hint: 'Digite seu nome',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppInput),
        matchesGoldenFile('golden_files/components/input_dark.png'),
      );
    });

    testWidgets('with error state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppInput(
                label: 'Email',
                error: 'Email inválido',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppInput),
        matchesGoldenFile('golden_files/components/input_error_light.png'),
      );
    });

    testWidgets('disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppInput(
                label: 'Campo desabilitado',
                enabled: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppInput),
        matchesGoldenFile('golden_files/components/input_disabled_light.png'),
      );
    });
  });
}
