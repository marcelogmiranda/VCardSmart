import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/biometric_button.dart';
import '../widgets/pin_input.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);
    final theme = Theme.of(context);

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
                        color: theme.colorScheme.primary,
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
                      Text(
                        'Autentique-se para continuar',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
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
                        const SizedBox(height: 8),
                        Text(
                          'Nenhuma autenticação configurada',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () async {
                            await ref
                                .read(settingsProvider.notifier)
                                .unmarkSecurityAsked();
                            await ref.read(authProvider.notifier).checkAuth(
                                  ref.read(settingsProvider),
                                );
                            if (context.mounted) {
                              context.go(AppConstants.homeRoute);
                            }
                          },
                          icon: const Icon(Icons.security),
                          label: const Text('Configurar Segurança'),
                        ),
                      ],
                      if (authStatus.state == AuthState.error &&
                          authStatus.error != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          authStatus.error!,
                          style: TextStyle(color: theme.colorScheme.error),
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
