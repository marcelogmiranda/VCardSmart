import '../../../profile/domain/entities/profile.dart';

/// Converts between [Profile] and standard vCard 3.0 text so a profile can be
/// written to an NFC tag in a format natively readable by any phone's Contacts
/// app (not just VCardSmart users), and read back into a [Profile].
class ProfileVCardConverter {
  ProfileVCardConverter._();

  static const String mimeType = 'text/vcard';

  /// Encodes a [Profile] into a standard vCard 3.0 string.
  static String encodeProfile(Profile profile) {
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:${_sanitize(profile.name)}')
      ..writeln('N:;${_sanitize(profile.name)};;;');

    if (profile.phone != null && profile.phone!.isNotEmpty) {
      buffer.writeln('TEL;TYPE=CELL:${_sanitize(profile.phone!)}');
    }
    if (profile.email != null && profile.email!.isNotEmpty) {
      buffer.writeln('EMAIL:${_sanitize(profile.email!)}');
    }
    if (profile.website != null && profile.website!.isNotEmpty) {
      buffer.writeln('URL:${_sanitize(profile.website!)}');
    }
    if (profile.linkedin != null && profile.linkedin!.isNotEmpty) {
      buffer.writeln('X-LINKEDIN:${_sanitize(profile.linkedin!)}');
    }
    if (profile.facebook != null && profile.facebook!.isNotEmpty) {
      buffer.writeln('X-FACEBOOK:${_sanitize(profile.facebook!)}');
    }
    if (profile.x != null && profile.x!.isNotEmpty) {
      buffer.writeln('X-TWITTER:${_sanitize(profile.x!)}');
    }
    if (profile.social != null && profile.social!.isNotEmpty) {
      buffer.writeln('X-SOCIAL:${_sanitize(profile.social!)}');
    }
    if (profile.instagram != null && profile.instagram!.isNotEmpty) {
      buffer.writeln('X-INSTAGRAM:${_sanitize(profile.instagram!)}');
    }
    if (profile.bio != null && profile.bio!.isNotEmpty) {
      buffer.writeln('NOTE:${_sanitize(profile.bio!)}');
    }

    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  /// Decodes a standard vCard string into a [Profile].
  static Profile decodeVCard(String vcard) {
    final now = DateTime.now();
    final lines =
        vcard.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty);

    String? name;
    String? phone;
    String? email;
    String? website;
    String? linkedin;
    String? facebook;
    String? x;
    String? social;
    String? instagram;
    String? bio;

    for (final line in lines) {
      if (line.startsWith('FN:')) {
        name = line.substring(3).trim();
      } else if (line.startsWith('N:') && (name == null || name.isEmpty)) {
        // N:LastName;FirstName;Middle;Prefix;Suffix
        final parts = line.substring(2).split(';');
        final lastName = parts.isNotEmpty ? parts[0].trim() : '';
        final firstName = parts.length > 1 ? parts[1].trim() : '';
        name = [firstName, lastName].where((p) => p.isNotEmpty).join(' ');
      } else if (line.toLowerCase().startsWith('tel')) {
        final colon = line.indexOf(':');
        if (colon != -1) phone = line.substring(colon + 1).trim();
      } else if (line.toLowerCase().startsWith('email')) {
        final colon = line.indexOf(':');
        if (colon != -1) email = line.substring(colon + 1).trim();
      } else if (line.toLowerCase().startsWith('url')) {
        final colon = line.indexOf(':');
        if (colon != -1) website = line.substring(colon + 1).trim();
      } else if (line.startsWith('X-LINKEDIN:')) {
        linkedin = line.substring(11).trim();
      } else if (line.startsWith('X-FACEBOOK:')) {
        facebook = line.substring(11).trim();
      } else if (line.startsWith('X-TWITTER:')) {
        x = line.substring(10).trim();
      } else if (line.startsWith('X-SOCIAL:')) {
        social = line.substring(9).trim();
      } else if (line.startsWith('X-INSTAGRAM:')) {
        instagram = line.substring(12).trim();
      } else if (line.toLowerCase().startsWith('note')) {
        final colon = line.indexOf(':');
        if (colon != -1) bio = line.substring(colon + 1).trim();
      }
    }

    if (name == null || name.isEmpty) {
      name = email ?? phone ?? 'Contato';
    }

    return Profile(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      email: email?.isEmpty == true ? null : email,
      phone: phone?.isEmpty == true ? null : phone,
      website: website?.isEmpty == true ? null : website,
      linkedin: linkedin?.isEmpty == true ? null : linkedin,
      facebook: facebook?.isEmpty == true ? null : facebook,
      x: x?.isEmpty == true ? null : x,
      social: social?.isEmpty == true ? null : social,
      instagram: instagram?.isEmpty == true ? null : instagram,
      bio: bio?.isEmpty == true ? null : bio,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Returns true when the raw NDEF payload is a vCard (starts with BEGIN:VCARD).
  static bool isVCardPayload(String payload) {
    return payload.trimLeft().toUpperCase().startsWith('BEGIN:VCARD');
  }

  static String _sanitize(String value) {
    return value.replaceAll(RegExp(r'[\r\n]'), ' ').trim();
  }
}
