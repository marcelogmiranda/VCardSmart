import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/contact_card.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('ContactCard Golden', () {
    testWidgets('QR source light theme', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'Ana Costa',
        email: 'ana@email.com',
        phone: '+5511888888888',
        source: 'qr',
        importedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ContactCard(
              contact: contact,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactCard),
        matchesGoldenFile('golden_files/components/contact_card_qr_light.png'),
      );
    });

    testWidgets('NFC source light theme', (tester) async {
      final contact = Contact(
        id: '2',
        name: 'Carlos Lima',
        phone: '+5511777777777',
        source: 'nfc',
        importedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ContactCard(
              contact: contact,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactCard),
        matchesGoldenFile('golden_files/components/contact_card_nfc_light.png'),
      );
    });

    testWidgets('vCard source light theme', (tester) async {
      final contact = Contact(
        id: '3',
        name: 'Pedro Santos',
        email: 'pedro@email.com',
        source: 'vcard',
        importedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ContactCard(
              contact: contact,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactCard),
        matchesGoldenFile('golden_files/components/contact_card_vcard_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'Ana Costa',
        email: 'ana@email.com',
        source: 'qr',
        importedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ContactCard(
              contact: contact,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ContactCard),
        matchesGoldenFile('golden_files/components/contact_card_dark.png'),
      );
    });
  });
}
