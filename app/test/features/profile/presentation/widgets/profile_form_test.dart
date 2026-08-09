import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/profile_form.dart';

void main() {
  Profile? submitted;

  Future<void> pumpForm(WidgetTester tester, {Profile? profile}) async {
    submitted = null;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileForm(
            profile: profile,
            onSubmit: (p) => submitted = p,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder linkedinField() =>
      find.widgetWithText(TextFormField, 'LinkedIn');
  Finder instagramField() =>
      find.widgetWithText(TextFormField, 'Instagram');
  Finder facebookField() =>
      find.widgetWithText(TextFormField, 'Facebook');
  Finder xField() => find.widgetWithText(TextFormField, 'X (Twitter)');
  Finder socialField() =>
      find.widgetWithText(TextFormField, 'Outra Rede Social');
  Finder websiteField() => find.widgetWithText(TextFormField, 'Website');
  Finder nameField() => find.widgetWithText(TextFormField, 'Nome *');

  Future<void> scrollTo(WidgetTester tester, Finder finder) async {
    await tester.dragUntilVisible(
      finder,
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
  }

  group('ProfileForm social prefixes', () {
    testWidgets('shows fixed prefixes that cannot be deleted',
        (tester) async {
      await pumpForm(tester);

      await scrollTo(tester, find.text('linkedin.com/in/'));
      expect(find.text('linkedin.com/in/'), findsOneWidget);
      await scrollTo(tester, find.text('@'));
      expect(find.text('@'), findsOneWidget);
      await scrollTo(tester, find.text('facebook.com/'));
      expect(find.text('facebook.com/'), findsOneWidget);
      await scrollTo(tester, find.text('x.com/'));
      expect(find.text('x.com/'), findsOneWidget);
      await scrollTo(tester, find.text('https://'));
      expect(find.text('https://'), findsOneWidget);
    });

    testWidgets('saves prefixed values when only handle typed',
        (tester) async {
      await pumpForm(tester);

      await tester.enterText(nameField(), 'John Doe');
      await scrollTo(tester, linkedinField());
      await tester.enterText(linkedinField(), 'johndoe');
      await scrollTo(tester, instagramField());
      await tester.enterText(instagramField(), 'johndoe');
      await scrollTo(tester, facebookField());
      await tester.enterText(facebookField(), 'johndoe');
      await scrollTo(tester, xField());
      await tester.enterText(xField(), 'johndoe');
      await scrollTo(tester, socialField());
      await tester.enterText(socialField(), 'https://example.social/me');
      await scrollTo(tester, websiteField());
      await tester.enterText(websiteField(), 'example.com');

      await scrollTo(tester, find.text('Salvar'));
      await tester.tap(find.text('Salvar'));
      await tester.pump();

      expect(submitted!.linkedin, 'linkedin.com/in/johndoe');
      expect(submitted!.instagram, '@johndoe');
      expect(submitted!.facebook, 'facebook.com/johndoe');
      expect(submitted!.x, 'x.com/johndoe');
      expect(submitted!.social, 'https://example.social/me');
      expect(submitted!.website, 'https://example.com');
    });

    testWidgets('loads existing values stripping prefix', (tester) async {
      final profile = Profile(
        id: '1',
        name: 'John',
        linkedin: 'linkedin.com/in/johndoe',
        instagram: '@johndoe',
        facebook: 'facebook.com/johndoe',
        x: 'x.com/johndoe',
        social: 'https://example.social/me',
        website: 'https://example.com',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await pumpForm(tester, profile: profile);

      String controllerText(Finder field) => tester
          .widget<TextFormField>(field)
          .controller!
          .text;

      await scrollTo(tester, linkedinField());
      expect(controllerText(linkedinField()), 'johndoe');
      await scrollTo(tester, instagramField());
      expect(controllerText(instagramField()), 'johndoe');
      await scrollTo(tester, facebookField());
      expect(controllerText(facebookField()), 'johndoe');
      await scrollTo(tester, xField());
      expect(controllerText(xField()), 'johndoe');
      await scrollTo(tester, socialField());
      expect(controllerText(socialField()), 'https://example.social/me');
      await scrollTo(tester, websiteField());
      expect(controllerText(websiteField()), 'example.com');
    });

    testWidgets('keeps full URL when user types it entirely',
        (tester) async {
      await pumpForm(tester);

      await tester.enterText(nameField(), 'John Doe');
      await scrollTo(tester, websiteField());
      await tester.enterText(websiteField(), 'https://www.example.com');

      await scrollTo(tester, find.text('Salvar'));
      await tester.tap(find.text('Salvar'));
      await tester.pump();

      expect(submitted!.website, 'https://www.example.com');
    });
  });
}
