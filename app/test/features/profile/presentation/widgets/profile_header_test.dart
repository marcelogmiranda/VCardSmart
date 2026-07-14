import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/profile_header.dart';

void main() {
  group('ProfileHeader', () {
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
            body: ProfileHeader(profile: profile),
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
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('john@example.com'), findsOneWidget);
    });

    testWidgets('should display phone when provided', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John',
        phone: '+5511999999999',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('+5511999999999'), findsOneWidget);
    });

    testWidgets('should display first letter as avatar', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('J'), findsOneWidget);
    });
  });
}
