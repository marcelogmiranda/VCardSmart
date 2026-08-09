import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';
import 'package:vcardsmart/core/database/hive_service.dart';
import 'package:vcardsmart/features/profile/data/datasources/hive_profile_datasource.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  late Box<Profile> box;
  late HiveProfileDataSource dataSource;

  setUpAll(() async {
    Hive.init('__test_profile_hive__');
    HiveAdapters.register();
    box = await Hive.openBox<Profile>(HiveBoxes.profiles);
    dataSource = HiveProfileDataSource(box);
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk(HiveBoxes.profiles);
    await Hive.deleteFromDisk();
  });

  test('should persist and retrieve profile with all social fields',
      () async {
    final profile = Profile(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+55 11 99999-0000',
      linkedin: 'linkedin.com/in/johndoe',
      website: 'https://example.com',
      bio: 'Bio',
      photoPath: '/tmp/photo.jpg',
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
      instagram: '@johndoe',
      facebook: 'facebook.com/johndoe',
      x: 'x.com/johndoe',
      social: 'https://github.com/johndoe',
    );

    await dataSource.saveProfile(profile);

    final loaded = await dataSource.getProfile('1');
    expect(loaded, isNotNull);
    expect(loaded!.name, 'John Doe');
    expect(loaded.email, 'john@example.com');
    expect(loaded.phone, '+55 11 99999-0000');
    expect(loaded.linkedin, 'linkedin.com/in/johndoe');
    expect(loaded.website, 'https://example.com');
    expect(loaded.bio, 'Bio');
    expect(loaded.photoPath, '/tmp/photo.jpg');
    expect(loaded.createdAt, DateTime(2024, 1, 1));
    expect(loaded.updatedAt, DateTime(2024, 1, 2));
    expect(loaded.instagram, '@johndoe');
    expect(loaded.facebook, 'facebook.com/johndoe');
    expect(loaded.x, 'x.com/johndoe');
    expect(loaded.social, 'https://github.com/johndoe');
  });

  test('should retrieve profile with null social fields', () async {
    final profile = Profile(
      id: '2',
      name: 'Jane',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    );

    await dataSource.saveProfile(profile);

    final loaded = await dataSource.getProfile('2');
    expect(loaded!.name, 'Jane');
    expect(loaded.facebook, isNull);
    expect(loaded.x, isNull);
    expect(loaded.social, isNull);
    expect(loaded.instagram, isNull);
  });
}
