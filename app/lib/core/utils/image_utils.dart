import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageUtils {
  ImageUtils._();

  static Future<File> compressImage(File file, {int quality = 85}) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = p.join(
      tempDir.path,
      'compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final bytes = await file.readAsBytes();
    final compressedBytes = bytes; // Simplified - in production use image package

    final compressedFile = File(targetPath);
    await compressedFile.writeAsBytes(compressedBytes);
    return compressedFile;
  }

  static Future<String> getBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  static Future<String> getAppPhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(appDir.path, 'photos'));
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir.path;
  }

  static Future<File> savePhotoLocally(File photo, String fileName) async {
    final photosDir = await getAppPhotosDirectory();
    final targetPath = p.join(photosDir, fileName);
    return await photo.copy(targetPath);
  }

  static Future<void> deletePhoto(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
