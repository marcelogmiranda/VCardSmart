import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_button.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppButton Golden', () {
    testWidgets('primary light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Salvar',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/primary_button_light.png'),
      );
    });

    testWidgets('primary dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Salvar',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/primary_button_dark.png'),
      );
    });

    testWidgets('secondary light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Cancelar',
                type: ButtonType.secondary,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/secondary_button_light.png'),
      );
    });

    testWidgets('outline light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Outline',
                type: ButtonType.outline,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/outline_button_light.png'),
      );
    });

    testWidgets('text button light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Text',
                type: ButtonType.text,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/text_button_light.png'),
      );
    });

    testWidgets('primary with icon light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: AppButton(
                label: 'Adicionar',
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile(
            'golden_files/components/primary_button_with_icon_light.png',),
      );
    });

    testWidgets('loading state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: AppButton(
                label: 'Salvar',
                isLoading: true,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden_files/components/primary_button_loading_light.png'),
      );
    });
  });
}
