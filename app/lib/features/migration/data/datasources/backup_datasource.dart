import 'package:vcardsmart/core/database/hive_service.dart';
import 'package:vcardsmart/core/security/pin_service.dart';
import 'package:vcardsmart/core/security/secure_storage_service.dart';
import 'package:vcardsmart/features/settings/data/repositories/local_settings_repository.dart';

import '../../domain/entities/backup_data.dart';

/// Reads the device's live data (Hive + secure storage) into a [BackupData]
/// and restores a [BackupData] back into the device.
class BackupDataSource {
  static const String _pinKey = 'app_pin';

  Future<BackupData> collectBackup() async {
    final profiles = HiveService.profileBox.values.toList();
    final contacts = HiveService.contactBox.values.toList();
    final settingsRepo = LocalSettingsRepository();
    final settings = await settingsRepo.getSettings();
    final pinHash = await SecureStorageService.read(_pinKey);
    return BackupData(
      exportedAt: DateTime.now(),
      profiles: profiles,
      contacts: contacts,
      settings: settings,
      pinHash: pinHash,
      pinEnabled: settings.pinEnabled,
    );
  }

  Future<void> restoreBackup(BackupData backup) async {
    await HiveService.profileBox.clear();
    await HiveService.contactBox.clear();

    for (final profile in backup.profiles) {
      await HiveService.profileBox.put(profile.id, profile);
    }
    for (final contact in backup.contacts) {
      await HiveService.contactBox.put(contact.id, contact);
    }

    final settingsRepo = LocalSettingsRepository();
    await settingsRepo.updateSettings(backup.settings);

    if (backup.pinHash != null && backup.pinHash!.isNotEmpty) {
      await SecureStorageService.write(_pinKey, backup.pinHash!);
    } else {
      await PinService.removePin();
    }
  }
}
