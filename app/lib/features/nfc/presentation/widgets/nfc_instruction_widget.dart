import 'package:flutter/material.dart';
import '../providers/nfc_provider.dart';

class NFCInstructionWidget extends StatelessWidget {
  final NFCState state;

  const NFCInstructionWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getIcon(state),
          size: 100,
          color: _getColor(state),
        ),
        const SizedBox(height: 16),
        Text(
          _getText(state),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  IconData _getIcon(NFCState state) {
    switch (state) {
      case NFCState.idle:
      case NFCState.ready:
        return Icons.nfc;
      case NFCState.sending:
      case NFCState.receiving:
        return Icons.sync;
      case NFCState.success:
        return Icons.check_circle;
      case NFCState.error:
        return Icons.error;
    }
  }

  Color _getColor(NFCState state) {
    switch (state) {
      case NFCState.idle:
      case NFCState.ready:
        return Colors.blue;
      case NFCState.sending:
      case NFCState.receiving:
        return Colors.orange;
      case NFCState.success:
        return Colors.green;
      case NFCState.error:
        return Colors.red;
    }
  }

  String _getText(NFCState state) {
    switch (state) {
      case NFCState.idle:
        return 'Toque para iniciar';
      case NFCState.ready:
        return 'Aproxime os dispositivos';
      case NFCState.sending:
        return 'Enviando perfil...';
      case NFCState.receiving:
        return 'Recebendo perfil...';
      case NFCState.success:
        return 'Transferência concluída!';
      case NFCState.error:
        return 'Erro ao comunicar via NFC';
    }
  }
}
