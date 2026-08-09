import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/vcard/data/datasources/vcard_datasource.dart';
import 'package:vcardsmart/features/vcard/domain/entities/vcard_data.dart';

void main() {
  late VCardDataSource dataSource;

  setUp(() {
    dataSource = VCardDataSource();
  });

  group('VCardDataSource', () {
    group('encode', () {
      test('should encode VCardData to vCard string', () async {
        const data = VCardData(
          firstName: 'João',
          lastName: 'Silva',
          email: 'joao@email.com',
        );

        final result = await dataSource.encode(data);

        expect(result, contains('BEGIN:VCARD'));
        expect(result, contains('VERSION:3.0'));
        expect(result, contains('FN:João Silva'));
        expect(result, contains('EMAIL:joao@email.com'));
        expect(result, contains('END:VCARD'));
      });

      test('should encode all optional fields', () async {
        const data = VCardData(
          firstName: 'Maria',
          lastName: 'Santos',
          organization: 'Tech Corp',
          title: 'Engineer',
          email: 'maria@tech.com',
          phone: '+551199999',
          website: 'https://maria.com',
          address: 'Rua A, 123',
          linkedin: 'linkedin.com/in/maria',
          facebook: 'facebook.com/maria',
          x: 'x.com/maria',
          social: 'https://maria.social',
          note: 'Important contact',
          photo: 'base64data',
        );

        final result = await dataSource.encode(data);

        expect(result, contains('FN:Maria Santos'));
        expect(result, contains('N:Maria;Santos;;;'));
        expect(result, contains('ORG:Tech Corp'));
        expect(result, contains('TITLE:Engineer'));
        expect(result, contains('EMAIL:maria@tech.com'));
        expect(result, contains('TEL:+551199999'));
        expect(result, contains('URL:https://maria.com'));
        expect(result, contains('ADR:;;Rua A, 123;;;'));
        expect(result, contains('X-LINKEDIN:linkedin.com/in/maria'));
        expect(result, contains('X-FACEBOOK:facebook.com/maria'));
        expect(result, contains('X-TWITTER:x.com/maria'));
        expect(result, contains('X-SOCIAL:https://maria.social'));
        expect(result, contains('NOTE:Important contact'));
        expect(result, contains('PHOTO;ENCODING=b;TYPE=JPEG:base64data'));
      });

      test('should skip empty optional fields', () async {
        const data = VCardData(
          firstName: 'Ana',
          lastName: 'Costa',
        );

        final result = await dataSource.encode(data);

        expect(result, isNot(contains('ORG:')));
        expect(result, isNot(contains('TITLE:')));
        expect(result, isNot(contains('EMAIL:')));
        expect(result, isNot(contains('TEL:')));
        expect(result, isNot(contains('URL:')));
        expect(result, isNot(contains('ADR:')));
        expect(result, isNot(contains('X-LINKEDIN:')));
        expect(result, isNot(contains('NOTE:')));
        expect(result, isNot(contains('PHOTO;')));
      });
    });

    group('decode', () {
      test('should decode vCard string to VCardData', () async {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:Ana Costa\n'
            'EMAIL:ana@email.com\n'
            'TEL:+5511888888888\n'
            'END:VCARD';

        final result = await dataSource.decode(vcard);

        expect(result.firstName, 'Ana');
        expect(result.lastName, 'Costa');
        expect(result.email, 'ana@email.com');
        expect(result.phone, '+5511888888888');
      });

      test('should decode all fields', () async {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:4.0\n'
            'N:Carlos;Lima\n'
            'FN:Carlos Lima\n'
            'ORG:Big Corp\n'
            'TITLE:Director\n'
            'EMAIL:carlos@corp.com\n'
            'TEL:+551177777\n'
            'URL:https://carlos.com\n'
            'ADR:;;Rua B, 456;;;;\n'
            'X-LINKEDIN:linkedin.com/in/carlos\n'
            'X-FACEBOOK:facebook.com/carlos\n'
            'X-TWITTER:x.com/carlos\n'
            'X-SOCIAL:https://carlos.social\n'
            'NOTE:My note\n'
            'PHOTO;ENCODING=b;TYPE=JPEG:photodata\n'
            'END:VCARD';

        final result = await dataSource.decode(vcard);

        expect(result.version, '4.0');
        expect(result.firstName, 'Carlos');
        expect(result.lastName, 'Lima');
        expect(result.organization, 'Big Corp');
        expect(result.title, 'Director');
        expect(result.email, 'carlos@corp.com');
        expect(result.phone, '+551177777');
        expect(result.website, 'https://carlos.com');
        expect(result.address, contains('Rua B, 456'));
        expect(result.linkedin, 'linkedin.com/in/carlos');
        expect(result.facebook, 'facebook.com/carlos');
        expect(result.x, 'x.com/carlos');
        expect(result.social, 'https://carlos.social');
        expect(result.note, 'My note');
        expect(result.photo, 'photodata');
      });

      test('should handle N: line with empty parts', () async {
        const vcard = 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'N:;;;\n'
            'END:VCARD';

        final result = await dataSource.decode(vcard);

        expect(result.firstName, isNull);
        expect(result.lastName, isNull);
      });
    });

    group('exportToFile', () {
      test('should write vCard to file', () async {
        final dir = await Directory.systemTemp.createTemp('vcard_test');
        const data = VCardData(firstName: 'Export', email: 'exp@test.com');
        final path = '${dir.path}/export.vcf';

        await dataSource.exportToFile(data, path);

        final file = File(path);
        expect(await file.exists(), isTrue);
        final content = await file.readAsString();
        expect(content, contains('FN:Export'));
        expect(content, contains('EMAIL:exp@test.com'));

        await dir.delete(recursive: true);
      });
    });

    group('importFromFile', () {
      test('should read vCard from file', () async {
        final dir = await Directory.systemTemp.createTemp('vcard_import');
        final file = File('${dir.path}/import.vcf');
        await file.writeAsString(
          'BEGIN:VCARD\nVERSION:3.0\nFN:Imported User\nEMAIL:import@test.com\nEND:VCARD',
        );

        final result = await dataSource.importFromFile(file.path);

        expect(result.firstName, 'Imported');
        expect(result.lastName, 'User');
        expect(result.email, 'import@test.com');

        await dir.delete(recursive: true);
      });
    });
  });
}
