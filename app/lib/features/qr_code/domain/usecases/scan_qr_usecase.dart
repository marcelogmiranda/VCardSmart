import '../../../profile/domain/entities/profile.dart';
import '../repositories/qr_repository.dart';

class ScanQRUseCase {
  final QRRepository repository;

  ScanQRUseCase(this.repository);

  Future<Profile> call(String data) {
    return repository.decodeQR(data);
  }
}
