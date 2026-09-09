import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

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
          color: isAvailable ? AppColors.success : AppColors.error,
        ),
        const SizedBox(width: 8),
        Text(
          isAvailable ? 'NFC disponível' : 'NFC indisponível',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
