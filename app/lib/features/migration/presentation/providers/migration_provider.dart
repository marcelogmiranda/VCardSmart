import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/backup_datasource.dart';
import '../../data/repositories/local_backup_repository.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../domain/usecases/export_backup_usecase.dart';
import '../../domain/usecases/import_backup_usecase.dart';

final backupDataSourceProvider = Provider<BackupDataSource>((ref) {
  return BackupDataSource();
});

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return LocalBackupRepository(ref.read(backupDataSourceProvider));
});

final exportBackupUseCaseProvider = Provider<ExportBackupUseCase>((ref) {
  return ExportBackupUseCase(ref.read(backupRepositoryProvider));
});

final importBackupUseCaseProvider = Provider<ImportBackupUseCase>((ref) {
  return ImportBackupUseCase(ref.read(backupRepositoryProvider));
});
