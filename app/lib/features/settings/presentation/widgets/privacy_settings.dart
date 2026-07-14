import 'package:flutter/material.dart';

class PrivacySettings extends StatelessWidget {
  final bool adsEnabled;
  final Function(bool) onAdsChanged;

  const PrivacySettings({
    super.key,
    required this.adsEnabled,
    required this.onAdsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: const Icon(Icons.ads_click),
      title: const Text('Anúncios'),
      subtitle: const Text('Exibir anúncios relevantes'),
      value: adsEnabled,
      onChanged: onAdsChanged,
    );
  }
}
