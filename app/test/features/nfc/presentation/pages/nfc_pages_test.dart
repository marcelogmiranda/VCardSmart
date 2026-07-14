import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';
import 'package:vcardsmart/features/nfc/presentation/pages/nfc_share_page.dart';
import 'package:vcardsmart/features/nfc/presentation/pages/nfc_receive_page.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_status_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_instruction_widget.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('NFCStatus', () {
    test('should have default values', () {
      const status = NFCStatus();
      expect(status.state, NFCState.idle);
      expect(status.profile, isNull);
      expect(status.error, isNull);
      expect(status.isAvailable, false);
    });

    test('copyWith should create new state', () {
      const status = NFCStatus();
      final updated = status.copyWith(
        state: NFCState.sending,
        isAvailable: true,
      );
      expect(updated.state, NFCState.sending);
      expect(updated.isAvailable, true);
      expect(updated.error, isNull);
    });

    test('copyWith should clear error', () {
      const status = NFCStatus(error: 'old');
      final updated = status.copyWith();
      expect(updated.error, isNull);
    });

    test('copyWith should preserve all fields', () {
      const status = NFCStatus(
        state: NFCState.receiving,
        isAvailable: true,
        error: 'err',
      );
      final updated = status.copyWith();
      expect(updated.state, NFCState.receiving);
      expect(updated.isAvailable, true);
      expect(updated.error, isNull);
    });
  });

  group('NFCSharePage', () {
    final profile = Profile(
      id: '1',
      name: 'Test User',
      email: 'test@email.com',
      phone: '1234567890',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );

    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: NFCSharePage(profile: profile)),
        ),
      );
      expect(find.text('Compartilhar via NFC'), findsOneWidget);
    });

    testWidgets('should display start button when idle', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: NFCSharePage(profile: profile)),
        ),
      );
      expect(find.text('Iniciar envio'), findsOneWidget);
    });

    testWidgets('should display NFC icon', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: NFCSharePage(profile: profile)),
        ),
      );
      expect(find.byIcon(Icons.nfc), findsOneWidget);
    });
  });

  group('NFCReceivePage', () {
    testWidgets('should display appBar title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCReceivePage()),
        ),
      );
      expect(find.text('Receber via NFC'), findsOneWidget);
    });

    testWidgets('should display start button when idle', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCReceivePage()),
        ),
      );
      expect(find.text('Iniciar recebimento'), findsOneWidget);
    });

    testWidgets('should display center title in appBar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCReceivePage()),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });
  });

  group('NFCStatusWidget', () {
    testWidgets('should display available icon when NFC is available', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCStatusWidget(isAvailable: true)),
        ),
      );
      expect(find.byIcon(Icons.nfc), findsOneWidget);
      expect(find.text('NFC disponível'), findsOneWidget);
    });

    testWidgets('should display unavailable when NFC not available', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCStatusWidget(isAvailable: false)),
        ),
      );
      expect(find.byIcon(Icons.nfc_outlined), findsOneWidget);
      expect(find.text('NFC indisponível'), findsOneWidget);
    });
  });

  group('NFCInstructionWidget', () {
    testWidgets('should display idle instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.idle)),
        ),
      );
      expect(find.text('Toque para iniciar'), findsOneWidget);
    });

    testWidgets('should display sending instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.sending)),
        ),
      );
      expect(find.text('Enviando perfil...'), findsOneWidget);
    });

    testWidgets('should display receiving instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.receiving)),
        ),
      );
      expect(find.text('Recebendo perfil...'), findsOneWidget);
    });

    testWidgets('should display success instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.success)),
        ),
      );
      expect(find.text('Transferência concluída!'), findsOneWidget);
    });

    testWidgets('should display error instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.error)),
        ),
      );
      expect(find.text('Erro ao comunicar via NFC'), findsOneWidget);
    });
  });
}
