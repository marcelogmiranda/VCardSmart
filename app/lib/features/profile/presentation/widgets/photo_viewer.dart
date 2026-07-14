import 'dart:io';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.grey[300],
        backgroundImage: photoPath != null
            ? FileImage(File(photoPath!))
            : null,
        child: photoPath == null
            ? const Icon(Icons.person, size: 50, color: Colors.grey)
            : null,
      ),
    );
  }
}
