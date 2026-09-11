import 'package:flutter/material.dart';

import '../../data/models/nfc_write_option.dart';
import '../../data/models/profile_vcard_converter.dart';

/// Presents the list of [options] in a bottom sheet and returns the chosen
/// one, or null when the user dismisses it.
Future<NfcWriteOption?> showNfcWriteOptionSheet(
  BuildContext context,
  List<NfcWriteOption> options,
) {
  return showModalBottomSheet<NfcWriteOption>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'O cartão é pequeno para o perfil completo',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: Text(
                'Escolha o que deseja gravar',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    leading: Icon(
                      _iconFor(option.field),
                      color: theme.colorScheme.primary,
                    ),
                    title: Text(option.title),
                    subtitle: option.detail == null
                        ? null
                        : Text(
                            option.detail!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    onTap: () => Navigator.of(context).pop(option),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

IconData _iconFor(ProfileField field) {
  switch (field) {
    case ProfileField.phone:
      return Icons.phone_outlined;
    case ProfileField.email:
      return Icons.email_outlined;
    case ProfileField.website:
      return Icons.language;
    case ProfileField.linkedin:
      return Icons.work_outline;
    case ProfileField.instagram:
      return Icons.camera_alt_outlined;
    case ProfileField.facebook:
      return Icons.facebook;
    case ProfileField.x:
      return Icons.alternate_email;
    case ProfileField.social:
      return Icons.link;
    case ProfileField.bio:
      return Icons.info_outline;
  }
}
