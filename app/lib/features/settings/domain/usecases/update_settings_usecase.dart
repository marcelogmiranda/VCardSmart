import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';

class UpdateSettingsUseCase {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  Future<void> call(Settings settings) async {
    await repository.updateSettings(settings);
  }

  Future<void> reset() async {
    await repository.resetSettings();
  }
}
