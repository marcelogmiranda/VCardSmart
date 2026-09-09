import '../../domain/repositories/nfc_repository.dart';
import '../../domain/entities/nfc_data.dart';
import '../datasources/nfc_datasource.dart';
import '../models/nfc_payload.dart';
import '../models/profile_vcard_converter.dart';
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
    final vcard = ProfileVCardConverter.encodeProfile(profile);
    final nfcData = NFCData(
      type: 'profile',
      payload: vcard,
      timestamp: DateTime.now(),
    );
    await _dataSource.sendData(nfcData);
  }

  @override
  Future<Profile> receive() async {
    final nfcData = await _dataSource.receiveData();
    final payload = nfcData.payload;
    // Support both the new standard vCard format and the legacy JSON format
    // written by older VCardSmart builds.
    if (ProfileVCardConverter.isVCardPayload(payload)) {
      return ProfileVCardConverter.decodeVCard(payload);
    }
    return NFCPayload.decodeProfile(payload);
  }

  @override
  Future<void> cancel() async {
    await _dataSource.stopSession();
  }
}
