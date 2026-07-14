import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/contact_card.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/import_dialog.dart';

void main() {
  group('ContactCard', () {
    testWidgets('should display contact name', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'Test Contact',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.text('Test Contact'), findsOneWidget);
    });

    testWidgets('should display first letter of name', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'Alice',
        source: 'nfc',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('should show email when available', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'With Email',
        email: 'test@test.com',
        source: 'vcard',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.text('test@test.com'), findsOneWidget);
    });

    testWidgets('should show QR icon for qr source', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'QR User',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.byIcon(Icons.qr_code), findsOneWidget);
    });

    testWidgets('should show NFC icon for nfc source', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'NFC User',
        source: 'nfc',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.byIcon(Icons.nfc), findsOneWidget);
    });

    testWidgets('should show vCard icon for vcard source', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'VCard User',
        source: 'vcard',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contact),
          ),
        ),
      );

      expect(find.byIcon(Icons.description), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool tapped = false;
      final contact = Contact(
        id: '1',
        name: 'Tap Me',
        source: 'qr',
        importedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(
              contact: contact,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ContactCard));
      expect(tapped, true);
    });
  });

  group('ImportDialog', () {
    testWidgets('should show import options', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ImportDialog(onImport: (_, __) {}),
          ),
        ),
      );

      expect(find.text('Importar Contato'), findsOneWidget);
      expect(find.text('Via QR Code'), findsOneWidget);
      expect(find.text('Via NFC'), findsOneWidget);
      expect(find.text('Via vCard'), findsOneWidget);
    });
  });
}
