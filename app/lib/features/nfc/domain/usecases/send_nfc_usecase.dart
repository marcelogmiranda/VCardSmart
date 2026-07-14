import '../../../profile/domain/entities/profile.dart';
import '../repositories/nfc_repository.dart';

class SendNFCUseCase {
  final NFCRepository repository;

  SendNFCUseCase(this.repository);

  Future<void> call(Profile profile) {
    return repository.send(profile);
  }
}
