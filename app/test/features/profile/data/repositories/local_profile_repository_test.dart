import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:vcardsmart/features/profile/data/repositories/local_profile_repository.dart';

void main() {
  group('LocalProfileRepository', () {
    late LocalProfileRepository repository;
    late _FakeDataSource dataSource;

    setUp(() {
      dataSource = _FakeDataSource();
      repository = LocalProfileRepository(dataSource);
    });

    test('getProfile should return profile when found', () async {
      final profile = Profile(
        id: '1',
        name: 'John Doe',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      dataSource.profiles['1'] = profile;

      final result = await repository.getProfile('1');
      expect(result.name, 'John Doe');
    });

    test('getProfile should throw when not found', () async {
      expect(() => repository.getProfile('999'), throwsException);
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

      final result = await repository.getAllProfiles();
      expect(result.length, 2);
    });

    test('saveProfile should save to datasource', () async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await repository.saveProfile(profile);
      expect(dataSource.profiles['1']?.name, 'John');
    });

    test('deleteProfile should remove from datasource', () async {
      dataSource.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await repository.deleteProfile('1');
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
