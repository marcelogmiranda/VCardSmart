import 'dart:convert';
import 'dart:io';

import 'package:vcardsmart/core/security/encryption_service.dart';

import '../../domain/entities/backup_data.dart';
import '../../domain/repositories/backup_repository.dart';
import '../datasources/backup_datasource.dart';

/// [BackupRepository] that collects collapse device data, encrypts it with a
/// user-supplied passphrase, and writes/reads a `.vcs` backup file.
class LocalBackupRepository implements BackupRepository {
  final BackupDataSource _dataSource;

  LocalBackupRepository(this._dataSource);

  @override
  Future<BackupData> createBackup() => _dataSource.collectBackup();

  @override
  Future<void> exportToFile(
    BackupData backup,
    String passphrase,
    String path,
  ) async {
    final json = jsonEncode(backup.toJson());
    final encrypted = EncryptionService.encrypt(json, passphrase);
    final file = File(path);
    await file.writeAsString(encrypted, flush: true);
  }

  @override
  Future<BackupData> importFromFile(String path, String passphrase) async {
    final file = File(path);
    if (!await file.exists()) {
      throw const FormatException('Arquivo de backup não encontrado');
    }
    final encrypted = await file.readAsString();

    String json;
    try {
      json = EncryptionService.decrypt(encrypted, passphrase);
    } catch (_) {
      throw const FormatException(
        'Não foi possível descriptografar. Verifique a senha.',
      );
    }

    final decoded = jsonDecode(json) as Map<String, dynamic>;
    final backup = BackupData.fromJson(decoded);
    if (backup.format != BackupData.currentFormat) {
      throw const FormatException('Formato de backup não suportado');
    }
    return backup;
  }

  @override
  Future<void> restoreBackup(BackupData backup) {
    return _dataSource.restoreBackup(backup);
  }
}
