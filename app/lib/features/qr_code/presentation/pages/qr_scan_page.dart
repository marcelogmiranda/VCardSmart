import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qr_provider.dart';
import '../widgets/qr_scanner_widget.dart';
import '../../../contacts/presentation/providers/contact_provider.dart';
import '../../../profile/domain/entities/profile.dart';

class QRScanPage extends ConsumerStatefulWidget {
  const QRScanPage({super.key});

  @override
  ConsumerState<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends ConsumerState<QRScanPage> {
  bool _showScanner = false;

  Future<void> _showProfileFound(Profile profile) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Perfil Encontrado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (profile.email != null) ...[
              const SizedBox(height: 8),
              Text(profile.email!),
            ],
            if (profile.phone != null) ...[
              const SizedBox(height: 4),
              Text(profile.phone!),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Fechar'),
          ),
          FilledButton.icon(
            onPressed: () async {
              final saved = await ref
                  .read(contactListProvider.notifier)
                  .saveProfileAsContact(profile, 'qr');
              if (!dialogContext.mounted || !mounted) return;
              Navigator.of(dialogContext).pop();
              if (saved) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contato salvo!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível salvar o contato'),
                  ),
                );
              }
              ref.read(qrProvider.notifier).reset();
            },
            icon: const Icon(Icons.person_add, size: 18),
            label: const Text('Salvar contato'),
          ),
        ],
      ),
    );
    ref.read(qrProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen<QRState>(qrProvider, (previous, next) {
      if (next.scannedProfile != null) {
        _showProfileFound(next.scannedProfile!);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível ler este QR Code'),
          ),
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
                      'Aponte a câmera para o QR Code de um contato',
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
                      label: const Text('Abrir Câmera'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
