import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<void> call(Profile profile) {
    return _repository.saveProfile(profile);
  }
}
