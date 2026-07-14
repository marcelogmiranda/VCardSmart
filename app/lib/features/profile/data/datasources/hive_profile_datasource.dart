import 'package:hive/hive.dart';
import '../../domain/entities/profile.dart';
import 'profile_local_datasource.dart';

class HiveProfileDataSource implements ProfileDataSource {
  final Box<Profile> _box;

  HiveProfileDataSource(this._box);

  @override
  Future<Profile?> getProfile(String id) async {
    return _box.get(id);
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    return _box.values.toList();
  }

  @override
  Future<void> saveProfile(Profile profile) async {
    await _box.put(profile.id, profile);
  }

  @override
  Future<void> deleteProfile(String id) async {
    await _box.delete(id);
  }
}
