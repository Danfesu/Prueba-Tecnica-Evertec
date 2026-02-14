import 'dart:developer';

import 'package:evertec_technical_test/core/services/storage/key_value_storage_service.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/get_app_settings.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/save_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final KeyValueStorageService _storageService;
  final GetAppSettings getAppSettings;
  final SaveTheme saveTheme;

  ThemeCubit(this.getAppSettings, this.saveTheme, this._storageService)
    : super(ThemeMode.system);

  Future<void> load() async {
    // 1. Cargar rápido lo que está en el teléfono
    final localIndex = await _storageService.read<int>('themeMode') ?? 0;

    final safeIndex = localIndex.clamp(0, ThemeMode.values.length - 1);
    emit(ThemeMode.values[safeIndex]);

    // 2. Sincronizar con el base de datos en segundo plano
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

  Future<void> changeTheme(ThemeMode newTheme) async {
    emit(newTheme);
    await _storageService.write('themeMode', newTheme.index);
    try {
      await saveTheme(newTheme);
    } catch (e) {
      log("Error al persistir en servidor");
    }
  }
}
