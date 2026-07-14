import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/profile_card.dart';

void main() {
  group('ProfileCard', () {
    testWidgets('should display profile name', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('should display email when provided', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John',
        email: 'john@example.com',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('should display first letter of name', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('J'), findsOneWidget);
    });

    testWidgets('should respond to tap', (tester) async {
      bool tapped = false;
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              profile: profile,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ProfileCard));
      expect(tapped, true);
    });
  });
}
