import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/domain/entities/nfc_data.dart';

void main() {
  group('NFCData', () {
    test('should create NFCData with required fields', () {
      final now = DateTime.now();
      final nfcData = NFCData(
        type: 'profile',
        payload: '{"name":"Test"}',
        timestamp: now,
      );

      expect(nfcData.type, 'profile');
      expect(nfcData.payload, '{"name":"Test"}');
      expect(nfcData.timestamp, now);
    });

    test('copyWith should create new instance', () {
      final now = DateTime.now();
      final original = NFCData(
        type: 'profile',
        payload: 'data',
        timestamp: now,
      );

      final updated = original.copyWith(type: 'vcard');

      expect(updated.type, 'vcard');
      expect(updated.payload, 'data');
      expect(updated.timestamp, now);
    });

    test('copyWith should keep existing fields when not provided', () {
      final now = DateTime.now();
      final original = NFCData(
        type: 'profile',
        payload: 'data',
        timestamp: now,
      );

      final copy = original.copyWith();

      expect(copy.type, 'profile');
      expect(copy.payload, 'data');
      expect(copy.timestamp, now);
    });
  });
}
