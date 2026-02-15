import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource.dart';
import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:evertec_technical_test/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:flutter/material.dart';

/// Implementación concreta del repositorio [AppSettingsRepository].
///
/// Esta clase actúa como intermediario entre la capa de dominio
/// y la fuente de datos encargada de manejar la configuración
/// de la aplicación.
///
/// Su responsabilidad principal es delegar las operaciones
/// relacionadas con la configuración (como obtener o guardar el tema)
/// al datasource correspondiente.
class AppSettingsRepositoryImpl extends AppSettingsRepository {
  /// Fuente de datos que provee y persiste la configuración
  /// de la aplicación.
  final AppSettingsDatasource datasource;

  /// Constructor que recibe el datasource mediante inyección
  /// de dependencias.
  AppSettingsRepositoryImpl(this.datasource);

  /// Obtiene la configuración actual de la aplicación.
  ///
  /// Delega la operación al datasource.
  @override
  Future<AppSetting> getAppSettings() {
    return datasource.getAppSettings();
  }

  /// Guarda el tema seleccionado por el usuario.
  ///
  /// Delega la operación al datasource.
  @override
  Future<void> saveTheme(ThemeMode theme) {
    return datasource.saveTheme(theme);
  }
}
