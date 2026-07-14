import 'dart:io';
import 'package:flutter/material.dart';

class PhotoCrop extends StatefulWidget {
  final File imageFile;
  final Function(File) onCropped;

  const PhotoCrop({
    super.key,
    required this.imageFile,
    required this.onCropped,
  });

  @override
  State<PhotoCrop> createState() => _PhotoCropState();
}

class _PhotoCropState extends State<PhotoCrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recortar Foto'),
        actions: [
          TextButton(
            onPressed: () => widget.onCropped(widget.imageFile),
            child: const Text('Usar'),
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          widget.imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
