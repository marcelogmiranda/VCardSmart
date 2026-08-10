import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/features/home/presentation/pages/home_page.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';

void main() {
  setUpAll(() async {
    Hive.init('__test_home_hive__');
    await Hive.openBox(HiveBoxes.contacts);
    await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox(HiveBoxes.profiles);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  Future<void> pumpHomePage(WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('HomePage', () {
    testWidgets('should display app title in AppBar', (tester) async {
      await pumpHomePage(tester);

      expect(find.text('VCardSmart'), findsOneWidget);
    });

    testWidgets('should display profile card', (tester) async {
      await pumpHomePage(tester);

      expect(find.text('Meu Cartão'), findsOneWidget);
    });

    testWidgets('should display quick actions grid', (tester) async {
      await pumpHomePage(tester);

      expect(find.text('Ações Rápidas'), findsOneWidget);
      expect(find.text('Meu QR Code'), findsOneWidget);
      expect(find.text('Escanear'), findsOneWidget);
      expect(find.text('Importar'), findsOneWidget);
    });
  });
}
