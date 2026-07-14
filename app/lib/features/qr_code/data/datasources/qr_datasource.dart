import '../models/qr_payload.dart';
import '../../../profile/domain/entities/profile.dart';

abstract class QRDataSource {
  String generateQRData(Profile profile);
  Profile decodeQRData(String data);
}

class LocalQRDataSource implements QRDataSource {
  @override
  String generateQRData(Profile profile) {
    final qrData = QRPayload.encodeProfile(profile);
    return qrData.payload;
  }

  @override
  Profile decodeQRData(String data) {
    return QRPayload.decodeVCard(data);
  }
}
