import '../../../profile/domain/entities/profile.dart';
import 'profile_vcard_converter.dart';

/// A single piece of contact data that can be written to a small NFC tag when
/// the full vCard does not fit: the profile name plus exactly one field.
class NfcWriteOption {
  final ProfileField field;
  final String title;
  final String? detail;
  final String vCard;

  const NfcWriteOption({
    required this.field,
    required this.title,
    this.detail,
    required this.vCard,
  });
}

/// Presents [options] to the user and returns the chosen one, or null when the
/// user cancels. Used by the NFC send flow when the tag cannot hold the whole
/// profile.
typedef NfcContentSelector = Future<NfcWriteOption?> Function(
    List<NfcWriteOption> options);

const _labels = {
  ProfileField.phone: 'Telefone',
  ProfileField.email: 'E-mail',
  ProfileField.website: 'Site',
  ProfileField.linkedin: 'LinkedIn',
  ProfileField.instagram: 'Instagram',
  ProfileField.facebook: 'Facebook',
  ProfileField.x: 'X (Twitter)',
  ProfileField.social: 'Outra rede social',
  ProfileField.bio: 'Bio',
};

/// Builds one write option per populated profile field, in the order they
/// appear in the form. Fields the user left empty are omitted.
List<NfcWriteOption> buildNfcWriteOptions(Profile profile) {
  final options = <NfcWriteOption>[];
  for (final field in ProfileField.values) {
    final value = ProfileVCardConverter.fieldValue(profile, field);
    if (value == null || value.trim().isEmpty) continue;
    options.add(NfcWriteOption(
      field: field,
      title: _labels[field]!,
      detail: value.trim(),
      vCard: ProfileVCardConverter.encodeFieldVCard(profile, field),
    ));
  }
  return options;
}
