import 'package:flutter/material.dart';

class NFCStatusWidget extends StatelessWidget {
  final bool isAvailable;

  const NFCStatusWidget({
    super.key,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isAvailable ? Icons.nfc : Icons.nfc_outlined,
          color: isAvailable ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(isAvailable ? 'NFC disponível' : 'NFC indisponível'),
      ],
    );
  }
}
