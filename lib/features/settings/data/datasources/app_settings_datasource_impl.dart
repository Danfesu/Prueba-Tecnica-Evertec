import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource.dart';
import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:flutter/material.dart';

class AppSettingsDatasourceImpl extends AppSettingsDatasource {
  @override
  Future<AppSetting> getAppSettings() async {
    await Future.delayed(Duration(milliseconds: 100));
    return AppSetting(ThemeMode.system);
  }

  @override
  Future<void> saveTheme(ThemeMode theme) async {
    // persistir info, para esta prueba no se va a realizar
  }
}
