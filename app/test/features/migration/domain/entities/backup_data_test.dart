import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/contacts/domain/entities/contact.dart';
import 'package:vcardsmart/features/migration/domain/entities/backup_data.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

void main() {
  final now = DateTime(2024, 1, 1);
  final backup = BackupData(
    exportedAt: now,
    profiles: [
      Profile(
        id: 'p1',
        name: 'Marcelo',
        email: 'm@test.com',
        phone: '123',
        website: 'https://site.com',
        linkedin: 'linkedin.com/in/m',
        instagram: '@m',
        facebook: 'facebook.com/m',
        x: 'x.com/m',
        social: 'https://m.social',
        bio: 'bio',
        photoPath: '/photos/p1.jpg',
        createdAt: now,
        updatedAt: now,
      ),
    ],
    contacts: [
      Contact(
        id: 'c1',
        name: 'Contato',
        email: 'c@test.com',
        phone: '456',
        linkedin: 'linkedin.com/in/c',
        instagram: '@c',
        website: 'https://c.com',
        bio: 'b',
        source: 'nfc',
        importedAt: now,
      ),
    ],
    settings: const Settings(
      themeMode: ThemeMode.dark,
      locale: Locale('en'),
      biometricEnabled: true,
      pinEnabled: true,
      adsEnabled: false,
      securitySetupAsked: true,
      pinLength: 4,
    ),
    pinHash: 'abc123',
  );

  test('should round-trip through toJson/fromJson', () {
    final json = backup.toJson();
    final restored = BackupData.fromJson(json);

    expect(restored.format, BackupData.currentFormat);
    expect(restored.version, BackupData.currentVersion);
    expect(restored.exportedAt, now);
    expect(restored.pinHash, 'abc123');

    expect(restored.profiles.length, 1);
    final p = restored.profiles.first;
    expect(p.name, 'Marcelo');
    expect(p.email, 'm@test.com');
    expect(p.phone, '123');
    expect(p.website, 'https://site.com');
    expect(p.linkedin, 'linkedin.com/in/m');
    expect(p.instagram, '@m');
    expect(p.facebook, 'facebook.com/m');
    expect(p.x, 'x.com/m');
    expect(p.social, 'https://m.social');
    expect(p.bio, 'bio');
    expect(p.photoPath, '/photos/p1.jpg');
    expect(p.createdAt, now);
    expect(p.updatedAt, now);

    expect(restored.contacts.length, 1);
    final c = restored.contacts.first;
    expect(c.name, 'Contato');
    expect(c.email, 'c@test.com');
    expect(c.phone, '456');
    expect(c.linkedin, 'linkedin.com/in/c');
    expect(c.instagram, '@c');
    expect(c.website, 'https://c.com');
    expect(c.bio, 'b');
    expect(c.source, 'nfc');
    expect(c.importedAt, now);

    expect(restored.settings.themeMode, ThemeMode.dark);
    expect(restored.settings.locale, const Locale('en'));
    expect(restored.settings.biometricEnabled, true);
    expect(restored.settings.pinEnabled, true);
    expect(restored.settings.adsEnabled, false);
    expect(restored.settings.securitySetupAsked, true);
    expect(restored.settings.pinLength, 4);
  });

  test('should skip entries without a name', () {
    final json = {
      'format': BackupData.currentFormat,
      'version': BackupData.currentVersion,
      'exportedAt': now.toIso8601String(),
      'profiles': [
        {'id': 'x', 'name': ''},
        {'id': 'y', 'name': 'Valid'},
      ],
      'contacts': [
        {'id': 'z', 'name': ''},
      ],
      'settings': {},
      'pinHash': null,
    };

    final restored = BackupData.fromJson(json);
    expect(restored.profiles.length, 1);
    expect(restored.profiles.first.name, 'Valid');
    expect(restored.contacts, isEmpty);
  });
}
