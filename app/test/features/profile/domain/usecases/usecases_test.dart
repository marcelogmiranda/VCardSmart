import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/profile/domain/repositories/profile_repository.dart';
import 'package:vcardsmart/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:vcardsmart/features/profile/domain/usecases/get_all_profiles_usecase.dart';
import 'package:vcardsmart/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:vcardsmart/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:vcardsmart/features/profile/domain/usecases/delete_profile_usecase.dart';

void main() {
  late _FakeRepository repository;

  setUp(() {
    repository = _FakeRepository();
  });

  group('GetProfileUseCase', () {
    test('should return profile by id', () async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      repository.profiles['1'] = profile;

      final useCase = GetProfileUseCase(repository);
      final result = await useCase('1');
      expect(result.name, 'John');
    });
  });

  group('GetAllProfilesUseCase', () {
    test('should return all profiles', () async {
      repository.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );
      repository.profiles['2'] = Profile(
        id: '2',
        name: 'Jane',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final useCase = GetAllProfilesUseCase(repository);
      final result = await useCase();
      expect(result.length, 2);
    });
  });

  group('CreateProfileUseCase', () {
    test('should save profile', () async {
      final profile = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final useCase = CreateProfileUseCase(repository);
      await useCase(profile);
      expect(repository.profiles['1']?.name, 'John');
    });
  });

  group('UpdateProfileUseCase', () {
    test('should update profile', () async {
      repository.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final updated = Profile(
        id: '1',
        name: 'Jane',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final useCase = UpdateProfileUseCase(repository);
      await useCase(updated);
      expect(repository.profiles['1']?.name, 'Jane');
    });
  });

  group('DeleteProfileUseCase', () {
    test('should delete profile', () async {
      repository.profiles['1'] = Profile(
        id: '1',
        name: 'John',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      final useCase = DeleteProfileUseCase(repository);
      await useCase('1');
      expect(repository.profiles.containsKey('1'), false);
    });
  });
}

class _FakeRepository implements ProfileRepository {
  final Map<String, Profile> profiles = {};

  @override
  Future<Profile> getProfile(String id) async {
    return profiles[id]!;
  }

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
