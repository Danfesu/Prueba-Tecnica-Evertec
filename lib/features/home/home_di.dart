import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/features/home/data/datasources/product_remote_datasource.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/data/repositories/products_repository_impl.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_all_products.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/get_product_by_id.dart';
import 'package:evertec_technical_test/features/home/domain/usecases/sync_products.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:get_it/get_it.dart';

void initHomeFeature() {
  GetIt instance = InjectorContainer.instance;

  // Cubits
  instance.registerLazySingleton(
    () => ProductsCubit(
      instance(),
      instance(),
      instance(),
      instance(),
      instance(),
    ),
  );
  // UseCases
  instance.registerLazySingleton(() => GetAllProducts(instance()));
  instance.registerLazySingleton(() => GetProductById(instance()));
  instance.registerLazySingleton(() => SyncProducts(instance()));
  // Repositories
  instance.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(instance(), instance(), instance()),
  );
  // DataSources
  instance.registerLazySingleton<ProductsRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(instance()),
  );
  instance.registerLazySingleton<ProductLocalDataSource>(
    () => ProductsLocalDataSourceImpl(instance()),
  );
}
