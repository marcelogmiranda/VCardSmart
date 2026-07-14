import '../../domain/repositories/nfc_repository.dart';
import '../datasources/nfc_datasource.dart';
import '../models/nfc_payload.dart';
import '../../../profile/domain/entities/profile.dart';

class LocalNFCRepository implements NFCRepository {
  final NFCDataSource _dataSource;

  LocalNFCRepository(this._dataSource);

  @override
  Future<bool> isAvailable() async {
    return _dataSource.checkAvailability();
  }

  @override
  Future<void> send(Profile profile) async {
    final nfcData = NFCPayload.encodeToNFC(profile);
    await _dataSource.sendData(nfcData);
  }

  @override
  Future<Profile> receive() async {
    final nfcData = await _dataSource.receiveData();
    return NFCPayload.decodeProfile(nfcData.payload);
  }

  @override
  Future<void> cancel() async {
    await _dataSource.stopSession();
  }
}
