import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:evertec_technical_test/features/settings/domain/repositories/app_settings_repository.dart';

class GetAppSettings {
  final AppSettingsRepository repository;

  GetAppSettings(this.repository);

  Future<AppSetting> call() {
    return repository.getAppSettings();
  }
}
