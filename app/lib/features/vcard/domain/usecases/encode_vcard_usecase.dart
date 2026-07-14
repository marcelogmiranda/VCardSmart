import '../entities/vcard_data.dart';
import '../repositories/vcard_repository.dart';

class EncodeVCardUseCase {
  final VCardRepository repository;

  EncodeVCardUseCase(this.repository);

  Future<String> call(VCardData data) {
    return repository.encode(data);
  }
}
