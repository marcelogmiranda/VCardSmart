import '../../domain/entities/qr_data.dart';
import '../../domain/repositories/qr_repository.dart';
import '../datasources/qr_datasource.dart';
import '../../../profile/domain/entities/profile.dart';

class LocalQRRepository implements QRRepository {
  final QRDataSource _dataSource;

  LocalQRRepository(this._dataSource);

  @override
  Future<String> generateQR(Profile profile) async {
    return _dataSource.generateQRData(profile);
  }

  @override
  Future<Profile> decodeQR(String data) async {
    return _dataSource.decodeQRData(data);
  }

  @override
  QRData encodeProfile(Profile profile) {
    return QRData(
      type: 'vcard',
      payload: _dataSource.generateQRData(profile),
      timestamp: DateTime.now(),
    );
  }
}
