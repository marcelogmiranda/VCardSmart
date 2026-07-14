import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_share_page.dart';
import 'package:vcardsmart/features/qr_code/presentation/pages/qr_scan_page.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  group('QRSharePage', () {
    final profile = Profile(
      id: '1',
      name: 'Test User',
      email: 'test@email.com',
      phone: '1234567890',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );

    testWidgets('should display profile name', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: QRSharePage(profile: profile)),
        ),
      );
      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('should display profile email', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: QRSharePage(profile: profile)),
        ),
      );
      expect(find.text('test@email.com'), findsOneWidget);
    });

    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: QRSharePage(profile: profile)),
        ),
      );
      expect(find.text('Compartilhar QR Code'), findsOneWidget);
    });

    testWidgets('should display profile without optional fields', (tester) async {
      final simpleProfile = Profile(
        id: '2',
        name: 'Simple User',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: QRSharePage(profile: simpleProfile)),
        ),
      );
      expect(find.text('Simple User'), findsOneWidget);
    });
  });

  group('QRScanPage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      expect(find.text('Escanear QR Code'), findsOneWidget);
    });

    testWidgets('should display center title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: QRScanPage()),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
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
