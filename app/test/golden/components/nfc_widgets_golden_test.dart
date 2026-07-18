import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_status_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/widgets/nfc_instruction_widget.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('NFCStatusWidget Golden', () {
    testWidgets('NFC available light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCStatusWidget(isAvailable: true),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCStatusWidget),
        matchesGoldenFile('golden_files/components/nfc_status_available_light.png'),
      );
    });

    testWidgets('NFC unavailable light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCStatusWidget(isAvailable: false),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCStatusWidget),
        matchesGoldenFile('golden_files/components/nfc_status_unavailable_light.png'),
      );
    });

    testWidgets('NFC available dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(
              child: NFCStatusWidget(isAvailable: true),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCStatusWidget),
        matchesGoldenFile('golden_files/components/nfc_status_available_dark.png'),
      );
    });
  });

  group('NFCInstructionWidget Golden', () {
    testWidgets('idle state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCInstructionWidget(state: NFCState.idle),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCInstructionWidget),
        matchesGoldenFile('golden_files/components/nfc_instruction_idle_light.png'),
      );
    });

    testWidgets('sending state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCInstructionWidget(state: NFCState.sending),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCInstructionWidget),
        matchesGoldenFile('golden_files/components/nfc_instruction_sending_light.png'),
      );
    });

    testWidgets('success state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCInstructionWidget(state: NFCState.success),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCInstructionWidget),
        matchesGoldenFile('golden_files/components/nfc_instruction_success_light.png'),
      );
    });

    testWidgets('error state light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Center(
              child: NFCInstructionWidget(state: NFCState.error),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(NFCInstructionWidget),
        matchesGoldenFile('golden_files/components/nfc_instruction_error_light.png'),
      );
    });
  });
}
