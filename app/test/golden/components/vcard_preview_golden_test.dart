import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/vcard/presentation/widgets/vcard_preview.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';
import 'package:vcardsmart/core/theme/app_theme.dart';

void main() {
  group('VCardPreview Golden', () {
    testWidgets('full data light theme', (tester) async {
      const data = VCardData(
        firstName: 'João',
        lastName: 'Silva',
        title: 'Desenvolvedor',
        organization: 'Tech Corp',
        email: 'joao@techcorp.com',
        phone: '+5511999999999',
        website: 'https://joaosilva.com',
        address: 'São Paulo, SP',
        note: 'Contato de trabalho',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SingleChildScrollView(
              child: VCardPreview(data: data),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(VCardPreview),
        matchesGoldenFile('golden_files/components/vcard_preview_full_light.png'),
      );
    });

    testWidgets('full data dark theme', (tester) async {
      const data = VCardData(
        firstName: 'João',
        lastName: 'Silva',
        title: 'Desenvolvedor',
        organization: 'Tech Corp',
        email: 'joao@techcorp.com',
        phone: '+5511999999999',
        website: 'https://joaosilva.com',
        address: 'São Paulo, SP',
        note: 'Contato de trabalho',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: SingleChildScrollView(
              child: VCardPreview(data: data),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(VCardPreview),
        matchesGoldenFile('golden_files/components/vcard_preview_full_dark.png'),
      );
    });

    testWidgets('minimal data light theme', (tester) async {
      const data = VCardData(
        firstName: 'Maria',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: SingleChildScrollView(
              child: VCardPreview(data: data),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(VCardPreview),
        matchesGoldenFile('golden_files/components/vcard_preview_minimal_light.png'),
      );
    });
  });
}
