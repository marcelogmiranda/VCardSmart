import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/import_page.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('ImportPage Golden', () {
    testWidgets('light theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contactListProvider.overrideWith(
              (ref) => ContactListNotifier(
                ref.read(getContactsUseCaseProvider),
                ref.read(importContactUseCaseProvider),
                ref.read(contactRepositoryProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ImportPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ImportPage),
        matchesGoldenFile('golden_files/screens/import_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contactListProvider.overrideWith(
              (ref) => ContactListNotifier(
                ref.read(getContactsUseCaseProvider),
                ref.read(importContactUseCaseProvider),
                ref.read(contactRepositoryProvider),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const ImportPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ImportPage),
        matchesGoldenFile('golden_files/screens/import_dark.png'),
      );
    });
  });
}
