import '../../../profile/domain/entities/profile.dart';
import '../../data/models/nfc_write_option.dart';

abstract class NFCRepository {
  Future<bool> isAvailable();
  Future<void> send(Profile profile, {NfcContentSelector? contentSelector});
  Future<Profile> receive();
  Future<void> cancel();
}
