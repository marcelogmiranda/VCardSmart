import '../entities/vcard_data.dart';
import '../repositories/vcard_repository.dart';

class DecodeVCardUseCase {
  final VCardRepository repository;

  DecodeVCardUseCase(this.repository);

  Future<VCardData> call(String vcard) {
    return repository.decode(vcard);
  }
}
