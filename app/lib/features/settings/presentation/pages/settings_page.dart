import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';
import 'package:vcardsmart/core/constants/app_constants.dart';
import 'package:vcardsmart/core/security/biometric_service.dart';
import 'package:vcardsmart/features/security/domain/usecases/set_pin_usecase.dart';
import '../providers/settings_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/language_selector.dart';
import '../widgets/security_settings.dart';
import '../widgets/privacy_settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        children: [
          _SectionHeader(title: l10n.appearanceSection),
          ThemeToggle(
            themeMode: settings.themeMode,
            onChanged: (mode) {
              ref.read(settingsProvider.notifier).updateTheme(mode);
            },
          ),
          LanguageSelector(
            locale: settings.locale,
            onChanged: (locale) {
              ref.read(settingsProvider.notifier).updateLocale(locale);
            },
          ),
          const Divider(),
          _SectionHeader(title: l10n.securitySection),
          SecuritySettings(
            biometricEnabled: settings.biometricEnabled,
            pinEnabled: settings.pinEnabled,
            onBiometricChanged: (enabled) {
              _onBiometricChanged(context, ref, enabled);
            },
            onPinChanged: (enabled) {
              _onPinChanged(context, ref, enabled);
            },
          ),
          const Divider(),
          _SectionHeader(title: l10n.privacySection),
          PrivacySettings(
            adsEnabled: settings.adsEnabled,
            onAdsChanged: (enabled) {
              ref.read(settingsProvider.notifier).updateAds(enabled);
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'Sobre'),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Como Funciona'),
            subtitle: const Text('Passos para usar o app'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showHowItWorks(context),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Versão'),
            subtitle: Text(AppConstants.appVersion),
          ),
        ],
      ),
    );
  }

  Future<void> _onBiometricChanged(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    if (enabled) {
      final available = await BiometricService.isAvailable();
      if (!available) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometria não disponível neste aparelho'),
            ),
          );
        }
        return;
      }
    }
    ref.read(settingsProvider.notifier).updateBiometric(enabled);
  }

  Future<void> _onPinChanged(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    if (enabled) {
      final result =
          await context.push<bool>(AppConstants.pinSetupRoute) ?? false;
      if (result) {
        ref.read(settingsProvider.notifier).updatePin(true);
      }
    } else {
      await SetPinUseCase().removePin();
      ref.read(settingsProvider.notifier).updatePin(false);
    }
  }

  void _showHowItWorks(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Como Funciona'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepRow(
              step: '1',
              title: 'Crie seu perfil',
              description: 'Adicione seus dados de contato',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 16),
            _StepRow(
              step: '2',
              title: 'Gere seu QR Code',
              description: 'Gere um QR Code com seu cartao',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 16),
            _StepRow(
              step: '3',
              title: 'Compartilhe',
              description: 'Escaneie ou envie por mensagem',
              colorScheme: colorScheme,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String step;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  const _StepRow({
    required this.step,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            step,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
