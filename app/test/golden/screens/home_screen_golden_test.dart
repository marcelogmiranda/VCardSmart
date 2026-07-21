import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/features/home/presentation/pages/home_page.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_home_golden_hive__');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(_TestContactAdapter());
    }
    await Hive.openBox<Contact>(HiveBoxes.contacts);
    await Hive.openBox(HiveBoxes.settings);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('HomePage Golden', () {
    testWidgets('light theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const HomePage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('golden_files/screens/home_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const HomePage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('golden_files/screens/home_dark.png'),
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
