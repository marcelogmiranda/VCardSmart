import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/data/datasources/profile_photo_datasource.dart';

void main() {
  late Directory tempDir;
  late LocalProfilePhotoDataSource dataSource;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('photo_ds_test');
    dataSource = LocalProfilePhotoDataSource(tempDir);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('LocalProfilePhotoDataSource', () {
    test('savePhoto should copy file and return path', () async {
      final sourceFile = File('${tempDir.path}/source.jpg');
      await sourceFile.writeAsBytes([1, 2, 3]);

      final path = await dataSource.savePhoto(sourceFile, 'profile1');

      expect(path, isNotEmpty);
      expect(path, contains('profile1'));
      expect(path, endsWith('.jpg'));

      final savedFile = File(path);
      expect(await savedFile.exists(), isTrue);
    });

    test('deletePhoto should remove existing file', () async {
      final file = File('${tempDir.path}/to_delete.jpg');
      await file.writeAsBytes([1, 2, 3]);

      await dataSource.deletePhoto(file.path);

      expect(await file.exists(), isFalse);
    });

    test('deletePhoto should handle non-existent file', () async {
      await dataSource.deletePhoto('${tempDir.path}/nonexistent.jpg');
    });

    test('getPhotoPath should return path when photo exists', () async {
      final sourceFile = File('${tempDir.path}/source.jpg');
      await sourceFile.writeAsBytes([1, 2, 3]);
      await dataSource.savePhoto(sourceFile, 'profile1');

      final path = await dataSource.getPhotoPath('profile1');

      expect(path, isNotNull);
      expect(path, contains('profile1'));
    });

    test('getPhotoPath should return null when no photo exists', () async {
      final path = await dataSource.getPhotoPath('nonexistent');
      expect(path, isNull);
    });
  });
}
