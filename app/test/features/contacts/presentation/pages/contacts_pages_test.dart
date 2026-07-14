import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/contacts_page.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/import_page.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/import_dialog.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/contact_card.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

Contact _testContact({String name = 'Test Contact', String source = 'qr'}) => Contact(
      id: '1',
      name: name,
      source: source,
      importedAt: DateTime(2024),
    );

Widget wrap(Widget child) => ProviderScope(
  child: MaterialApp(home: Scaffold(body: child)),
);

void main() {
  group('ContactListStatus', () {
    test('should have default values', () {
      const status = ContactListStatus();
      expect(status.status, ContactStatus.idle);
      expect(status.contacts, isEmpty);
      expect(status.error, isNull);
    });

    test('copyWith should create new state', () {
      const status = ContactListStatus();
      final updated = status.copyWith(
        status: ContactStatus.success,
        contacts: [_testContact()],
      );
      expect(updated.status, ContactStatus.success);
      expect(updated.contacts.length, 1);
    });

    test('copyWith should clear error', () {
      const status = ContactListStatus(error: 'old');
      final updated = status.copyWith();
      expect(updated.error, isNull);
    });
  });

  group('ContactsPage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(wrap(const ContactsPage()));
      await tester.pumpAndSettle();
      expect(find.text('Contatos'), findsOneWidget);
    });

    testWidgets('should show empty state', (tester) async {
      await tester.pumpWidget(wrap(const ContactsPage()));
      await tester.pumpAndSettle();
      expect(find.text('Nenhum contato importado'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should show import icon in appBar', (tester) async {
      await tester.pumpWidget(wrap(const ContactsPage()));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('should open import dialog on tap', (tester) async {
      await tester.pumpWidget(wrap(const ContactsPage()));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();
      expect(find.text('Importar Contato'), findsOneWidget);
      expect(find.text('Via QR Code'), findsOneWidget);
      expect(find.text('Via NFC'), findsOneWidget);
      expect(find.text('Via vCard'), findsOneWidget);
    });
  });

  group('ImportPage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(wrap(const ImportPage()));
      expect(find.text('Importar Contato'), findsOneWidget);
    });

    testWidgets('should display import options', (tester) async {
      await tester.pumpWidget(wrap(const ImportPage()));
      expect(find.text('Importar via QR Code'), findsOneWidget);
      expect(find.text('Importar via NFC'), findsOneWidget);
      expect(find.text('Importar via vCard'), findsOneWidget);
    });

    testWidgets('should display icons', (tester) async {
      await tester.pumpWidget(wrap(const ImportPage()));
      expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
      expect(find.byIcon(Icons.nfc), findsOneWidget);
      expect(find.byIcon(Icons.description), findsOneWidget);
    });
  });

  group('ImportDialog', () {
    testWidgets('should display dialog title', (tester) async {
      final dialog = ImportDialog(onImport: (data, source) {});
      await tester.pumpWidget(wrap(dialog));
      expect(find.text('Importar Contato'), findsOneWidget);
    });

    testWidgets('should call onImport with qr source', (tester) async {
      String? capturedSource;
      final dialog = ImportDialog(
        onImport: (data, source) {
          capturedSource = source;
        },
      );
      await tester.pumpWidget(wrap(dialog));
      await tester.tap(find.text('Via QR Code'));
      await tester.pumpAndSettle();
      expect(capturedSource, 'qr');
    });

    testWidgets('should call onImport with nfc source', (tester) async {
      String? capturedSource;
      final dialog = ImportDialog(
        onImport: (data, source) {
          capturedSource = source;
        },
      );
      await tester.pumpWidget(wrap(dialog));
      await tester.tap(find.text('Via NFC'));
      await tester.pumpAndSettle();
      expect(capturedSource, 'nfc');
    });

    testWidgets('should open vCard import dialog', (tester) async {
      final dialog = ImportDialog(onImport: (data, source) {});
      await tester.pumpWidget(wrap(dialog));
      await tester.tap(find.text('Via vCard'));
      await tester.pumpAndSettle();
      expect(find.text('Colar vCard'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should cancel vCard import', (tester) async {
      final dialog = ImportDialog(onImport: (data, source) {});
      await tester.pumpWidget(wrap(dialog));
      await tester.tap(find.text('Via vCard'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.text('Colar vCard'), findsNothing);
    });
  });

  group('ContactCard', () {
    testWidgets('should display contact name', (tester) async {
      final card = ContactCard(
        contact: _testContact(name: 'John Doe'),
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      var tapped = false;
      final card = ContactCard(
        contact: _testContact(),
        onTap: () {
          tapped = true;
        },
      );
      await tester.pumpWidget(wrap(card));
      await tester.tap(find.byType(ContactCard));
      expect(tapped, isTrue);
    });

    testWidgets('should display QR source icon', (tester) async {
      final card = ContactCard(
        contact: _testContact(source: 'qr'),
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.byIcon(Icons.qr_code), findsOneWidget);
    });

    testWidgets('should display NFC source icon', (tester) async {
      final card = ContactCard(
        contact: _testContact(source: 'nfc'),
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.byIcon(Icons.nfc), findsOneWidget);
    });

    testWidgets('should display vCard source icon', (tester) async {
      final card = ContactCard(
        contact: _testContact(source: 'vcard'),
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.byIcon(Icons.description), findsOneWidget);
    });

    testWidgets('should display person icon for unknown source', (tester) async {
      final card = ContactCard(
        contact: _testContact(source: 'unknown'),
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should display email as subtitle', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'John',
        email: 'john@test.com',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      final card = ContactCard(
        contact: contact,
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.text('john@test.com'), findsOneWidget);
    });

    testWidgets('should display phone when no email', (tester) async {
      final contact = Contact(
        id: '1',
        name: 'John',
        phone: '123456',
        source: 'qr',
        importedAt: DateTime(2024),
      );
      final card = ContactCard(
        contact: contact,
        onTap: () {},
      );
      await tester.pumpWidget(wrap(card));
      expect(find.text('123456'), findsOneWidget);
    });
  });
}
