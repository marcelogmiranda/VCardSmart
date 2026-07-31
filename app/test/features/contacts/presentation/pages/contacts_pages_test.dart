import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/contacts_page.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/import_page.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/import_dialog.dart';
import 'package:vcardsmart/features/contacts/presentation/widgets/contact_card.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';

Contact _testContact({String name = 'Test Contact', String source = 'qr'}) => Contact(
      id: '1',
      name: name,
      source: source,
      importedAt: DateTime(2024),
    );

Widget wrap(Widget child, {List<Override>? overrides}) => ProviderScope(
  overrides: overrides ?? [],
  child: MaterialApp(home: Scaffold(body: child)),
);

Widget wrapWithRouter(Widget dialog) => ProviderScope(
      child: MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Scaffold(
                body: Builder(
                  builder: (context) => Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          showDialog(context: context, builder: (_) => dialog),
                      child: const Text('Open Dialog'),
                    ),
                  ),
                ),
              ),
            ),
            GoRoute(
              path: '/qr/scan',
              builder: (context, state) =>
                  const Scaffold(body: Text('QR Scan Page')),
            ),
            GoRoute(
              path: '/nfc/receive',
              builder: (context, state) =>
                  const Scaffold(body: Text('NFC Receive Page')),
            ),
          ],
        ),
      ),
    );

void main() {
  setUpAll(() async {
    Hive.init('__test_contacts_page_hive__');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(_TestContactAdapter());
    }
    await Hive.openBox<Contact>(HiveBoxes.contacts);
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk(HiveBoxes.contacts);
    await Hive.deleteFromDisk();
  });

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

    testWidgets('should navigate to QR scan on Via QR Code', (tester) async {
      final dialog = ImportDialog(onImport: (data, source) {});
      await tester.pumpWidget(wrapWithRouter(dialog));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Via QR Code'));
      await tester.pumpAndSettle();
      expect(find.text('QR Scan Page'), findsOneWidget);
    });

    testWidgets('should navigate to NFC receive on Via NFC', (tester) async {
      final dialog = ImportDialog(onImport: (data, source) {});
      await tester.pumpWidget(wrapWithRouter(dialog));
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Via NFC'));
      await tester.pumpAndSettle();
      expect(find.text('NFC Receive Page'), findsOneWidget);
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

class _TestContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      linkedin: fields[4] as String?,
      website: fields[5] as String?,
      bio: fields[6] as String?,
      source: fields[7] as String,
      importedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.linkedin)
      ..writeByte(5)
      ..write(obj.website)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.source)
      ..writeByte(8)
      ..write(obj.importedAt);
  }
}
