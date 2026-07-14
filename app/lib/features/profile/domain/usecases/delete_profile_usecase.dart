import '../repositories/profile_repository.dart';

class DeleteProfileUseCase {
  final ProfileRepository _repository;

  DeleteProfileUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteProfile(id);
  }
}
