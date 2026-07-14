import 'dart:io';

abstract class ProfilePhotoDataSource {
  Future<String> savePhoto(File photo, String profileId);
  Future<void> deletePhoto(String path);
  Future<String?> getPhotoPath(String profileId);
}

class LocalProfilePhotoDataSource implements ProfilePhotoDataSource {
  final Directory _photosDirectory;

  LocalProfilePhotoDataSource(this._photosDirectory);

  @override
  Future<String> savePhoto(File photo, String profileId) async {
    final fileName = '${profileId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final targetPath = '${_photosDirectory.path}/$fileName';
    final savedFile = await photo.copy(targetPath);
    return savedFile.path;
  }

  @override
  Future<void> deletePhoto(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<String?> getPhotoPath(String profileId) async {
    final files = _photosDirectory.listSync();
    for (final file in files) {
      if (file.path.contains(profileId) && file is File) {
        return file.path;
      }
    }
    return null;
  }
}
