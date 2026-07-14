import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/domain/entities/nfc_data.dart';

void main() {
  group('NFCData - comprehensive', () {
    test('should create with different types', () {
      final nfc1 = NFCData(
        type: 'profile',
        payload: 'data1',
        timestamp: DateTime(2024),
      );
      final nfc2 = NFCData(
        type: 'vcard',
        payload: 'data2',
        timestamp: DateTime(2025),
      );
      final nfc3 = NFCData(
        type: 'contact',
        payload: '{}',
        timestamp: DateTime(2026),
      );

      expect(nfc1.type, 'profile');
      expect(nfc2.type, 'vcard');
      expect(nfc3.type, 'contact');
    });

    test('should store different payload formats', () {
      final jsonPayload = NFCData(
        type: 'profile',
        payload: '{"key":"value"}',
        timestamp: DateTime.now(),
      );
      final vcardPayload = NFCData(
        type: 'vcard',
        payload: 'BEGIN:VCARD\nVERSION:3.0\nEND:VCARD',
        timestamp: DateTime.now(),
      );

      expect(jsonPayload.payload, contains('key'));
      expect(vcardPayload.payload, contains('BEGIN:VCARD'));
    });

    test('copyWith should preserve timestamp when not specified', () {
      final ts = DateTime(2024, 3, 15, 10, 30);
      final original = NFCData(
        type: 'profile',
        payload: 'data',
        timestamp: ts,
      );

      final copy = original.copyWith(type: 'newtype');

      expect(copy.type, 'newtype');
      expect(copy.payload, 'data');
      expect(copy.timestamp, ts);
    });

    test('copyWith should update payload', () {
      final original = NFCData(
        type: 'profile',
        payload: 'old',
        timestamp: DateTime.now(),
      );

      final copy = original.copyWith(payload: 'new');

      expect(copy.payload, 'new');
    });

    test('copyWith should update timestamp', () {
      final original = NFCData(
        type: 'profile',
        payload: 'data',
        timestamp: DateTime(2024),
      );
      final newTs = DateTime(2025);

      final copy = original.copyWith(timestamp: newTs);

      expect(copy.timestamp, newTs);
    });
  });
}
