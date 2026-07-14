import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class BiometricButton extends ConsumerWidget {
  const BiometricButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {
          ref.read(authProvider.notifier).authenticate();
        },
        icon: const Icon(Icons.fingerprint, size: 28),
        label: const Text(
          'Autenticar com Biometria',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
