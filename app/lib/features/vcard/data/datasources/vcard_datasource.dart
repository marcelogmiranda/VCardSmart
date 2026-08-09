import 'dart:io';
import '../../domain/entities/vcard_data.dart';

class VCardDataSource {
  Future<String> encode(VCardData data) async {
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

  Future<VCardData> decode(String vcard) async {
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
        if (nParts.isNotEmpty) firstName = nParts[0].isNotEmpty ? nParts[0] : firstName;
        if (nParts.length > 1) lastName = nParts[1].isNotEmpty ? nParts[1] : lastName;
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

  Future<void> exportToFile(VCardData data, String path) async {
    final content = await encode(data);
    final file = File(path);
    await file.writeAsString(content);
  }

  Future<VCardData> importFromFile(String path) async {
    final file = File(path);
    final content = await file.readAsString();
    return decode(content);
  }
}
