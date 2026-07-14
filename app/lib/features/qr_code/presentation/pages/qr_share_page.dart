import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qr_provider.dart';
import '../widgets/qr_code_widget.dart';
import '../../../profile/domain/entities/profile.dart';

class QRSharePage extends ConsumerWidget {
  final Profile profile;

  const QRSharePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrState = ref.watch(qrProvider);

    ref.listen<QRState>(qrProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    if (qrState.qrData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(qrProvider.notifier).generateQR(profile);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartilhar QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            if (profile.email != null)
              Text(
                profile.email!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 32),
            qrState.qrData != null
                ? QRCodeWidget(data: qrState.qrData!)
                : const CircularProgressIndicator(),
            const SizedBox(height: 32),
            const Text(
              'Escaneie o QR Code para adicionar contato',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
