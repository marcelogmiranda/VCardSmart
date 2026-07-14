import '../../../profile/domain/entities/profile.dart';
import '../repositories/nfc_repository.dart';

class ReceiveNFCUseCase {
  final NFCRepository repository;

  ReceiveNFCUseCase(this.repository);

  Future<Profile> call() {
    return repository.receive();
  }
}
