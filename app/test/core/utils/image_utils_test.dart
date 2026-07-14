import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/utils/image_utils.dart';
import 'package:vcardsmart/core/utils/crop_utils.dart';

void main() {
  late Directory tempDir;
  late File testFile;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('image_utils_test');
    testFile = File('${tempDir.path}/test.jpg');
    await testFile.writeAsBytes([1, 2, 3, 4, 5]);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('ImageUtils', () {
    test('getBase64 should return base64 string', () async {
      final result = await ImageUtils.getBase64(testFile);
      expect(result, isNotEmpty);
      expect(result, isA<String>());
    });

    test('deletePhoto should delete existing file', () async {
      await ImageUtils.deletePhoto(testFile.path);
      expect(await testFile.exists(), isFalse);
    });

    test('deletePhoto should handle non-existent file', () async {
      await ImageUtils.deletePhoto('${tempDir.path}/nonexistent.jpg');
    });
  });

  group('CropUtils', () {
    test('cropToSquare should return file', () async {
      final result = await CropUtils.cropToSquare(testFile);
      expect(result, isA<File>());
    });

    test('cropToCircle should return file', () async {
      final result = await CropUtils.cropToCircle(testFile);
      expect(result, isA<File>());
    });
  });
}
