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

  /// Encodes a minimal vCard with only the essential business-card fields
  /// (name, phone, email, best URL) so it fits small NFC tags (e.g. an
  /// NTAG213 holds only ~144 bytes of NDEF payload).
  static String encodeMinimalVCard(Profile profile) {
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
    final url = profileUrl(profile);
    if (url != null && url.isNotEmpty) {
      buffer.writeln('URL:$url');
    }

    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  /// Returns the best public URL for the profile (the fallback written to tags
  /// too small for a vCard), or null when the profile has no linkable field.
  /// Prefers the website, then Instagram, then the remaining social handles.
  static String? profileUrl(Profile profile) {
    for (final candidate in [
      profile.website,
      profile.instagram,
      profile.linkedin,
      profile.facebook,
      profile.x,
      profile.social,
    ]) {
      final value = candidate?.trim() ?? '';
      if (value.isEmpty) continue;
      if (value.contains('://')) return value;
      if (value.startsWith('www.')) return 'https://$value';
      if (value.startsWith('@')) {
        return 'https://instagram.com/${value.substring(1)}';
      }
      return 'https://$value';
    }
    return null;
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

  /// Builds a minimal [Profile] from raw text read off a tag (e.g. an Instagram
  /// URL written by a tag-writing app). Keeps the value as the website field so
  /// the "Receber Contato" flow can save it as a contact.
  static Profile profileFromText(String text) {
    final now = DateTime.now();
    final trimmed = text.trim();
    String? website;
    String name = 'Contato';
    if (trimmed.toLowerCase().startsWith('http://') ||
        trimmed.toLowerCase().startsWith('https://')) {
      website = trimmed;
      name = _displayNameFromUrl(trimmed);
    } else if (trimmed.isNotEmpty) {
      name = trimmed.length > 60 ? trimmed.substring(0, 60) : trimmed;
    }

    return Profile(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      website: website,
      createdAt: now,
      updatedAt: now,
    );
  }

  static String _displayNameFromUrl(String url) {
    final withoutProtocol =
        url.replaceFirst(RegExp(r'^https?://'), '');
    final host = withoutProtocol.split('/').first;
    final parts = host.split('.');
    final hostName = parts.length >= 2 ? parts[parts.length - 2] : host;
    return hostName.isEmpty ? 'Contato' : hostName;
  }

  static String _sanitize(String value) {
    return value.replaceAll(RegExp(r'[\r\n]'), ' ').trim();
  }
}
