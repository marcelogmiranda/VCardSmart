import 'package:flutter/material.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

/// In-memory representation of a full VCardSmart backup: profiles, contacts,
/// settings and (optionally) the PIN hash.
///
/// The backup is exported as an encrypted `.vcs` file and later imported on
/// another device to support Google Play's secure device-migration experience.
class BackupData {
  static const String currentFormat = 'vcardsmart_backup';
  static const int currentVersion = 1;

  final String format;
  final int version;
  final DateTime exportedAt;
  final List<Profile> profiles;
  final List<Contact> contacts;
  final Settings settings;

  /// SHA-256 hex hash of the user's PIN, if one is set. Transferable because
  /// [PinService.verifyPin] recomputes sha256(pin) and compares against the
  /// stored value (no device-bound key participates in the comparison).
  final String? pinHash;
  final bool pinEnabled;

  const BackupData({
    this.format = currentFormat,
    this.version = currentVersion,
    required this.exportedAt,
    required this.profiles,
    required this.contacts,
    required this.settings,
    this.pinHash,
    this.pinEnabled = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'version': version,
      'exportedAt': exportedAt.toIso8601String(),
      'profiles': profiles.map(_profileToJson).toList(),
      'contacts': contacts.map(_contactToJson).toList(),
      'settings': {
        'themeMode': settings.themeMode.index,
        'locale': settings.locale.languageCode,
        'localeCountry': settings.locale.countryCode ?? '',
        'biometricEnabled': settings.biometricEnabled,
        'pinEnabled': settings.pinEnabled,
        'adsEnabled': settings.adsEnabled,
        'securitySetupAsked': settings.securitySetupAsked,
        'pinLength': settings.pinLength,
      },
      'pinHash': pinHash,
    };
  }

  static BackupData fromJson(Map<String, dynamic> json) {
    final exportedAt = DateTime.tryParse(json['exportedAt'] as String? ?? '') ??
        DateTime.now();

    final profiles = <Profile>[];
    if (json['profiles'] is List) {
      for (final item in json['profiles'] as List) {
        if (item is! Map) continue;
        final p = _profileFromJson(Map<String, dynamic>.from(item));
        if (p != null) profiles.add(p);
      }
    }

    final contacts = <Contact>[];
    if (json['contacts'] is List) {
      for (final item in json['contacts'] as List) {
        if (item is! Map) continue;
        final c = _contactFromJson(Map<String, dynamic>.from(item));
        if (c != null) contacts.add(c);
      }
    }

    final rawSettings = json['settings'];
    final settingsJson = rawSettings is Map
        ? Map<String, dynamic>.from(rawSettings)
        : <String, dynamic>{};
    final country = (settingsJson['localeCountry'] as String?) ?? 'BR';
    final settings = Settings(
      themeMode: ThemeMode.values[_intOf(settingsJson['themeMode'], 0)],
      locale: Locale(
        settingsJson['locale'] as String? ?? 'pt',
        country.isEmpty ? null : country,
      ),
      biometricEnabled: _boolOf(settingsJson['biometricEnabled'], false),
      pinEnabled: _boolOf(settingsJson['pinEnabled'], false),
      adsEnabled: _boolOf(settingsJson['adsEnabled'], true),
      securitySetupAsked: _boolOf(settingsJson['securitySetupAsked'], false),
      pinLength: _intOf(settingsJson['pinLength'], 6),
    );

    return BackupData(
      format: json['format'] as String? ?? currentFormat,
      version: _intOf(json['version'], currentVersion),
      exportedAt: exportedAt,
      profiles: profiles,
      contacts: contacts,
      settings: settings,
      pinHash: json['pinHash'] as String?,
    );
  }

  // --- Profile serialization ---

  static Map<String, dynamic> _profileToJson(Profile p) => {
        'id': p.id,
        'name': p.name,
        'email': p.email,
        'phone': p.phone,
        'linkedin': p.linkedin,
        'instagram': p.instagram,
        'facebook': p.facebook,
        'x': p.x,
        'social': p.social,
        'website': p.website,
        'bio': p.bio,
        'photoPath': p.photoPath,
        'createdAt': p.createdAt.toIso8601String(),
        'updatedAt': p.updatedAt.toIso8601String(),
      };

  static Profile? _profileFromJson(Map<String, dynamic> json) {
    final name = json['name'] as String?;
    if (name == null || name.isEmpty) return null;
    return Profile(
      id: json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      linkedin: json['linkedin'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      x: json['x'] as String?,
      social: json['social'] as String?,
      website: json['website'] as String?,
      bio: json['bio'] as String?,
      photoPath: json['photoPath'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  // --- Contact serialization ---

  static Map<String, dynamic> _contactToJson(Contact c) => {
        'id': c.id,
        'name': c.name,
        'email': c.email,
        'phone': c.phone,
        'linkedin': c.linkedin,
        'instagram': c.instagram,
        'website': c.website,
        'bio': c.bio,
        'source': c.source,
        'importedAt': c.importedAt.toIso8601String(),
      };

  static Contact? _contactFromJson(Map<String, dynamic> json) {
    final name = json['name'] as String?;
    if (name == null || name.isEmpty) return null;
    return Contact(
      id: json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      linkedin: json['linkedin'] as String?,
      instagram: json['instagram'] as String?,
      website: json['website'] as String?,
      bio: json['bio'] as String?,
      source: json['source'] as String? ?? 'backup',
      importedAt: DateTime.tryParse(json['importedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  static int _intOf(dynamic v, int fallback) => v is int ? v : fallback;
  static bool _boolOf(dynamic v, bool fallback) =>
      v is bool ? v : (v == 1 ? true : fallback);
}
