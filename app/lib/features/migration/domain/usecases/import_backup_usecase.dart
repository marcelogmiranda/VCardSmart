import '../repositories/backup_repository.dart';

class ImportBackupUseCase {
  final BackupRepository repository;

  ImportBackupUseCase(this.repository);

  Future<void> call(String path, String passphrase) async {
    final backup = await repository.importFromFile(path, passphrase);
    await repository.restoreBackup(backup);
  }
}
