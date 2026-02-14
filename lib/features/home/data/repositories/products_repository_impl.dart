import 'package:evertec_technical_test/core/errors/exceptions.dart';
import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/core/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/product_remote_datasource.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDatasource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clearCache();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      // ESCENARIO 3: Con conexión - obtener datos frescos
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        // Guardar en Drift
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        // Si falla, intentar cargar del caché de Drift
        return await _getCachedProducts();
      }
    } else {
      // ESCENARIO 1 y 2: Sin conexión
      return await _getCachedProducts();
    }
  }

  @override
  Future<Either<Failure, Product?>> getProductById(int id) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      // ESCENARIO 3: Con conexión - obtener datos frescos
      try {
        final remoteProducts = await remoteDataSource.getProductById(id);
        // Guardar en Drift
        return Right(remoteProducts);
      } on ServerException {
        // Si falla, intentar cargar del caché de Drift
        return await _getCachedProductById(id);
      }
    } else {
      // ESCENARIO 1 y 2: Sin conexión
      return await _getCachedProductById(id);
    }
  }

  @override
  Future<Either<Failure, bool>> syncProducts() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const Left(NetworkFailure('Sin conexión para sincronizar'));
    }

    try {
      final remoteProducts = await remoteDataSource.getAllProducts();
      // Guardar en Drift
      await localDataSource.cacheProducts(remoteProducts);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  Future<Either<Failure, List<Product>>> _getCachedProducts() async {
    try {
      final hasCached = await localDataSource.hasCachedData();

      if (hasCached) {
        // ESCENARIO 2: Hay datos en Drift
        final cachedPosts = await localDataSource.getCachedProducts();
        return Right(cachedPosts);
      } else {
        // ESCENARIO 1: No hay datos en Drift
        return const Left(
          NoDataFailure('No hay datos disponibles sin conexión'),
        );
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  Future<Either<Failure, Product?>> _getCachedProductById(int id) async {
    try {
      final hasCached = await localDataSource.hasCachedData();

      if (hasCached) {
        // ESCENARIO 2: Hay datos en Drift
        final cachedProduct = await localDataSource.getCachedProductById(id);
        return Right(cachedProduct);
      } else {
        // ESCENARIO 1: No hay datos en Drift
        return const Left(
          NoDataFailure('No hay datos disponibles sin conexión'),
        );
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
