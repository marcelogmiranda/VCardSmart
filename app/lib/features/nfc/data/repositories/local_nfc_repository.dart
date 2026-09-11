import '../../domain/repositories/nfc_repository.dart';
import '../../domain/entities/nfc_data.dart';
import '../datasources/nfc_datasource.dart';
import '../models/nfc_payload.dart';
import '../models/nfc_write_option.dart';
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
  Future<void> send(Profile profile,
      {NfcContentSelector? contentSelector}) async {
    final vcard = ProfileVCardConverter.encodeProfile(profile);
    final nfcData = NFCData(
      type: 'profile',
      payload: vcard,
      timestamp: DateTime.now(),
    );
    await _dataSource.sendData(
      nfcData,
      profile: profile,
      contentSelector: contentSelector,
    );
  }

  @override
  Future<Profile> receive() async {
    final nfcData = await _dataSource.receiveData();
    final payload = nfcData.payload;
    // Support the new standard vCard format, the legacy JSON format written by
    // older VCardSmart builds, and arbitrary text/URL tags from other apps.
    if (ProfileVCardConverter.isVCardPayload(payload)) {
      return ProfileVCardConverter.decodeVCard(payload);
    }
    if (payload.trimLeft().startsWith('{')) {
      try {
        return NFCPayload.decodeProfile(payload);
      } catch (_) {
        // Fall through to the raw-text fallback below.
      }
    }
    return ProfileVCardConverter.profileFromText(payload);
  }

  @override
  Future<void> cancel() async {
    await _dataSource.stopSession();
  }
}
