import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/shared/widgets/app_loading.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AppLoading Golden', () {
    testWidgets('loading spinner only light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppLoading(),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(AppLoading),
        matchesGoldenFile('golden_files/components/loading_light.png'),
      );
    });

    testWidgets('loading with message light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppLoading(
              message: 'Carregando perfil...',
            ),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(AppLoading),
        matchesGoldenFile('golden_files/components/loading_with_message_light.png'),
      );
    });

    testWidgets('loading dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: AppLoading(
              message: 'Carregando...',
            ),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(AppLoading),
        matchesGoldenFile('golden_files/components/loading_dark.png'),
      );
    });
  });

  group('AppLoadingOverlay Golden', () {
    testWidgets('overlay visible light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppLoadingOverlay(
              isLoading: true,
              child: Container(
                color: Colors.white,
                child: const Center(child: Text('Content')),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byType(AppLoadingOverlay),
        matchesGoldenFile('golden_files/components/loading_overlay_light.png'),
      );
    });
  });
}
