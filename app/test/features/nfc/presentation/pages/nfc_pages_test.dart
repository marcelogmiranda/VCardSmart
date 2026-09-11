import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';
import 'package:vcardsmart/features/nfc/presentation/pages/nfc_share_page.dart';
import 'package:vcardsmart/features/nfc/presentation/pages/nfc_receive_page.dart';
import 'package:vcardsmart/features/nfc/presentation/pages/nfc_main_page.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_status_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_instruction_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_write_option_sheet.dart';
import 'package:vcardsmart/features/nfc/data/models/nfc_write_option.dart';
import 'package:vcardsmart/features/nfc/data/models/profile_vcard_converter.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

import '../../nfc_channel_mock.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    NfcChannelMock().install();
  });
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
      expect(find.text('Gravar em Cartão NFC'), findsOneWidget);
    });

    testWidgets('should display start button when idle', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: NFCSharePage(profile: profile)),
        ),
      );
      expect(find.text('Gravar no cartão'), findsOneWidget);
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
      await tester.pumpAndSettle();
      expect(find.text('Receber via NFC'), findsOneWidget);
    });

    testWidgets('should display start button when idle', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCReceivePage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Iniciar recebimento'), findsOneWidget);
    });

    testWidgets('should display center title in appBar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCReceivePage()),
        ),
      );
      await tester.pumpAndSettle();
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });
  });

  group('NFCMainPage', () {
    testWidgets('should display appBar title when NFC available',
        (tester) async {
      final mock = NfcChannelMock()..available = true;
      mock.install();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCMainPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('NFC'), findsOneWidget);
    });

    testWidgets('should display gravar cartao button when NFC available',
        (tester) async {
      final mock = NfcChannelMock()..available = true;
      mock.install();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCMainPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Gravar Cartão'), findsOneWidget);
    });

    testWidgets('should display receber contato button when NFC available',
        (tester) async {
      final mock = NfcChannelMock()..available = true;
      mock.install();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCMainPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Receber Contato'), findsOneWidget);
    });

    testWidgets('should display unavailable message when NFC not available',
        (tester) async {
      final mock = NfcChannelMock()..available = false;
      mock.install();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCMainPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('NFC não disponível'), findsOneWidget);
    });

    testWidgets('should display unavailable detail when NFC not available',
        (tester) async {
      final mock = NfcChannelMock()..available = false;
      mock.install();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: NFCMainPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('não possui funcionalidade NFC'),
        findsOneWidget,
      );
    });
  });

  group('NFCStatusWidget', () {
    testWidgets('should display available icon when NFC is available',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCStatusWidget(isAvailable: true)),
        ),
      );
      expect(find.byIcon(Icons.nfc), findsOneWidget);
      expect(find.text('NFC disponível'), findsOneWidget);
    });

    testWidgets('should display unavailable when NFC not available',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCStatusWidget(isAvailable: false)),
        ),
      );
      expect(find.byIcon(Icons.nfc_outlined), findsOneWidget);
      expect(find.text('NFC indisponível'), findsOneWidget);
    });
  });

  group('NfcWriteOptionSheet', () {
    final options = [
      const NfcWriteOption(
        field: ProfileField.email,
        title: 'E-mail',
        detail: 'a@b.com',
        vCard: 'BEGIN:VCARD',
      ),
      const NfcWriteOption(
        field: ProfileField.phone,
        title: 'Telefone',
        detail: '+55 11',
        vCard: 'BEGIN:VCARD',
      ),
    ];

    testWidgets('should list every option with its detail', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => showNfcWriteOptionSheet(context, options),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      expect(
        find.text('O cartão é pequeno para o perfil completo'),
        findsOneWidget,
      );
      expect(find.text('Escolha o que deseja gravar'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('a@b.com'), findsOneWidget);
      expect(find.text('Telefone'), findsOneWidget);
      expect(find.text('+55 11'), findsOneWidget);
    });

    testWidgets('should return the tapped option', (tester) async {
      late Future<NfcWriteOption?> result;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () =>
                    result = showNfcWriteOptionSheet(context, options),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Telefone'));
      await tester.pumpAndSettle();

      final chosen = await result;
      expect(chosen?.title, 'Telefone');
      expect(chosen?.field, ProfileField.phone);
    });
  });

  group('NFCInstructionWidget', () {
    testWidgets('should display idle instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.idle)),
        ),
      );
      expect(find.text('Toque no botão para iniciar'), findsOneWidget);
    });

    testWidgets('should display sending instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.sending)),
        ),
      );
      expect(
        find.text(
          'Segure o cartão na parte de trás do iPhone, próximo à câmera',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display receiving instruction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NFCInstructionWidget(state: NFCState.receiving)),
        ),
      );
      expect(
        find.text(
          'Segure o cartão na parte de trás do iPhone, próximo à câmera',
        ),
        findsOneWidget,
      );
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
