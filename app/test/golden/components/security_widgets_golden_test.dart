import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/security/presentation/widgets/pin_input.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('PinInput Golden', () {
    testWidgets('4 digits light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: PinInput(
                length: 4,
                onCompleted: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PinInput),
        matchesGoldenFile('golden_files/components/pin_input_4_light.png'),
      );
    });

    testWidgets('6 digits light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: PinInput(
                length: 6,
                onCompleted: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PinInput),
        matchesGoldenFile('golden_files/components/pin_input_6_light.png'),
      );
    });

    testWidgets('4 digits dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Center(
              child: PinInput(
                length: 4,
                onCompleted: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PinInput),
        matchesGoldenFile('golden_files/components/pin_input_4_dark.png'),
      );
    });
  });
}
