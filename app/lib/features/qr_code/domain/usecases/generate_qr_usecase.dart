import '../../../profile/domain/entities/profile.dart';
import '../repositories/qr_repository.dart';

class GenerateQRUseCase {
  final QRRepository repository;

  GenerateQRUseCase(this.repository);

  Future<String> call(Profile profile) {
    return repository.generateQR(profile);
  }
}
