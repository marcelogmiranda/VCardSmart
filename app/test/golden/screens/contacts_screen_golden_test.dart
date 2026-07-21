import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/features/contacts/presentation/pages/contacts_page.dart';
import 'package:vcardsmart/features/contacts/presentation/providers/contact_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_contacts_golden_hive__');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(_TestContactAdapter());
    }
    await Hive.openBox<Contact>(HiveBoxes.contacts);
    await Hive.openBox(HiveBoxes.settings);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

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
