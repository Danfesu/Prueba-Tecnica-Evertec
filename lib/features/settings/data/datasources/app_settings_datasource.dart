import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:flutter/material.dart';

abstract class AppSettingsDatasource {
  Future<AppSetting> getAppSettings();
  Future<void> saveTheme(ThemeMode theme);
}
