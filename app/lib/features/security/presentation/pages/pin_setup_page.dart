import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../providers/auth_provider.dart';
import '../security_setup_completion.dart';
import '../widgets/pin_input.dart';

class PinSetupOnboardingFlow {
  const PinSetupOnboardingFlow({this.enableBiometric = false});

  final bool enableBiometric;
}

class PinSetupPage extends ConsumerStatefulWidget {
  const PinSetupPage({
    super.key,
    this.completeOnboarding = false,
    this.enableBiometric = false,
  });

  final bool completeOnboarding;
  final bool enableBiometric;

  @override
  ConsumerState<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends ConsumerState<PinSetupPage> {
  bool _isConfirming = false;
  String _firstPin = '';
  late int _length;

  @override
  void initState() {
    super.initState();
    _length = ref.read(settingsProvider).pinLength;
  }

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
                    : 'PIN com $_length dígitos',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              if (!_isConfirming) _buildLengthSelector(),
              const SizedBox(height: 32),
              PinInput(
                key: ValueKey('$_isConfirming-$_length'),
                length: _length,
                onCompleted: _isConfirming ? _confirmPin : _firstPinEntered,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLengthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tamanho: ',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        for (final size in [4, 6])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text('$size'),
              selected: _length == size,
              onSelected: (_) {
                setState(() {
                  _length = size;
                  _firstPin = '';
                  _isConfirming = false;
                });
              },
            ),
          ),
      ],
    );
  }

  void _firstPinEntered(String pin) {
    setState(() {
      _firstPin = pin;
      _isConfirming = true;
    });
  }

  Future<void> _confirmPin(String pin) async {
    if (pin == _firstPin) {
      await ref.read(authProvider.notifier).setPin(pin, length: _length);
      if (widget.completeOnboarding) {
        if (mounted) {
          await completeSecuritySetup(
            ref,
            context,
            enableBiometric: widget.enableBiometric,
            enablePin: true,
            pinLength: _length,
          );
        }
        return;
      }
      await ref.read(settingsProvider.notifier).updatePinLength(_length);
      await ref.read(settingsProvider.notifier).updatePin(true);
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
