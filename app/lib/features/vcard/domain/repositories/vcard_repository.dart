import '../entities/vcard_data.dart';

abstract class VCardRepository {
  Future<String> encode(VCardData data);
  Future<VCardData> decode(String vcard);
  Future<void> exportToFile(VCardData data, String path);
  Future<VCardData> importFromFile(String path);
}
