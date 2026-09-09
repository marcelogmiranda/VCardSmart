import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nfc_provider.dart';
import '../widgets/nfc_status_widget.dart';
import '../widgets/nfc_instruction_widget.dart';
import '../../../contacts/presentation/providers/contact_provider.dart';
import '../../../profile/domain/entities/profile.dart';

class NFCReceivePage extends ConsumerStatefulWidget {
  const NFCReceivePage({super.key});

  @override
  ConsumerState<NFCReceivePage> createState() => _NFCReceivePageState();
}

class _NFCReceivePageState extends ConsumerState<NFCReceivePage> {
  bool? _nfcAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNFC();
    });
  }

  Future<void> _showProfileReceived(Profile profile) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Perfil Recebido'),
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
                  .saveProfileAsContact(profile, 'nfc');
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
              ref.read(nfcProvider.notifier).reset();
            },
            icon: const Icon(Icons.person_add, size: 18),
            label: const Text('Salvar contato'),
          ),
        ],
      ),
    );
    ref.read(nfcProvider.notifier).reset();
  }

  Future<void> _checkNFC() async {
    await ref.read(nfcProvider.notifier).checkAvailability();
    if (mounted) {
      setState(() => _nfcAvailable = ref.read(nfcProvider).isAvailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nfcStatus = ref.watch(nfcProvider);
    final theme = Theme.of(context);

    ref.listen<NFCStatus>(nfcProvider, (previous, next) {
      if (next.state == NFCState.success && next.profile != null) {
        _showProfileReceived(next.profile!);
      } else if (next.state == NFCState.error) {
        final error = next.error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (error != null && error.isNotEmpty)
                  ? error
                  : 'Não foi possível receber via NFC',
            ),
          ),
        );
      }
    });

    if (_nfcAvailable == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Receber via NFC')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_nfcAvailable == false) {
      return Scaffold(
        appBar: AppBar(title: const Text('Receber via NFC')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.nfc,
                  size: 80,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'NFC não disponível',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Este dispositivo não possui NFC ou está desativado.\nAtive o NFC nas configurações do dispositivo.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Receber via NFC'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NFCStatusWidget(isAvailable: nfcStatus.isAvailable),
              const SizedBox(height: 16),
              Text(
                'No iPhone, encoste o cartão na parte de trás, próximo à câmera, '
                'e mantenha até concluir.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 32),
              NFCInstructionWidget(state: nfcStatus.state),
              const SizedBox(height: 32),
              if (nfcStatus.state == NFCState.idle)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(nfcProvider.notifier).receive();
                    },
                    icon: const Icon(Icons.nfc),
                    label: const Text('Iniciar recebimento'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              if (nfcStatus.state == NFCState.success ||
                  nfcStatus.state == NFCState.error)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref.read(nfcProvider.notifier).reset();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
