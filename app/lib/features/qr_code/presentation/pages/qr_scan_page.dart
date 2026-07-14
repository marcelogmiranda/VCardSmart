import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qr_provider.dart';
import '../widgets/qr_scanner_widget.dart';

class QRScanPage extends ConsumerWidget {
  const QRScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<QRState>(qrProvider, (previous, next) {
      if (next.scannedProfile != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Perfil Encontrado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  next.scannedProfile!.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (next.scannedProfile!.email != null) ...[
                  const SizedBox(height: 8),
                  Text(next.scannedProfile!.email!),
                ],
                if (next.scannedProfile!.phone != null) ...[
                  const SizedBox(height: 4),
                  Text(next.scannedProfile!.phone!),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(qrProvider.notifier).reset();
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code'),
        centerTitle: true,
      ),
      body: QRScannerWidget(
        onScanned: (data) {
          ref.read(qrProvider.notifier).scanQR(data);
        },
      ),
    );
  }
}
