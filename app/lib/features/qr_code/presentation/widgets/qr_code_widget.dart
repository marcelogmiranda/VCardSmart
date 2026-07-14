import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const QRCodeWidget({
    super.key,
    required this.data,
    this.size = 200,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = foregroundColor ?? Colors.black;
    return QrImageView(
      data: data,
      size: size,
      backgroundColor: backgroundColor ?? Colors.white,
      eyeStyle: QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: color,
      ),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: color,
      ),
    );
  }
}
