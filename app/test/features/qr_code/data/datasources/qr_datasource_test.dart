import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/data/datasources/qr_datasource.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  late LocalQRDataSource dataSource;

  setUp(() {
    dataSource = LocalQRDataSource();
  });

  group('LocalQRDataSource', () {
    late Profile testProfile;

    setUp(() {
      testProfile = Profile(
        id: '1',
        name: 'Test User',
        email: 'test@email.com',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
    });

    test('generateQRData should return vCard payload', () {
      final result = dataSource.generateQRData(testProfile);

      expect(result, contains('BEGIN:VCARD'));
      expect(result, contains('FN:Test User'));
      expect(result, contains('END:VCARD'));
    });

    test('decodeQRData should parse vCard back to Profile', () {
      final vCard = dataSource.generateQRData(testProfile);
      final result = dataSource.decodeQRData(vCard);

      expect(result.name, 'Test User');
      expect(result.email, 'test@email.com');
    });
  });
}
