import '../entities/backup_data.dart';

abstract class BackupRepository {
  Future<BackupData> createBackup();
  Future<void> exportToFile(BackupData backup, String passphrase, String path);
  Future<BackupData> importFromFile(String path, String passphrase);
  Future<void> restoreBackup(BackupData backup);
}
