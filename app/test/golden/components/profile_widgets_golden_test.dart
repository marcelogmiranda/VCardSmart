import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/profile_header.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/profile_card.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('ProfileHeader Golden', () {
    testWidgets('with all data light theme', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'João Silva',
        email: 'joao@email.com',
        phone: '+5511999999999',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileHeader(profile: profile),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileHeader),
        matchesGoldenFile('golden_files/components/profile_header_full_light.png'),
      );
    });

    testWidgets('with all data dark theme', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'João Silva',
        email: 'joao@email.com',
        phone: '+5511999999999',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileHeader(profile: profile),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileHeader),
        matchesGoldenFile('golden_files/components/profile_header_full_dark.png'),
      );
    });

    testWidgets('minimal data light theme', (tester) async {
      final profile = Profile(
        id: '2',
        name: 'Maria',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileHeader(profile: profile),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileHeader),
        matchesGoldenFile('golden_files/components/profile_header_minimal_light.png'),
      );
    });
  });

  group('ProfileCard Golden', () {
    testWidgets('with email light theme', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'João Silva',
        email: 'joao@email.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ProfileCard(
              profile: profile,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileCard),
        matchesGoldenFile('golden_files/components/profile_card_light.png'),
      );
    });

    testWidgets('without email light theme', (tester) async {
      final profile = Profile(
        id: '2',
        name: 'Maria',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ProfileCard(
              profile: profile,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileCard),
        matchesGoldenFile('golden_files/components/profile_card_no_email_light.png'),
      );
    });

    testWidgets('dark theme', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'João Silva',
        email: 'joao@email.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(
              profile: profile,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(ProfileCard),
        matchesGoldenFile('golden_files/components/profile_card_dark.png'),
      );
    });
  });
}
