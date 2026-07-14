import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('Profile', () {
    test('should create profile with required fields', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        createdAt: now,
        updatedAt: now,
      );

      expect(profile.id, '1');
      expect(profile.name, 'John Doe');
      expect(profile.email, isNull);
      expect(profile.phone, isNull);
      expect(profile.createdAt, now);
    });

    test('should create profile with optional fields', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+5511999999999',
        linkedin: 'linkedin.com/in/johndoe',
        website: 'johndoe.com',
        bio: 'Developer',
        createdAt: now,
        updatedAt: now,
      );

      expect(profile.email, 'john@example.com');
      expect(profile.phone, '+5511999999999');
      expect(profile.linkedin, 'linkedin.com/in/johndoe');
      expect(profile.website, 'johndoe.com');
      expect(profile.bio, 'Developer');
    });

    test('copyWith should create new instance with updated fields', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        createdAt: now,
        updatedAt: now,
      );

      final updated = profile.copyWith(name: 'Jane Doe', email: 'jane@example.com');

      expect(updated.name, 'Jane Doe');
      expect(updated.email, 'jane@example.com');
      expect(updated.id, '1');
    });
  });
}
