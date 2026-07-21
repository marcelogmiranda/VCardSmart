import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qr_provider.dart';
import '../widgets/qr_scanner_widget.dart';

class QRScanPage extends ConsumerStatefulWidget {
  const QRScanPage({super.key});

  @override
  ConsumerState<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends ConsumerState<QRScanPage> {
  bool _showScanner = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      body: _showScanner
          ? Column(
              children: [
                Expanded(
                  child: QRScannerWidget(
                    onScanned: (data) {
                      ref.read(qrProvider.notifier).scanQR(data);
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() => _showScanner = false);
                          ref.read(qrProvider.notifier).reset();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Escanear QR Code',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aponte a camera para o QR Code de um contato',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      onPressed: () {
                        setState(() => _showScanner = true);
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Abrir Camera'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
