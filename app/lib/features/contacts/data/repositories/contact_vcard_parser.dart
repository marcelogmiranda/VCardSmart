import '../../domain/entities/contact.dart';

class ContactVCardParser {
  ContactVCardParser._();

  static Contact? parse(String vcard) {
    try {
      final lines = vcard.split('\n');
      final fields = <String, String>{};

      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('FN:') || trimmed.startsWith('N:')) {
          final key = trimmed.startsWith('FN:') ? 'name' : 'name';
          if (!fields.containsKey('name')) {
            fields[key] = trimmed.substring(2).trim();
          }
        } else if (trimmed.startsWith('EMAIL:')) {
          fields['email'] = trimmed.substring(6).trim();
        } else if (trimmed.startsWith('TEL:')) {
          fields['phone'] = trimmed.substring(4).trim();
        } else if (trimmed.startsWith('URL:')) {
          fields['website'] = trimmed.substring(4).trim();
        } else if (trimmed.startsWith('NOTE:')) {
          fields['bio'] = trimmed.substring(5).trim();
        } else if (trimmed.startsWith('X-LINKEDIN:')) {
          fields['linkedin'] = trimmed.substring(11).trim();
        }
      }

      if (fields['name'] == null || fields['name']!.isEmpty) {
        return null;
      }

      return Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: fields['name']!,
        email: fields['email'],
        phone: fields['phone'],
        linkedin: fields['linkedin'],
        website: fields['website'],
        bio: fields['bio'],
        source: 'vcard',
        importedAt: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  static String toVCard(Contact contact) {
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:${contact.name}')
      ..writeln('N:${contact.name};;;;');

    if (contact.email != null) {
      buffer.writeln('EMAIL:${contact.email}');
    }
    if (contact.phone != null) {
      buffer.writeln('TEL:${contact.phone}');
    }
    if (contact.website != null) {
      buffer.writeln('URL:${contact.website}');
    }
    if (contact.bio != null) {
      buffer.writeln('NOTE:${contact.bio}');
    }
    if (contact.linkedin != null) {
      buffer.writeln('X-LINKEDIN:${contact.linkedin}');
    }

    buffer.writeln('END:VCARD');
    return buffer.toString();
  }
}
