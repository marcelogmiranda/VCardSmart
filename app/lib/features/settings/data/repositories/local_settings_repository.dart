import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';

class LocalSettingsRepository implements SettingsRepository {
  Settings _settings = const Settings();

  @override
  Future<Settings> getSettings() async {
    return _settings;
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    _settings = settings;
  }

  @override
  Future<void> resetSettings() async {
    _settings = const Settings();
  }
}
