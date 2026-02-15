import 'package:evertec_technical_test/core/errors/exceptions.dart';
import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/core/services/network/network_info.dart';
import 'package:evertec_technical_test/features/home/data/datasources/product_remote_datasource.dart';
import 'package:evertec_technical_test/features/home/data/datasources/products_local_datasorce.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Implementación concreta del [ProductsRepository].
///
/// Esta clase actúa como punto central de acceso a datos,
/// coordinando:
/// - Fuente remota (API)
/// - Fuente local (Drift)
/// - Estado de conexión a internet
///
/// Implementa una estrategia Offline First:
/// - Si hay conexión → obtiene datos remotos y los cachea.
/// - Si no hay conexión → intenta obtener datos locales.
/// - Si falla remoto → fallback a local.
class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDatasource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  /// Limpia completamente el caché local.
  ///
  /// Retorna:
  /// - [Right] si se limpia correctamente.
  /// - [Left(CacheFailure)] si ocurre un error en la base local.
  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await localDataSource.clearCache();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  /// Obtiene todos los productos.
  ///
  /// Estrategia:
  /// - Si hay conexión → obtiene datos del servidor y los guarda en caché.
  /// - Si falla el servidor → intenta obtener datos locales.
  /// - Si no hay conexión → usa directamente el caché.
  ///
  /// Retorna:
  /// - [Right(List<Product>)] si se obtienen correctamente.
  /// - [Left(Failure)] si ocurre algún error.
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

  /// Obtiene un producto específico por ID.
  ///
  /// Estrategia:
  /// - Si hay conexión → obtiene datos remotos.
  /// - Si falla remoto → intenta obtener datos del caché.
  /// - Si no hay conexión → usa directamente el caché.
  @override
  Future<Either<Failure, Product?>> getProductById(int id) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      // ESCENARIO 3: Con conexión - obtener datos frescos
      try {
        final remoteProducts = await remoteDataSource.getProductById(id);
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

  /// Fuerza la sincronización manual de productos.
  ///
  /// - Requiere conexión.
  /// - Descarga todos los productos del servidor.
  /// - Actualiza completamente el caché local.
  ///
  /// Retorna:
  /// - [Right(true)] si la sincronización fue exitosa.
  /// - [Left(NetworkFailure)] si no hay conexión.
  /// - [Left(ServerFailure)] si el servidor falla.
  @override
  Future<Either<Failure, bool>> syncProducts() async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const Left(NetworkFailure('Sin conexión para sincronizar'));
    }

    try {
      final remoteProducts = await remoteDataSource.getAllProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  /// Obtiene productos desde el caché local.
  ///
  /// Casos:
  /// - Hay datos en Drift → retorna los productos.
  /// - No hay datos → retorna [NoDataFailure].
  /// - Error de caché → retorna [CacheFailure].
  Future<Either<Failure, List<Product>>> _getCachedProducts() async {
    try {
      final hasCached = await localDataSource.hasCachedData();

      if (hasCached) {
        final cachedPosts = await localDataSource.getCachedProducts();
        return Right(cachedPosts);
      } else {
        return const Left(
          NoDataFailure('No hay datos disponibles sin conexión'),
        );
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  /// Obtiene un producto específico desde el caché local.
  ///
  /// Casos:
  /// - Hay datos en Drift → retorna el producto.
  /// - No hay datos → retorna [NoDataFailure].
  /// - Error de caché → retorna [CacheFailure].
  Future<Either<Failure, Product?>> _getCachedProductById(int id) async {
    try {
      final hasCached = await localDataSource.hasCachedData();

      if (hasCached) {
        final cachedProduct = await localDataSource.getCachedProductById(id);
        return Right(cachedProduct);
      } else {
        return const Left(
          NoDataFailure('No hay datos disponibles sin conexión'),
        );
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
