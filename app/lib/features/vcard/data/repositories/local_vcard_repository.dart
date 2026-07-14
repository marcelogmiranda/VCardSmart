import '../datasources/vcard_datasource.dart';
import '../../domain/entities/vcard_data.dart';
import '../../domain/repositories/vcard_repository.dart';

class LocalVCardRepository implements VCardRepository {
  final VCardDataSource _dataSource;

  LocalVCardRepository(this._dataSource);

  @override
  Future<String> encode(VCardData data) async {
    return _dataSource.encode(data);
  }

  @override
  Future<VCardData> decode(String vcard) async {
    return _dataSource.decode(vcard);
  }

  @override
  Future<void> exportToFile(VCardData data, String path) async {
    return _dataSource.exportToFile(data, path);
  }

  @override
  Future<VCardData> importFromFile(String path) async {
    return _dataSource.importFromFile(path);
  }
}
