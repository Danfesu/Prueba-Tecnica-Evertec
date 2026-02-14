import 'package:flutter/material.dart';

class AppSetting {
  final ThemeMode theme;

  AppSetting(this.theme);

  AppSetting copyWith({ThemeMode? newTheme}) => AppSetting(newTheme ?? theme);
}
