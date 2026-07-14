import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_instruction_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';

void main() {
  group('NFCInstructionWidget', () {
    testWidgets('should show idle text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.idle),
          ),
        ),
      );

      expect(find.text('Toque para iniciar'), findsOneWidget);
      expect(find.byIcon(Icons.nfc), findsOneWidget);
    });

    testWidgets('should show sending text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.sending),
          ),
        ),
      );

      expect(find.text('Enviando perfil...'), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('should show receiving text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.receiving),
          ),
        ),
      );

      expect(find.text('Recebendo perfil...'), findsOneWidget);
    });

    testWidgets('should show success text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.success),
          ),
        ),
      );

      expect(find.text('Transferência concluída!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('should show error text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.error),
          ),
        ),
      );

      expect(find.text('Erro ao comunicar via NFC'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('should show ready text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NFCInstructionWidget(state: NFCState.ready),
          ),
        ),
      );

      expect(find.text('Aproxime os dispositivos'), findsOneWidget);
    });
  });
}
