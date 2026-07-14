import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('Profile', () {
    test('should create profile with photoPath', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John',
        photoPath: '/path/to/photo.jpg',
        createdAt: now,
        updatedAt: now,
      );

      expect(profile.photoPath, '/path/to/photo.jpg');
    });

    test('copyWith should update photoPath', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: now,
        updatedAt: now,
      );

      final updated = profile.copyWith(photoPath: '/new/path.jpg');
      expect(updated.photoPath, '/new/path.jpg');
    });

    test('copyWith should keep existing photoPath when not provided', () {
      final now = DateTime.now();
      final profile = Profile(
        id: '1',
        name: 'John',
        photoPath: '/existing/path.jpg',
        createdAt: now,
        updatedAt: now,
      );

      final updated = profile.copyWith(name: 'Jane');
      expect(updated.photoPath, '/existing/path.jpg');
    });
  });
}
