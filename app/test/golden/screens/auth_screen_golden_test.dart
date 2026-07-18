import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/security/presentation/pages/auth_page.dart';
import 'package:vcardsmart/features/security/presentation/providers/auth_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('AuthPage Golden', () {
    testWidgets('light theme - no auth configured', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                ref.read(authenticateUseCaseProvider),
                ref.read(setPinUseCaseProvider),
                ref.read(verifyPinUseCaseProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const AuthPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AuthPage),
        matchesGoldenFile('golden_files/screens/auth_light.png'),
      );
    });

    testWidgets('dark theme - no auth configured', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                ref.read(authenticateUseCaseProvider),
                ref.read(setPinUseCaseProvider),
                ref.read(verifyPinUseCaseProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const AuthPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(AuthPage),
        matchesGoldenFile('golden_files/screens/auth_dark.png'),
      );
    });
  });
}
