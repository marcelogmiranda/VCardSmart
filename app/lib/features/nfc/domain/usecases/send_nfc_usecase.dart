import '../../../profile/domain/entities/profile.dart';
import '../../data/models/nfc_write_option.dart';
import '../repositories/nfc_repository.dart';

class SendNFCUseCase {
  final NFCRepository repository;

  SendNFCUseCase(this.repository);

  Future<void> call(Profile profile, {NfcContentSelector? contentSelector}) {
    return repository.send(profile, contentSelector: contentSelector);
  }
}
