import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nfc_provider.dart';
import '../widgets/nfc_status_widget.dart';
import '../widgets/nfc_instruction_widget.dart';
import '../../../profile/domain/entities/profile.dart';

class NFCSharePage extends ConsumerWidget {
  final Profile profile;

  const NFCSharePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nfcStatus = ref.watch(nfcProvider);

    ref.listen<NFCStatus>(nfcProvider, (previous, next) {
      if (next.state == NFCState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil enviado com sucesso!')),
        );
      } else if (next.state == NFCState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Erro desconhecido')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartilhar via NFC'),
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
                  ref.read(nfcProvider.notifier).send(profile);
                },
                child: const Text('Iniciar envio'),
              ),
            if (nfcStatus.state == NFCState.success)
              ElevatedButton(
                onPressed: () {
                  ref.read(nfcProvider.notifier).reset();
                },
                child: const Text('Enviar novamente'),
              ),
          ],
        ),
      ),
    );
  }
}
