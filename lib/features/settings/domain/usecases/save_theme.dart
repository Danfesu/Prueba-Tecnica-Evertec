import 'package:evertec_technical_test/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:flutter/material.dart';

class SaveTheme {
  final AppSettingsRepository repository;

  SaveTheme(this.repository);

  Future<void> call(ThemeMode theme) {
    return repository.saveTheme(theme);
  }
}
