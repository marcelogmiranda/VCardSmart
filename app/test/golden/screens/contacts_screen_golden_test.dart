import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/contacts_page.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('ContactsPage Golden', () {
    testWidgets('empty state light theme', (tester) async {
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
            home: const ContactsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactsPage),
        matchesGoldenFile('golden_files/screens/contacts_empty_light.png'),
      );
    });

    testWidgets('empty state dark theme', (tester) async {
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
            home: const ContactsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactsPage),
        matchesGoldenFile('golden_files/screens/contacts_empty_dark.png'),
      );
    });
  });
}
