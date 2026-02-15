import 'dart:developer';

import 'package:evertec_technical_test/core/services/storage/key_value_storage_service.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/get_app_settings.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/save_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit encargado de gestionar el estado del tema de la aplicación.
///
/// Controla:
/// - La carga inicial del tema (desde almacenamiento local).
/// - La sincronización opcional con una fuente remota.
/// - El cambio y persistencia del tema seleccionado.
///
/// El estado que emite es directamente un [ThemeMode].
class ThemeCubit extends Cubit<ThemeMode> {
  /// Servicio de almacenamiento local tipo key-value.
  final KeyValueStorageService _storageService;

  /// Caso de uso para obtener la configuración remota.
  final GetAppSettings getAppSettings;

  /// Caso de uso para persistir el tema seleccionado.
  final SaveTheme saveTheme;

  /// Constructor con inyección de dependencias.
  ///
  /// Inicializa el estado con [ThemeMode.system] por defecto.
  ThemeCubit(this.getAppSettings, this.saveTheme, this._storageService)
    : super(ThemeMode.system);

  /// Carga el tema almacenado.
  ///
  /// 1. Lee rápidamente el valor guardado localmente.
  /// 2. Emite el tema correspondiente.
  /// 3. (Opcional) Podría sincronizar con una fuente remota.
  Future<void> load() async {
    // 1. Cargar rápido lo que está almacenado localmente
    final localIndex = await _storageService.read<int>('themeMode') ?? 0;

    // Asegura que el índice esté dentro del rango válido
    final safeIndex = localIndex.clamp(0, ThemeMode.values.length - 1);

    emit(ThemeMode.values[safeIndex]);

    // 2. Sincronización remota (comentado en esta prueba)
    /* try {
      final appSettings = await getAppSettings();

      if (state.theme != appSettings.theme) {
        emit(remoteMode);
        await _storageService.write('themeMode', remoteMode.index);
      }
    } catch (e) {
      log("Error sincronizando con servidor, se mantiene tema local");
    } */
  }

  /// Cambia el tema actual.
  ///
  /// - Emite el nuevo estado inmediatamente.
  /// - Lo guarda en almacenamiento local.
  /// - Intenta persistirlo en una fuente remota.
  Future<void> changeTheme(ThemeMode newTheme) async {
    emit(newTheme);

    // Persistencia local inmediata
    await _storageService.write('themeMode', newTheme.index);

    try {
      // Persistencia remota
      await saveTheme(newTheme);
    } catch (e) {
      log("Error al persistir en servidor");
    }
  }
}
