import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';

class LocalProfileRepository implements ProfileRepository {
  final ProfileDataSource _dataSource;

  LocalProfileRepository(this._dataSource);

  @override
  Future<Profile> getProfile(String id) async {
    final profile = await _dataSource.getProfile(id);
    if (profile == null) {
      throw Exception('Profile not found');
    }
    return profile;
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    return await _dataSource.getAllProfiles();
  }

  @override
  Future<void> saveProfile(Profile profile) async {
    await _dataSource.saveProfile(profile);
  }

  @override
  Future<void> deleteProfile(String id) async {
    await _dataSource.deleteProfile(id);
  }
}
