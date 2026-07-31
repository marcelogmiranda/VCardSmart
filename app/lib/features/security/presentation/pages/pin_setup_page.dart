import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/pin_input.dart';

class PinSetupPage extends ConsumerStatefulWidget {
  const PinSetupPage({super.key});

  @override
  ConsumerState<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends ConsumerState<PinSetupPage> {
  bool _isConfirming = false;
  String _firstPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar PIN'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isConfirming ? Icons.pin : Icons.pin_outlined,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                _isConfirming ? 'Confirme o PIN' : 'Digite o PIN',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                _isConfirming
                    ? 'Digite novamente para confirmar'
                    : 'Mínimo 4 dígitos',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              PinInput(
                key: ValueKey(_isConfirming),
                onCompleted: _isConfirming ? _confirmPin : _firstPinEntered,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _firstPinEntered(String pin) {
    setState(() {
      _firstPin = pin;
      _isConfirming = true;
    });
  }

  void _confirmPin(String pin) {
    if (pin == _firstPin) {
      ref.read(authProvider.notifier).setPin(pin);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN configurado com sucesso!')),
        );
        Navigator.of(context).pop(true);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PINs não coincidem')),
      );
      setState(() {
        _isConfirming = false;
        _firstPin = '';
      });
    }
  }
}
