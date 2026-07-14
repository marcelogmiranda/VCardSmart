import '../../../profile/domain/entities/profile.dart';

abstract class NFCRepository {
  Future<bool> isAvailable();
  Future<void> send(Profile profile);
  Future<Profile> receive();
  Future<void> cancel();
}
