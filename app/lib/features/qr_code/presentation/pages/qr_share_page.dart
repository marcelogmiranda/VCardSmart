import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/qr_provider.dart';
import '../widgets/qr_code_widget.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class QRSharePage extends ConsumerStatefulWidget {
  const QRSharePage({super.key});

  @override
  ConsumerState<QRSharePage> createState() => _QRSharePageState();
}

class _QRSharePageState extends ConsumerState<QRSharePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfileAndGenerate();
    });
  }

  Future<void> _loadProfileAndGenerate() async {
    final profiles =
        await ref.read(getAllProfilesUseCaseProvider).call();
    if (profiles.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie seu perfil primeiro para gerar QR Code'),
          ),
        );
        Navigator.of(context).pop();
      }
      return;
    }
    final profile = profiles.first;
    await ref.read(qrProvider.notifier).generateQR(profile);
  }

  @override
  Widget build(BuildContext context) {
    final qrState = ref.watch(qrProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Escaneie para adicionar contato',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              qrState.qrData != null
                  ? QRCodeWidget(data: qrState.qrData!)
                  : const SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    ),
              const SizedBox(height: 24),
              if (qrState.qrData != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: qrState.qrData!),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dados copiados!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copiar'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () {
                        Share.share(
                          qrState.qrData!,
                          subject: 'Meu cartao VCardSmart',
                        );
                      },
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text('Enviar'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
