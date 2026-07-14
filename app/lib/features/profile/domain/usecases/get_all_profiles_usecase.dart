import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetAllProfilesUseCase {
  final ProfileRepository _repository;

  GetAllProfilesUseCase(this._repository);

  Future<List<Profile>> call() {
    return _repository.getAllProfiles();
  }
}
