import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/migration/data/datasources/backup_datasource.dart';
import 'package:vcardsmart/features/migration/data/repositories/local_backup_repository.dart';
import 'package:vcardsmart/features/migration/domain/entities/backup_data.dart';
import 'package:vcardsmart/features/settings/domain/entities/settings.dart';

void main() {
  late LocalBackupRepository repository;

  setUp(() {
    repository = LocalBackupRepository(BackupDataSource());
  });

  test('should export then import the same backup via passphrase', () async {
    final backup = BackupData(
      exportedAt: DateTime(2024, 1, 1),
      profiles: [],
      contacts: [],
      settings: const Settings(locale: Locale('pt', 'BR')),
      pinHash: 'abc',
    );

    final path = '${Directory.systemTemp.path}/test_backup.vcs';
    await repository.exportToFile(backup, 'secret123', path);

    final imported = await repository.importFromFile(path, 'secret123');

    expect(imported.profiles, isEmpty);
    expect(imported.contacts, isEmpty);
    expect(imported.pinHash, 'abc');
    expect(imported.settings.locale, const Locale('pt', 'BR'));
  });

  test('should throw on wrong passphrase', () async {
    final backup = BackupData(
      exportedAt: DateTime(2024, 1, 1),
      profiles: [],
      contacts: [],
      settings: const Settings(),
    );

    final path = '${Directory.systemTemp.path}/test_backup_wrong.vcs';
    await repository.exportToFile(backup, 'secret123', path);

    await expectLater(
      repository.importFromFile(path, 'wrong'),
      throwsA(isA<FormatException>()),
    );
  });

  test('should throw when the file does not exist', () async {
    await expectLater(
      repository.importFromFile(
        '${Directory.systemTemp.path}/nope.vcs',
        'secret',
      ),
      throwsA(isA<FormatException>()),
    );
  });
}
