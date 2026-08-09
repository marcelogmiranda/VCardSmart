import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/data/models/qr_payload.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('QRPayload', () {
    late Profile testProfile;

  setUp(() {
    testProfile = Profile(
      id: '1',
      name: 'João Silva',
      email: 'joao@email.com',
      phone: '+5511999999999',
      website: 'https://joao.com',
      linkedin: 'linkedin.com/in/joaosilva',
      instagram: '@joaosilva',
      facebook: 'facebook.com/joaosilva',
      x: 'x.com/joaosilva',
      social: 'https://joao.social',
      bio: 'Desenvolvedor Flutter',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );
  });

    group('encodeVCard', () {
      test('should encode profile to vCard format', () {
        final vCard = QRPayload.encodeVCard(testProfile);

        expect(vCard, contains('BEGIN:VCARD'));
        expect(vCard, contains('VERSION:3.0'));
        expect(vCard, contains('FN:João Silva'));
        expect(vCard, contains('EMAIL:joao@email.com'));
        expect(vCard, contains('TEL:+5511999999999'));
        expect(vCard, contains('URL:https://joao.com'));
        expect(vCard, contains('X-LINKEDIN:linkedin.com/in/joaosilva'));
        expect(vCard, contains('X-INSTAGRAM:@joaosilva'));
        expect(vCard, contains('X-FACEBOOK:facebook.com/joaosilva'));
        expect(vCard, contains('X-TWITTER:x.com/joaosilva'));
        expect(vCard, contains('X-SOCIAL:https://joao.social'));
        expect(vCard, contains('NOTE:Desenvolvedor Flutter'));
        expect(vCard, contains('END:VCARD'));
      });

      test('should handle profile with minimal fields', () {
        final minimalProfile = Profile(
          id: '2',
          name: 'Maria Santos',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        );

        final vCard = QRPayload.encodeVCard(minimalProfile);

        expect(vCard, contains('FN:Maria Santos'));
        expect(vCard, isNot(contains('EMAIL:')));
        expect(vCard, isNot(contains('TEL:')));
      });

      test('should handle profile with empty optional fields', () {
        final profileWithEmpties = Profile(
          id: '3',
          name: 'Pedro',
          email: '',
          phone: '',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        );

        final vCard = QRPayload.encodeVCard(profileWithEmpties);

        expect(vCard, contains('FN:Pedro'));
        expect(vCard, isNot(contains('EMAIL:')));
        expect(vCard, isNot(contains('TEL:')));
      });
    });

    group('decodeVCard', () {
      test('should decode vCard string to Profile', () {
        const vCard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Ana Costa\n'
            'EMAIL:ana@email.com\n'
            'TEL:+5511888888888\n'
            'URL:https://ana.com\n'
            'X-LINKEDIN:linkedin.com/in/anacosta\n'
            'X-INSTAGRAM:@anacosta\n'
            'X-FACEBOOK:facebook.com/anacosta\n'
            'X-TWITTER:x.com/anacosta\n'
            'X-SOCIAL:https://ana.social\n'
            'NOTE:Designer UX\n'
            'END:VCARD';

        final profile = QRPayload.decodeVCard(vCard);

        expect(profile.name, 'Ana Costa');
        expect(profile.email, 'ana@email.com');
        expect(profile.phone, '+5511888888888');
        expect(profile.website, 'https://ana.com');
        expect(profile.linkedin, 'linkedin.com/in/anacosta');
        expect(profile.instagram, '@anacosta');
        expect(profile.facebook, 'facebook.com/anacosta');
        expect(profile.x, 'x.com/anacosta');
        expect(profile.social, 'https://ana.social');
        expect(profile.bio, 'Designer UX');
      });

      test('should decode vCard with missing optional fields', () {
        const vCard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Carlos Lima\n'
            'END:VCARD';

        final profile = QRPayload.decodeVCard(vCard);

        expect(profile.name, 'Carlos Lima');
        expect(profile.email, isNull);
        expect(profile.phone, isNull);
      });

      test('should throw FormatException when FN is missing', () {
        const vCard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'EMAIL:test@test.com\n'
            'END:VCARD';

        expect(() => QRPayload.decodeVCard(vCard), throwsFormatException);
      });
    });

    group('encodeProfile', () {
      test('should return QRData with vcard type', () {
        final qrData = QRPayload.encodeProfile(testProfile);

        expect(qrData.type, 'vcard');
        expect(qrData.payload, contains('BEGIN:VCARD'));
        expect(qrData.timestamp, isA<DateTime>());
      });
    });
  });
}
