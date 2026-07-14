# Sprint 5 — Photo Module

## Objetivo

Implementar upload e gerenciamento de fotos.

## Pré-requisitos

- Sprint 4 concluída
- Profile Module implementado

## Documentos Obrigatórios

- Architecture.md
- ProfileFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── utils/
│       ├── image_utils.dart
│       └── crop_utils.dart
├── features/
│   └── profile/
│       ├── data/
│       │   └── datasources/
│       │       └── profile_photo_datasource.dart
│       ├── domain/
│       │   └── usecases/
│       │       ├── upload_photo_usecase.dart
│       │       └── delete_photo_usecase.dart
│       └── presentation/
│           └── widgets/
│               ├── photo_picker.dart
│               ├── photo_viewer.dart
│               └── photo_crop.dart
```

### Arquivos Alterados

- lib/features/profile/domain/entities/profile.dart
- lib/features/profile/data/models/profile_model.dart
- lib/features/profile/presentation/pages/profile_page.dart
- lib/features/profile/presentation/pages/profile_edit_page.dart

## Modelos

### image_utils.dart

```dart
class ImageUtils {
  static Future<File> compressImage(File file, {int quality = 85}) async {
    // Compressão de imagem
  }
  
  static Future<File> cropImage(File file) async {
    // Crop de imagem
  }
  
  static Future<String> getBase64(File file) async {
    // Converter para base64
  }
}
```

### upload_photo_usecase.dart

```dart
class UploadPhotoUseCase {
  final ProfilePhotoDataSource dataSource;
  
  UploadPhotoUseCase(this.dataSource);
  
  Future<String> call(File image) async {
    // 1. Comprimir imagem
    final compressed = await ImageUtils.compressImage(image);
    
    // 2. Salvar localmente
    final path = await dataSource.savePhoto(compressed);
    
    // 3. Retornar path
    return path;
  }
}
```

### photo_picker.dart

```dart
class PhotoPicker extends StatelessWidget {
  final Function(File) onPhotoSelected;
  
  const PhotoPicker({
    super.key,
    required this.onPhotoSelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickFromCamera(context),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Câmera'),
        ),
        ElevatedButton.icon(
          onPressed: () => _pickFromGallery(context),
          icon: const Icon(Icons.photo_library),
          label: const Text('Galeria'),
        ),
      ],
    );
  }
  
  Future<void> _pickFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      onPhotoSelected(File(pickedFile.path));
    }
  }
  
  Future<void> _pickFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      onPhotoSelected(File(pickedFile.path));
    }
  }
}
```

### photo_viewer.dart

```dart
class PhotoViewer extends StatelessWidget {
  final String? photoPath;
  final VoidCallback? onTap;
  
  const PhotoViewer({
    super.key,
    this.photoPath,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: photoPath != null
            ? FileImage(File(photoPath!))
            : null,
        child: photoPath == null
            ? const Icon(Icons.person, size: 50)
            : null,
      ),
    );
  }
}
```

## Critérios de Aceitação

- [x] Seleção de foto implementada
- [x] Câmera funcionando
- [x] Galeria funcionando
- [x] Crop implementado
- [x] Compressão implementada
- [x] Salvamento local funcionando
- [x] Exclusão funcionando
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Seleção de foto implementada
- [x] Câmera funcionando
- [x] Galeria funcionando
- [x] Crop implementado
- [x] Compressão implementada
- [x] Salvamento local funcionando
- [x] Exclusão funcionando
- [x] Build funcionando
- [x] Testes passando (99/99)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (86.6%)
- [x] CHANGELOG atualizado (v1.5.0)

## Próxima Sprint

Sprint 6 — QR Code
