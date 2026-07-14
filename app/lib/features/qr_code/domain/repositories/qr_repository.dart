import '../../../profile/domain/entities/profile.dart';
import '../entities/qr_data.dart';

abstract class QRRepository {
  Future<String> generateQR(Profile profile);
  Future<Profile> decodeQR(String data);
  QRData encodeProfile(Profile profile);
}
