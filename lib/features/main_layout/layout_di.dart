import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_local_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/data/repositories/main_layout_repository_impl.dart';
import 'package:evertec_technical_test/features/main_layout/domain/repositories/main_layout_repository.dart';
import 'package:evertec_technical_test/features/main_layout/domain/usecases/get_screens.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_cubit.dart';
import 'package:get_it/get_it.dart';

void initLayoutFeature() {
  GetIt instance = InjectorContainer.instance;

  // 1. DATASOURCES (No dependen de nada de esta feature)
  instance.registerLazySingleton<MainLayoutDatasource>(
    () => MainLayoutLocalDatasource(),
  );

  // 2. REPOSITORIES (Dependen de los DataSources)
  instance.registerLazySingleton<MainLayoutRepository>(
    () => MainLayoutRepositoryImpl(instance()),
  );

  // 3. USE CASES (Dependen de los Repositorios)
  instance.registerLazySingleton(() => GetScreens(instance()));

  // 4. CUBITS (Dependen de los Use Cases)
  instance.registerFactory(() => LayoutCubit(instance()));
}
