import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nfc_provider.dart';
import '../widgets/nfc_status_widget.dart';
import '../widgets/nfc_instruction_widget.dart';

class NFCReceivePage extends ConsumerWidget {
  const NFCReceivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nfcStatus = ref.watch(nfcProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receber via NFC'),
        centerTitle: true,
      ),
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
          ],
        ),
      ),
    );
  }
}
