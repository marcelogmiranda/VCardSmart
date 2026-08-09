import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/nfc/data/models/nfc_payload.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('NFCPayload', () {
    test('encodeProfile should return JSON string with profile fields', () {
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '123456',
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

      final json = NFCPayload.encodeProfile(profile);
      expect(json, contains('"name":"John Doe"'));
      expect(json, contains('"email":"john@example.com"'));
      expect(json, contains('"phone":"123456"'));
      expect(json, contains('"website":"https://johndoe.com"'));
      expect(json, contains('"linkedin":"linkedin.com/in/johndoe"'));
      expect(json, contains('"instagram":"@johndoe"'));
      expect(json, contains('"facebook":"facebook.com/johndoe"'));
      expect(json, contains('"x":"x.com/johndoe"'));
      expect(json, contains('"social":"https://johndoe.social"'));
      expect(json, contains('"bio":"Developer"'));
    });

    test('decodeProfile should parse JSON string into Profile', () {
      const json = '{"name":"Jane","email":"jane@test.com","phone":"999","website":"https://jane.com","linkedin":"linkedin.com/in/jane","instagram":"@jane","facebook":"facebook.com/jane","x":"x.com/jane","social":"https://jane.social","bio":"Designer"}';

      final profile = NFCPayload.decodeProfile(json);

      expect(profile.name, 'Jane');
      expect(profile.email, 'jane@test.com');
      expect(profile.phone, '999');
      expect(profile.website, 'https://jane.com');
      expect(profile.linkedin, 'linkedin.com/in/jane');
      expect(profile.instagram, '@jane');
      expect(profile.facebook, 'facebook.com/jane');
      expect(profile.x, 'x.com/jane');
      expect(profile.social, 'https://jane.social');
      expect(profile.bio, 'Designer');
      expect(profile.id, isNotNull);
      expect(profile.createdAt, isNotNull);
      expect(profile.updatedAt, isNotNull);
    });

    test('decodeProfile should handle missing optional fields', () {
      const json = '{"name":"Only Name"}';

      final profile = NFCPayload.decodeProfile(json);

      expect(profile.name, 'Only Name');
      expect(profile.email, isNull);
      expect(profile.phone, isNull);
      expect(profile.website, isNull);
      expect(profile.linkedin, isNull);
      expect(profile.instagram, isNull);
      expect(profile.facebook, isNull);
      expect(profile.x, isNull);
      expect(profile.social, isNull);
      expect(profile.bio, isNull);
    });

    test('encodeProfile with partial fields should work', () {
      final profile = Profile(
        id: '2',
        name: 'Partial',
        email: 'p@test.com',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final json = NFCPayload.encodeProfile(profile);
      final decoded = NFCPayload.decodeProfile(json);

      expect(decoded.name, 'Partial');
      expect(decoded.email, 'p@test.com');
      expect(decoded.phone, isNull);
    });

    test('encodeToNFC should return NFCData with profile type', () {
      final profile = Profile(
        id: '3',
        name: 'NFC Test',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final nfcData = NFCPayload.encodeToNFC(profile);

      expect(nfcData.type, 'profile');
      expect(nfcData.payload, contains('"name":"NFC Test"'));
      expect(nfcData.timestamp, isNotNull);
    });

    test('encodeToNFC and decode should round-trip', () {
      final profile = Profile(
        id: '4',
        name: 'Round Trip',
        email: 'rt@test.com',
        phone: '555',
        website: 'https://rt.com',
        bio: 'Test bio',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final nfcData = NFCPayload.encodeToNFC(profile);
      final decoded = NFCPayload.decodeProfile(nfcData.payload);

      expect(decoded.name, profile.name);
      expect(decoded.email, profile.email);
      expect(decoded.phone, profile.phone);
      expect(decoded.website, profile.website);
      expect(decoded.bio, profile.bio);
    });
  });
}
