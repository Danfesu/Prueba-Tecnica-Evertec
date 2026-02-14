import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource.dart';
import 'package:evertec_technical_test/features/settings/data/datasources/app_settings_datasource_impl.dart';
import 'package:evertec_technical_test/features/settings/data/repositories/app_settings_repository_impl.dart';
import 'package:evertec_technical_test/features/settings/domain/repositories/app_settings_repository.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/get_app_settings.dart';
import 'package:evertec_technical_test/features/settings/domain/usecases/save_theme.dart';
import 'package:evertec_technical_test/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:get_it/get_it.dart';

void initSettingsFeature() {
  GetIt instance = InjectorContainer.instance;

  // 1. DATASOURCES (No dependen de nada de esta feature)
  instance.registerLazySingleton<AppSettingsDatasource>(
    () => AppSettingsDatasourceImpl(),
  );

  // 2. REPOSITORIES (Dependen de los DataSources)
  instance.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(instance()),
  );

  // 3. USE CASES (Dependen de los Repositorios)
  instance.registerLazySingleton(() => GetAppSettings(instance()));
  instance.registerLazySingleton(() => SaveTheme(instance()));

  // 4. CUBITS (Dependen de los Use Cases)
  instance.registerLazySingleton(
    () => ThemeCubit(instance(), instance(), instance()),
  );
}
