import '../../data/datasources/profile_photo_datasource.dart';

class DeletePhotoUseCase {
  final ProfilePhotoDataSource _dataSource;

  DeletePhotoUseCase(this._dataSource);

  Future<void> call(String path) async {
    await _dataSource.deletePhoto(path);
  }
}
