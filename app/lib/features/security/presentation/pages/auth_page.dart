import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/biometric_button.dart';
import '../widgets/pin_input.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: authStatus.state == AuthState.checking
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'VCardSmart',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Autentique-se para continuar',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 48),
                      if (authStatus.biometricAvailable) ...[
                        const BiometricButton(),
                        const SizedBox(height: 16),
                      ],
                      if (authStatus.hasPin) ...[
                        PinInput(
                          length: authStatus.pinLength,
                          onCompleted: (pin) {
                            ref.read(authProvider.notifier).verifyPin(pin);
                          },
                        ),
                      ],
                      if (!authStatus.biometricAvailable &&
                          !authStatus.hasPin) ...[
                        const Text(
                          'Nenhuma autenticação configurada',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                      if (authStatus.state == AuthState.error &&
                          authStatus.error != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          authStatus.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
