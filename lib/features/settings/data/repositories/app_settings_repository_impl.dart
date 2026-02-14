import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource.dart';
import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:evertec_technical_test/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:flutter/material.dart';

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsDatasource datasource;

  AppSettingsRepositoryImpl(this.datasource);

  @override
  Future<AppSetting> getAppSettings() {
    return datasource.getAppSettings();
  }

  @override
  Future<void> saveTheme(ThemeMode theme) {
    return datasource.saveTheme(theme);
  }
}
