import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class CreateProfileUseCase {
  final ProfileRepository _repository;

  CreateProfileUseCase(this._repository);

  Future<void> call(Profile profile) {
    return _repository.saveProfile(profile);
  }
}
