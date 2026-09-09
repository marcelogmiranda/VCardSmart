import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/data/models/profile_vcard_converter.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('ProfileVCardConverter', () {
    final profile = Profile(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+5511999999999',
      website: 'https://johndoe.com',
      linkedin: 'linkedin.com/in/johndoe',
      instagram: '@johndoe',
      facebook: 'facebook.com/johndoe',
      x: 'x.com/johndoe',
      social: 'https://johndoe.social',
      bio: 'Developer',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );

    test('encodeProfile should produce a standard vCard', () {
      final vcard = ProfileVCardConverter.encodeProfile(profile);

      expect(vcard, startsWith('BEGIN:VCARD'));
      expect(vcard, contains('VERSION:3.0'));
      expect(vcard, contains('FN:John Doe'));
      expect(vcard, contains('TEL;TYPE=CELL:+5511999999999'));
      expect(vcard, contains('EMAIL:john@example.com'));
      expect(vcard, contains('URL:https://johndoe.com'));
      expect(vcard, contains('X-LINKEDIN:linkedin.com/in/johndoe'));
      expect(vcard, contains('X-FACEBOOK:facebook.com/johndoe'));
      expect(vcard, contains('X-TWITTER:x.com/johndoe'));
      expect(vcard, contains('X-SOCIAL:https://johndoe.social'));
      expect(vcard, contains('X-INSTAGRAM:@johndoe'));
      expect(vcard, contains('NOTE:Developer'));
      expect(vcard.trimRight(), endsWith('END:VCARD'));
    });

    test('decodeVCard should parse all fields back', () {
      final vcard = ProfileVCardConverter.encodeProfile(profile);
      final decoded = ProfileVCardConverter.decodeVCard(vcard);

      expect(decoded.name, 'John Doe');
      expect(decoded.email, 'john@example.com');
      expect(decoded.phone, '+5511999999999');
      expect(decoded.website, 'https://johndoe.com');
      expect(decoded.linkedin, 'linkedin.com/in/johndoe');
      expect(decoded.instagram, '@johndoe');
      expect(decoded.facebook, 'facebook.com/johndoe');
      expect(decoded.x, 'x.com/johndoe');
      expect(decoded.social, 'https://johndoe.social');
      expect(decoded.bio, 'Developer');
    });

    test('decodeVCard should handle vCard from another app with N: format', () {
      const externalVCard = 'BEGIN:VCARD\n'
          'VERSION:3.0\n'
          'N:Miranda;Marcelo;;;\n'
          'FN:Marcelo Miranda\n'
          'TEL;TYPE=cell:+5511988887777\n'
          'EMAIL:marcelo@test.com\n'
          'END:VCARD';

      final decoded = ProfileVCardConverter.decodeVCard(externalVCard);

      expect(decoded.name, 'Marcelo Miranda');
      expect(decoded.phone, '+5511988887777');
      expect(decoded.email, 'marcelo@test.com');
    });

    test('decodeVCard should fall back to email when no name', () {
      const vcard = 'BEGIN:VCARD\n'
          'VERSION:3.0\n'
          'EMAIL:only@email.com\n'
          'END:VCARD';

      final decoded = ProfileVCardConverter.decodeVCard(vcard);
      expect(decoded.name, 'only@email.com');
      expect(decoded.email, 'only@email.com');
    });

    test('isVCardPayload should detect vCard payloads', () {
      expect(ProfileVCardConverter.isVCardPayload('BEGIN:VCARD\n...'), true);
      expect(ProfileVCardConverter.isVCardPayload('  begin:vcard\n'), true);
      expect(ProfileVCardConverter.isVCardPayload('{"name":"x"}'), false);
    });

    test('encodeProfile should escape line breaks in fields', () {
      final dirty = Profile(
        id: '2',
        name: 'Bad\nName',
        bio: 'line1\nline2',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      final vcard = ProfileVCardConverter.encodeProfile(dirty);
      expect(vcard.split('\n').where((l) => l.contains('FN:Bad')).length, 1);
    });

    test('profileFromText should turn a URL into a contact with the URL', () {
      final profile =
          ProfileVCardConverter.profileFromText('https://instagram.marcelo.com');

      expect(profile.website, 'https://instagram.marcelo.com');
      expect(profile.name, isNotEmpty);
    });

    test('profileFromText should keep plain text as the contact name', () {
      final profile = ProfileVCardConverter.profileFromText('Minha Loja');

      expect(profile.website, isNull);
      expect(profile.name, 'Minha Loja');
    });
  });
}
