import 'package:flutter/material.dart';
import 'package:vcardsmart/core/utils/locale_utils.dart';

class LanguageSelector extends StatelessWidget {
  final Locale locale;
  final Function(Locale) onChanged;

  const LanguageSelector({
    super.key,
    required this.locale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Idioma'),
      trailing: DropdownButton<Locale>(
        value: locale,
        items: LocaleUtils.supportedLocales.map((loc) {
          return DropdownMenuItem(
            value: loc,
            child: Text(LocaleUtils.getLanguageName(loc)),
          );
        }).toList(),
        onChanged: (newLocale) {
          if (newLocale != null) {
            onChanged(newLocale);
          }
        },
      ),
    );
  }
}
