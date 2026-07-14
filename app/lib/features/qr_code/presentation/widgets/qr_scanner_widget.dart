import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String) onScanned;

  const QRScannerWidget({
    super.key,
    required this.onScanned,
  });

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  MobileScannerController? _controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: _controller,
      onDetect: (capture) {
        if (_isProcessing) return;
        final barcode = capture.barcodes.first;
        if (barcode.rawValue != null) {
          _isProcessing = true;
          widget.onScanned(barcode.rawValue!);
        }
      },
    );
  }
}
