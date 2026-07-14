import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/domain/usecases/upload_photo_usecase.dart';
import 'package:vcardsmart/features/profile/domain/usecases/delete_photo_usecase.dart';
import 'package:vcardsmart/features/profile/data/datasources/profile_photo_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _FakePhotoDataSource dataSource;

  setUp(() {
    dataSource = _FakePhotoDataSource();
  });

  group('UploadPhotoUseCase', () {
    test('should instantiate with datasource', () async {
      final useCase = UploadPhotoUseCase(dataSource);
      expect(useCase, isNotNull);
    });
  });

  group('DeletePhotoUseCase', () {
    test('should delete photo', () async {
      dataSource.savedPaths['/test/photo.jpg'] = true;
      final useCase = DeletePhotoUseCase(dataSource);
      await useCase('/test/photo.jpg');
      expect(dataSource.deletedPaths, contains('/test/photo.jpg'));
    });

    test('should handle non-existent path', () async {
      final useCase = DeletePhotoUseCase(dataSource);
      await useCase('/nonexistent/path.jpg');
      expect(dataSource.deletedPaths, contains('/nonexistent/path.jpg'));
    });
  });
}

class _FakePhotoDataSource implements ProfilePhotoDataSource {
  final Map<String, bool> savedPaths = {};
  final List<String> deletedPaths = [];

  @override
  Future<String> savePhoto(dynamic photo, String profileId) async {
    final path = '/fake/$profileId/photo.jpg';
    savedPaths[path] = true;
    return path;
  }

  @override
  Future<void> deletePhoto(String path) async {
    deletedPaths.add(path);
  }

  @override
  Future<String?> getPhotoPath(String profileId) async {
    return savedPaths.keys.firstWhere(
      (path) => path.contains(profileId),
      orElse: () => '',
    );
  }
}
