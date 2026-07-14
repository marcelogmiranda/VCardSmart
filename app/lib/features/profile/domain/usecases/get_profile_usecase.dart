import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Profile> call(String id) {
    return _repository.getProfile(id);
  }
}
