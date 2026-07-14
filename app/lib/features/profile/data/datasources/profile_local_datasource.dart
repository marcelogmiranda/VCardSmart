import '../../domain/entities/profile.dart';

abstract class ProfileDataSource {
  Future<Profile?> getProfile(String id);
  Future<List<Profile>> getAllProfiles();
  Future<void> saveProfile(Profile profile);
  Future<void> deleteProfile(String id);
}
