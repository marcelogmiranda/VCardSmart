import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/data/datasources/profile_local_datasource.dart';

void main() {
  group('ProfileDataSource', () {
    late _FakeDataSource dataSource;

    setUp(() {
      dataSource = _FakeDataSource();
    });

    test('getProfile should return profile when exists', () async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      dataSource.profiles['1'] = profile;

      final result = await dataSource.getProfile('1');
      expect(result?.name, 'John');
    });

    test('getProfile should return null when not exists', () async {
      final result = await dataSource.getProfile('999');
      expect(result, isNull);
    });

    test('getAllProfiles should return all profiles', () async {
      dataSource.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      dataSource.profiles['2'] = Profile(
        id: '2',
        name: 'Jane',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final result = await dataSource.getAllProfiles();
      expect(result.length, 2);
    });

    test('saveProfile should store profile', () async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await dataSource.saveProfile(profile);
      expect(dataSource.profiles['1']?.name, 'John');
    });

    test('deleteProfile should remove profile', () async {
      dataSource.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await dataSource.deleteProfile('1');
      expect(dataSource.profiles.containsKey('1'), false);
    });
  });
}

class _FakeDataSource implements ProfileDataSource {
  final Map<String, Profile> profiles = {};

  @override
  Future<Profile?> getProfile(String id) async => profiles[id];

  @override
  Future<List<Profile>> getAllProfiles() async => profiles.values.toList();

  @override
  Future<void> saveProfile(Profile profile) async {
    profiles[profile.id] = profile;
  }

  @override
  Future<void> deleteProfile(String id) async {
    profiles.remove(id);
  }
}
