import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        const SizedBox(height: 8),
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
