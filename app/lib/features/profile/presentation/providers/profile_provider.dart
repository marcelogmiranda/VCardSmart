import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/get_all_profiles_usecase.dart';
import '../../domain/usecases/create_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/delete_profile_usecase.dart';
import '../../data/repositories/local_profile_repository.dart';
import '../../data/datasources/profile_local_datasource.dart';

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  throw UnimplementedError('Override in main.dart with Hive box');
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.read(profileDataSourceProvider);
  return LocalProfileRepository(dataSource);
});

final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  return GetProfileUseCase(ref.read(profileRepositoryProvider));
});

final getAllProfilesUseCaseProvider = Provider<GetAllProfilesUseCase>((ref) {
  return GetAllProfilesUseCase(ref.read(profileRepositoryProvider));
});

final createProfileUseCaseProvider = Provider<CreateProfileUseCase>((ref) {
  return CreateProfileUseCase(ref.read(profileRepositoryProvider));
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.read(profileRepositoryProvider));
});

final deleteProfileUseCaseProvider = Provider<DeleteProfileUseCase>((ref) {
  return DeleteProfileUseCase(ref.read(profileRepositoryProvider));
});

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>((ref) {
  return ProfileNotifier(ref);
});

final profileListProvider =
    StateNotifierProvider<ProfileListNotifier, AsyncValue<List<Profile>>>(
        (ref) {
  return ProfileListNotifier(ref);
});

class ProfileNotifier extends StateNotifier<AsyncValue<Profile?>> {
  final Ref ref;

  ProfileNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> loadProfile(String id) async {
    state = const AsyncValue.loading();
    try {
      final profile = await ref.read(getProfileUseCaseProvider).call(id);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createProfile(Profile profile) async {
    try {
      await ref.read(createProfileUseCaseProvider).call(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await ref.read(updateProfileUseCaseProvider).call(profile);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProfile(String id) async {
    try {
      await ref.read(deleteProfileUseCaseProvider).call(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class ProfileListNotifier extends StateNotifier<AsyncValue<List<Profile>>> {
  final Ref ref;

  ProfileListNotifier(this.ref) : super(const AsyncValue.data([]));

  Future<void> loadProfiles() async {
    state = const AsyncValue.loading();
    try {
      final profiles = await ref.read(getAllProfilesUseCaseProvider).call();
      state = AsyncValue.data(profiles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
