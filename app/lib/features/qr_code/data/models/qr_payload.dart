import '../../../profile/domain/entities/profile.dart';
import '../../domain/entities/qr_data.dart';

class QRPayload {
  QRPayload._();

  static String encodeVCard(Profile profile) {
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:${profile.name}')
      ..writeln('N:${profile.name};;;;');
    if (profile.email != null && profile.email!.isNotEmpty) {
      buffer.writeln('EMAIL:${profile.email}');
    }
    if (profile.phone != null && profile.phone!.isNotEmpty) {
      buffer.writeln('TEL:${profile.phone}');
    }
    if (profile.website != null && profile.website!.isNotEmpty) {
      buffer.writeln('URL:${profile.website}');
    }
    if (profile.linkedin != null && profile.linkedin!.isNotEmpty) {
      buffer.writeln('X-LINKEDIN:${profile.linkedin}');
    }
    if (profile.instagram != null && profile.instagram!.isNotEmpty) {
      buffer.writeln('X-INSTAGRAM:${profile.instagram}');
    }
    if (profile.bio != null && profile.bio!.isNotEmpty) {
      buffer.writeln('NOTE:${profile.bio}');
    }
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  static Profile decodeVCard(String payload) {
    final lines = payload.split('\n');
    String name = '';
    String? email;
    String? phone;
    String? website;
    String? linkedin;
    String? instagram;
    String? bio;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('FN:')) {
        name = trimmed.substring(3);
      } else if (trimmed.startsWith('EMAIL:')) {
        email = trimmed.substring(6);
      } else if (trimmed.startsWith('TEL:')) {
        phone = trimmed.substring(4);
      } else if (trimmed.startsWith('URL:')) {
        website = trimmed.substring(4);
      } else if (trimmed.startsWith('X-LINKEDIN:')) {
        linkedin = trimmed.substring(11);
      } else if (trimmed.startsWith('X-INSTAGRAM:')) {
        instagram = trimmed.substring(12);
      } else if (trimmed.startsWith('NOTE:')) {
        bio = trimmed.substring(5);
      }
    }

    if (name.isEmpty) {
      throw const FormatException('Invalid vCard: missing FN field');
    }

    final now = DateTime.now();
    return Profile(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      website: website,
      linkedin: linkedin,
      instagram: instagram,
      bio: bio,
      createdAt: now,
      updatedAt: now,
    );
  }

  static QRData encodeProfile(Profile profile) {
    final vCard = encodeVCard(profile);
    return QRData(
      type: 'vcard',
      payload: vCard,
      timestamp: DateTime.now(),
    );
  }
}
