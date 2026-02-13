import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_local_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_firebase_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_credential.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_google.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_out.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:get_it/get_it.dart';

void initAuthFeature() {
  GetIt instance = InjectorContainer.instance;

  // Cubits
  instance.registerLazySingleton(
    () => AuthCubit(instance(), instance(), instance()),
  );
  // UseCases
  instance.registerLazySingleton(() => SingInGoogle(instance()));
  instance.registerLazySingleton(() => SingOut(instance()));
  instance.registerLazySingleton(() => SingInCredential(instance()));
  // Repositories
  instance.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(instance(), instance()),
  );
  // DataSources
  instance.registerLazySingleton<AuthGoogleDataSource>(
    () => AuthFirebaseDatasource(instance()),
  );
  instance.registerLazySingleton<AuthCredentialsDataSource>(
    () => AuthCredentialsLocalDatasource(instance()),
  );
}
