import 'dart:io';
import '../../features/vcard/domain/entities/vcard_data.dart';

class VCardUtils {
  VCardUtils._();

  static String encode(VCardData data) {
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:${data.version}');

    if (data.fullName.isNotEmpty) {
      buffer.writeln('FN:${data.fullName}');
    }
    if (data.firstName != null) {
      buffer.writeln('N:${data.firstName};${data.lastName ?? ''};;;');
    }
    if (data.organization != null && data.organization!.isNotEmpty) {
      buffer.writeln('ORG:${data.organization}');
    }
    if (data.title != null && data.title!.isNotEmpty) {
      buffer.writeln('TITLE:${data.title}');
    }
    if (data.email != null && data.email!.isNotEmpty) {
      buffer.writeln('EMAIL:${data.email}');
    }
    if (data.phone != null && data.phone!.isNotEmpty) {
      buffer.writeln('TEL:${data.phone}');
    }
    if (data.website != null && data.website!.isNotEmpty) {
      buffer.writeln('URL:${data.website}');
    }
    if (data.address != null && data.address!.isNotEmpty) {
      buffer.writeln('ADR:;;${data.address};;;');
    }
    if (data.linkedin != null && data.linkedin!.isNotEmpty) {
      buffer.writeln('X-LINKEDIN:${data.linkedin}');
    }
    if (data.facebook != null && data.facebook!.isNotEmpty) {
      buffer.writeln('X-FACEBOOK:${data.facebook}');
    }
    if (data.x != null && data.x!.isNotEmpty) {
      buffer.writeln('X-TWITTER:${data.x}');
    }
    if (data.social != null && data.social!.isNotEmpty) {
      buffer.writeln('X-SOCIAL:${data.social}');
    }
    if (data.note != null && data.note!.isNotEmpty) {
      buffer.writeln('NOTE:${data.note}');
    }
    if (data.photo != null && data.photo!.isNotEmpty) {
      buffer.writeln('PHOTO;ENCODING=b;TYPE=JPEG:${data.photo}');
    }
    buffer.writeln('END:VCARD');

    return buffer.toString();
  }

  static VCardData decode(String vcard) {
    final lines = vcard.split('\n');
    String? firstName;
    String? lastName;
    String? organization;
    String? title;
    String? email;
    String? phone;
    String? website;
    String? address;
    String? note;
    String? photo;
    String? linkedin;
    String? facebook;
    String? x;
    String? social;
    String version = '3.0';

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('VERSION:')) {
        version = trimmed.substring(8);
      } else if (trimmed.startsWith('FN:')) {
        final name = trimmed.substring(3);
        final parts = name.split(' ');
        firstName = parts.first;
        lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
      } else if (trimmed.startsWith('N:')) {
        final nParts = trimmed.substring(2).split(';');
        if (nParts.isNotEmpty) {
          final nFirst = nParts[0];
          if (nFirst.isNotEmpty) firstName = nFirst;
        }
        if (nParts.length > 1) {
          final nLast = nParts[1];
          if (nLast.isNotEmpty) lastName = nLast;
        }
      } else if (trimmed.startsWith('ORG:')) {
        organization = trimmed.substring(4);
      } else if (trimmed.startsWith('TITLE:')) {
        title = trimmed.substring(6);
      } else if (trimmed.startsWith('EMAIL:')) {
        email = trimmed.substring(6);
      } else if (trimmed.startsWith('TEL:')) {
        phone = trimmed.substring(4);
      } else if (trimmed.startsWith('URL:')) {
        website = trimmed.substring(4);
      } else if (trimmed.startsWith('ADR:')) {
        final addrParts = trimmed.substring(4).split(';');
        address = addrParts.where((p) => p.trim().isNotEmpty).join(', ');
      } else if (trimmed.startsWith('X-LINKEDIN:')) {
        linkedin = trimmed.substring(11);
      } else if (trimmed.startsWith('X-FACEBOOK:')) {
        facebook = trimmed.substring(11);
      } else if (trimmed.startsWith('X-TWITTER:')) {
        x = trimmed.substring(10);
      } else if (trimmed.startsWith('X-SOCIAL:')) {
        social = trimmed.substring(9);
      } else if (trimmed.startsWith('NOTE:')) {
        note = trimmed.substring(5);
      } else if (trimmed.startsWith('PHOTO;')) {
        final colonIdx = trimmed.indexOf(':', trimmed.indexOf(';') + 1);
        if (colonIdx != -1) {
          photo = trimmed.substring(colonIdx + 1);
        }
      }
    }

    return VCardData(
      version: version,
      firstName: firstName,
      lastName: lastName,
      organization: organization,
      title: title,
      email: email,
      phone: phone,
      website: website,
      address: address,
      note: note,
      photo: photo,
      linkedin: linkedin,
      facebook: facebook,
      x: x,
      social: social,
    );
  }

  static File toFile(VCardData data, String path) {
    final content = encode(data);
    return File(path)..writeAsStringSync(content);
  }

  static VCardData fromFile(File file) {
    final content = file.readAsStringSync();
    return decode(content);
  }
}
