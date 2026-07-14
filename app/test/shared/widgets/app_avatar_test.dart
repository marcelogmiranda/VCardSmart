import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/shared/widgets/app_avatar.dart';

void main() {
  group('AppAvatar', () {
    testWidgets('should display initials when no image', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(initials: 'AB'),
          ),
        ),
      );

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('should display question mark when no initials', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(),
          ),
        ),
      );

      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('should apply custom size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(initials: 'AB', size: 80),
          ),
        ),
      );

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('should respond to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppAvatar(
              initials: 'AB',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('AB'));
      expect(tapped, isTrue);
    });
  });
}
