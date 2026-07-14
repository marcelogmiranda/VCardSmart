import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/l10n/app_localizations.dart';
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
              ref.read(settingsProvider.notifier).updateBiometric(enabled);
            },
            onPinChanged: (enabled) {
              ref.read(settingsProvider.notifier).updatePin(enabled);
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
