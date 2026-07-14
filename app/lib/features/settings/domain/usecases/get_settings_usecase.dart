import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository repository;

  GetSettingsUseCase(this.repository);

  Future<Settings> call() async {
    return await repository.getSettings();
  }
}
