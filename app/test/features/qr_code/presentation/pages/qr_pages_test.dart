import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_share_page.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_scan_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_qr_hive__');
    Hive.registerAdapter(_TestProfileAdapter());
    await Hive.openBox<Profile>(HiveBoxes.profiles);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('QRSharePage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRSharePage()),
        ),
      );
      expect(find.text('Meu QR Code'), findsOneWidget);
    });
  });

  group('QRScanPage', () {
    testWidgets('should display initial screen with button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      expect(find.text('Escanear QR Code'), findsNWidgets(2));
      expect(find.text('Abrir Câmera'), findsOneWidget);
    });

    testWidgets('should have scaffold structure', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}

class _TestProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      linkedin: fields[4] as String?,
      website: fields[5] as String?,
      bio: fields[6] as String?,
      photoPath: fields[7] as String?,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      instagram: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.photoPath)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.instagram);
  }
}
