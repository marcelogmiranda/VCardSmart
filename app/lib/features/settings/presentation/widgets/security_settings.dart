import 'package:flutter/material.dart';

class SecuritySettings extends StatelessWidget {
  final bool biometricEnabled;
  final bool pinEnabled;
  final Function(bool) onBiometricChanged;
  final Function(bool) onPinChanged;

  const SecuritySettings({
    super.key,
    required this.biometricEnabled,
    required this.pinEnabled,
    required this.onBiometricChanged,
    required this.onPinChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.fingerprint),
          title: const Text('Biometria'),
          subtitle: const Text('Autenticar com impressão digital'),
          value: biometricEnabled,
          onChanged: onBiometricChanged,
        ),
        SwitchListTile(
          secondary: const Icon(Icons.pin),
          title: const Text('PIN'),
          subtitle: const Text('Proteger com PIN'),
          value: pinEnabled,
          onChanged: onPinChanged,
        ),
      ],
    );
  }
}
