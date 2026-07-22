import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../../../core/database/hive_boxes.dart';

class LocalContactRepository implements ContactRepository {
  final Box<Contact> _box;

  LocalContactRepository([Box<Contact>? box]) : _box = box ?? Hive.box<Contact>(HiveBoxes.contacts);

  @override
  Future<List<Contact>> getAllContacts() async {
    return _box.values.toList();
  }

  @override
  Future<Contact?> getContact(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> saveContact(Contact contact) async {
    await _box.put(contact.id, contact);
  }

  @override
  Future<void> deleteContact(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> importFromVCard(String vcard) async {
    final contact = _parseVCard(vcard);
    if (contact != null) {
      await saveContact(contact);
    }
  }

  @override
  Future<void> importFromQR(String qrData) async {
    final json = _parseJson(qrData);
    if (json != null) {
      final contact = Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: json['name'] as String? ?? '',
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        linkedin: json['linkedin'] as String?,
        instagram: json['instagram'] as String?,
        website: json['website'] as String?,
        bio: json['bio'] as String?,
        source: 'qr',
        importedAt: DateTime.now(),
      );
      await saveContact(contact);
    }
  }

  @override
  Future<void> importFromNFC(String nfcData) async {
    final json = _parseJson(nfcData);
    if (json != null) {
      final contact = Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: json['name'] as String? ?? '',
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        linkedin: json['linkedin'] as String?,
        instagram: json['instagram'] as String?,
        website: json['website'] as String?,
        bio: json['bio'] as String?,
        source: 'nfc',
        importedAt: DateTime.now(),
      );
      await saveContact(contact);
    }
  }

  @override
  Future<String> exportToVCard(Contact contact) async {
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
    if (contact.linkedin != null) {
      buffer.writeln('X-LINKEDIN:${contact.linkedin}');
    }
    if (contact.instagram != null) {
      buffer.writeln('X-INSTAGRAM:${contact.instagram}');
    }
    if (contact.bio != null) {
      buffer.writeln('NOTE:${contact.bio}');
    }

    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  @override
  Future<void> exportToAgenda(Contact contact) async {
    // Platform-specific export would go here
  }

  Map<String, dynamic>? _parseJson(String data) {
    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Contact? _parseVCard(String vcard) {
    try {
      final lines = vcard.split('\n');
      String? name;
      String? email;
      String? phone;
      String? website;
      String? linkedin;
      String? instagram;
      String? bio;

      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('FN:')) {
          name = trimmed.substring(3).trim();
        } else if (trimmed.startsWith('EMAIL:')) {
          email = trimmed.substring(6).trim();
        } else if (trimmed.startsWith('TEL:')) {
          phone = trimmed.substring(4).trim();
        } else if (trimmed.startsWith('URL:')) {
          website = trimmed.substring(4).trim();
        } else if (trimmed.startsWith('X-LINKEDIN:')) {
          linkedin = trimmed.substring(11).trim();
        } else if (trimmed.startsWith('X-INSTAGRAM:')) {
          instagram = trimmed.substring(12).trim();
        } else if (trimmed.startsWith('NOTE:')) {
          bio = trimmed.substring(5).trim();
        }
      }

      if (name == null || name.isEmpty) return null;

      return Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        website: website,
        linkedin: linkedin,
        instagram: instagram,
        bio: bio,
        source: 'vcard',
        importedAt: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }
}
