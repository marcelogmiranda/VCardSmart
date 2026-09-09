import '../repositories/backup_repository.dart';

class ExportBackupUseCase {
  final BackupRepository repository;

  ExportBackupUseCase(this.repository);

  Future<String> call(String passphrase, String path) async {
    final backup = await repository.createBackup();
    await repository.exportToFile(backup, passphrase, path);
    return path;
  }
}
