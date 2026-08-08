import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/security/biometric_service.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../../../shared/widgets/app_button.dart';

class SecuritySetupPage extends ConsumerStatefulWidget {
  const SecuritySetupPage({super.key});

  @override
  ConsumerState<SecuritySetupPage> createState() => _SecuritySetupPageState();
}

class _SecuritySetupPageState extends ConsumerState<SecuritySetupPage> {
  bool _biometricAvailable = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBiometrics();
  }

  Future<void> _loadBiometrics() async {
    final available = await BiometricService.isAvailable();
    if (mounted) {
      setState(() {
        _biometricAvailable = available;
        _loading = false;
      });
    }
  }

  Future<void> _finishSetup({
    bool enableBiometric = false,
    bool enablePin = false,
    int? pinLength,
  }) async {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    if (enableBiometric) {
      await settingsNotifier.updateBiometric(true);
    }
    if (enablePin) {
      await settingsNotifier.updatePin(true);
      if (pinLength != null) {
        await settingsNotifier.updatePinLength(pinLength);
      }
    }
    await settingsNotifier.markSecurityAsked();
    if (mounted) {
      context.go(AppConstants.homeRoute);
    }
  }

  Future<void> _setupPinOnly() async {
    final configured = await context.push<bool>(AppConstants.pinSetupRoute);
    if (configured == true && mounted) {
      final settings = ref.read(settingsProvider);
      await _finishSetup(enablePin: true, pinLength: settings.pinLength);
    }
  }

  Future<void> _setupBiometric() async {
    await _finishSetup(enableBiometric: true);
  }

  Future<void> _setupBoth() async {
    final configured = await context.push<bool>(AppConstants.pinSetupRoute);
    if (configured == true && mounted) {
      final settings = ref.read(settingsProvider);
      await _finishSetup(
        enableBiometric: true,
        enablePin: true,
        pinLength: settings.pinLength,
      );
    }
  }

  Future<void> _skip() async {
    await _finishSetup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: _loading
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.security,
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
                          'Proteja seu app para começar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Escolha como deseja proteger o acesso aos seus cartões.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        if (_biometricAvailable) ...[
                          AppButton(
                            label: 'Usar biometria + PIN',
                            icon: Icons.fingerprint,
                            onPressed: _setupBoth,
                          ),
                          const SizedBox(height: 12),
                          AppButton(
                            label: 'Usar biometria',
                            icon: Icons.fingerprint,
                            type: ButtonType.secondary,
                            onPressed: _setupBiometric,
                          ),
                          const SizedBox(height: 12),
                        ],
                        AppButton(
                          label: 'Definir um PIN',
                          icon: Icons.pin,
                          type: ButtonType.secondary,
                          onPressed: _setupPinOnly,
                        ),
                        const SizedBox(height: 12),
                        AppButton(
                          label: 'Agora não',
                          type: ButtonType.text,
                          onPressed: _skip,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
