import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../providers/nfc_provider.dart';
import '../widgets/nfc_status_widget.dart';
import '../widgets/nfc_instruction_widget.dart';

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
    _checkNFC();
  }

  Future<void> _checkNFC() async {
    final available = await NfcManager.instance.isAvailable();
    if (mounted) {
      setState(() => _nfcAvailable = available);
      if (!available) {
        ref.read(nfcProvider.notifier).setUnavailable();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nfcStatus = ref.watch(nfcProvider);
    final theme = Theme.of(context);

    ref.listen<NFCStatus>(nfcProvider, (previous, next) {
      if (next.state == NFCState.success && next.profile != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Perfil Recebido'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  next.profile!.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (next.profile!.email != null) ...[
                  const SizedBox(height: 8),
                  Text(next.profile!.email!),
                ],
                if (next.profile!.phone != null) ...[
                  const SizedBox(height: 4),
                  Text(next.profile!.phone!),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(nfcProvider.notifier).reset();
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      } else if (next.state == NFCState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Erro desconhecido')),
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
                  'NFC nao disponivel',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Este dispositivo nao possui NFC ou esta desativado.\nAtive o NFC nas configuracoes do dispositivo.',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NFCStatusWidget(isAvailable: nfcStatus.isAvailable),
            const SizedBox(height: 32),
            NFCInstructionWidget(state: nfcStatus.state),
            const SizedBox(height: 32),
            if (nfcStatus.state == NFCState.idle)
              ElevatedButton(
                onPressed: () {
                  ref.read(nfcProvider.notifier).receive();
                },
                child: const Text('Iniciar recebimento'),
              ),
            if (nfcStatus.state != NFCState.idle)
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(nfcProvider.notifier).reset();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar'),
              ),
          ],
        ),
      ),
    );
  }
}
