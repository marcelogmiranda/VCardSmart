import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/qr_code/domain/entities/qr_data.dart';

void main() {
  group('QRData', () {
    test('should create QRData with required fields', () {
      final now = DateTime.now();
      final qrData = QRData(
        type: 'vcard',
        payload: 'BEGIN:VCARD\nFN:Test\nEND:VCARD',
        timestamp: now,
      );

      expect(qrData.type, 'vcard');
      expect(qrData.payload, contains('BEGIN:VCARD'));
      expect(qrData.timestamp, now);
    });

    test('copyWith should create new instance with updated fields', () {
      final original = QRData(
        type: 'vcard',
        payload: 'data',
        timestamp: DateTime.now(),
      );

      final updated = original.copyWith(type: 'text', payload: 'new data');

      expect(updated.type, 'text');
      expect(updated.payload, 'new data');
    });

    test('copyWith should keep existing fields when not provided', () {
      final now = DateTime.now();
      final original = QRData(
        type: 'vcard',
        payload: 'data',
        timestamp: now,
      );

      final copy = original.copyWith();

      expect(copy.type, 'vcard');
      expect(copy.payload, 'data');
      expect(copy.timestamp, now);
    });
  });
}
