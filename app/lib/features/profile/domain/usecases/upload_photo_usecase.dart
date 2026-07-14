import 'dart:io';
import '../../data/datasources/profile_photo_datasource.dart';
import '../../../../core/utils/image_utils.dart';

class UploadPhotoUseCase {
  final ProfilePhotoDataSource _dataSource;

  UploadPhotoUseCase(this._dataSource);

  Future<String> call(File image, String profileId) async {
    final compressed = await ImageUtils.compressImage(image);
    final path = await _dataSource.savePhoto(compressed, profileId);
    return path;
  }
}
