import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/utils/vcard_utils.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';

void main() {
  group('VCardUtils', () {
    group('encode', () {
      test('should encode basic vCard 3.0', () {
        const data = VCardData(
          firstName: 'João',
          lastName: 'Silva',
          email: 'joao@email.com',
          phone: '+5511999999999',
        );

        final result = VCardUtils.encode(data);

        expect(result, contains('BEGIN:VCARD'));
        expect(result, contains('VERSION:3.0'));
        expect(result, contains('FN:João Silva'));
        expect(result, contains('N:João;Silva;;;'));
        expect(result, contains('EMAIL:joao@email.com'));
        expect(result, contains('TEL:+5511999999999'));
        expect(result, contains('END:VCARD'));
      });

      test('should encode vCard 4.0', () {
        const data = VCardData(
          version: '4.0',
          firstName: 'Ana',
          lastName: 'Costa',
        );

        final result = VCardUtils.encode(data);

        expect(result, contains('VERSION:4.0'));
        expect(result, contains('FN:Ana Costa'));
      });

      test('should encode all fields', () {
        const data = VCardData(
          firstName: 'Pedro',
          lastName: 'Santos',
          organization: 'Tech Corp',
          title: 'Dev',
          email: 'pedro@tech.com',
          phone: '+5511888888888',
          website: 'https://pedro.com',
          address: 'São Paulo, BR',
          note: 'Dev Flutter',
          linkedin: 'linkedin.com/in/pedro',
          facebook: 'facebook.com/pedro',
          x: 'x.com/pedro',
          social: 'https://pedro.social',
        );

        final result = VCardUtils.encode(data);

        expect(result, contains('ORG:Tech Corp'));
        expect(result, contains('TITLE:Dev'));
        expect(result, contains('URL:https://pedro.com'));
        expect(result, contains('ADR:;;São Paulo, BR;;;'));
        expect(result, contains('NOTE:Dev Flutter'));
        expect(result, contains('X-LINKEDIN:linkedin.com/in/pedro'));
        expect(result, contains('X-FACEBOOK:facebook.com/pedro'));
        expect(result, contains('X-TWITTER:x.com/pedro'));
        expect(result, contains('X-SOCIAL:https://pedro.social'));
      });

      test('should skip empty optional fields', () {
        const data = VCardData(firstName: 'Maria');

        final result = VCardUtils.encode(data);

        expect(result, isNot(contains('ORG:')));
        expect(result, isNot(contains('EMAIL:')));
        expect(result, isNot(contains('TEL:')));
      });

      test('should encode photo', () {
        const data = VCardData(
          firstName: 'Test',
          photo: 'base64data',
        );

        final result = VCardUtils.encode(data);

        expect(result, contains('PHOTO;ENCODING=b;TYPE=JPEG:base64data'));
      });
    });

    group('decode', () {
      test('should decode vCard with all fields', () {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Ana Costa\n'
            'N:Ana;Costa;;;\n'
            'ORG:Design Inc\n'
            'TITLE:Designer\n'
            'EMAIL:ana@design.com\n'
            'TEL:+5511777777777\n'
            'URL:https://ana.com\n'
            'ADR:;;Rio de Janeiro, BR;;;\n'
            'X-LINKEDIN:linkedin.com/in/ana\n'
            'X-FACEBOOK:facebook.com/ana\n'
            'X-TWITTER:x.com/ana\n'
            'X-SOCIAL:https://ana.social\n'
            'NOTE:UX Designer\n'
            'END:VCARD';

        final data = VCardUtils.decode(vcard);

        expect(data.version, '3.0');
        expect(data.firstName, 'Ana');
        expect(data.lastName, 'Costa');
        expect(data.organization, 'Design Inc');
        expect(data.title, 'Designer');
        expect(data.email, 'ana@design.com');
        expect(data.phone, '+5511777777777');
        expect(data.website, 'https://ana.com');
        expect(data.address, 'Rio de Janeiro, BR');
        expect(data.linkedin, 'linkedin.com/in/ana');
        expect(data.facebook, 'facebook.com/ana');
        expect(data.x, 'x.com/ana');
        expect(data.social, 'https://ana.social');
        expect(data.note, 'UX Designer');
      });

      test('should decode vCard 4.0', () {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:4.0\n'
            'FN:Carlos Lima\n'
            'END:VCARD';

        final data = VCardUtils.decode(vcard);

        expect(data.version, '4.0');
        expect(data.firstName, 'Carlos');
      });

      test('should decode minimal vCard', () {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Minimal\n'
            'END:VCARD';

        final data = VCardUtils.decode(vcard);

        expect(data.firstName, 'Minimal');
        expect(data.email, isNull);
        expect(data.phone, isNull);
      });

      test('should decode N field when FN not present', () {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'N:Last;First;;;\n'
            'END:VCARD';

        final data = VCardUtils.decode(vcard);

        expect(data.firstName, 'Last');
        expect(data.lastName, 'First');
      });
    });

    group('roundtrip', () {
      test('encode then decode should preserve data', () {
        const original = VCardData(
          firstName: 'Test',
          lastName: 'User',
          email: 'test@email.com',
          phone: '+5511999999999',
          organization: 'Test Corp',
        );

        final encoded = VCardUtils.encode(original);
        final decoded = VCardUtils.decode(encoded);

        expect(decoded.firstName, original.firstName);
        expect(decoded.lastName, original.lastName);
        expect(decoded.email, original.email);
        expect(decoded.phone, original.phone);
        expect(decoded.organization, original.organization);
      });
    });

    group('decode PHOTO', () {
      test('should decode PHOTO line', () {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Photo User\n'
            'PHOTO;ENCODING=b;TYPE=JPEG:imagedata\n'
            'END:VCARD';

        final data = VCardUtils.decode(vcard);
        expect(data.photo, 'imagedata');
      });
    });

    group('toFile / fromFile', () {
      test('should write and read vCard file', () {
        const data = VCardData(
          firstName: 'File',
          lastName: 'Test',
          email: 'file@test.com',
        );

        final dir = Directory.systemTemp.createTempSync('vcard_utils_test');
        final path = '${dir.path}/test.vcf';

        VCardUtils.toFile(data, path);
        final file = File(path);
        expect(file.existsSync(), isTrue);

        final decoded = VCardUtils.fromFile(file);
        expect(decoded.firstName, 'File');
        expect(decoded.lastName, 'Test');
        expect(decoded.email, 'file@test.com');

        dir.deleteSync(recursive: true);
      });
    });
  });
}
