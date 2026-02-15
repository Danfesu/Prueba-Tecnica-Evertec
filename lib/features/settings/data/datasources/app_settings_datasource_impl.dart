import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource.dart';
import 'package:evertec_technical_test/features/settings/domain/entities/app_setting.dart';
import 'package:flutter/material.dart';

/// Implementación concreta de [AppSettingsDatasource].
///
/// Esta clase simula una fuente de datos local para la configuración
/// de la aplicación (por ejemplo, el tema).
///
/// ⚠️ Nota: En este caso no existe persistencia real.
/// Solo se simula un pequeño delay para representar una operación asíncrona.
class AppSettingsDatasourceImpl extends AppSettingsDatasource {
  /// Obtiene la configuración actual de la aplicación.
  ///
  /// Simula una operación asíncrona (como si viniera de SharedPreferences
  /// o una base de datos local) y retorna el tema por defecto
  /// configurado en modo sistema.
  @override
  Future<AppSetting> getAppSettings() async {
    await Future.delayed(Duration(milliseconds: 100));

    // Retorna configuración con ThemeMode.system como valor inicial.
    return AppSetting(ThemeMode.system);
  }

  /// Guarda el tema seleccionado por el usuario.
  ///
  /// En una implementación real, aquí se persistiría la información
  /// en almacenamiento local (ej: SharedPreferences).
  /// En esta prueba técnica no se realiza ninguna acción.
  @override
  Future<void> saveTheme(ThemeMode theme) async {
    // Persistir información (no implementado en esta prueba).
  }
}
