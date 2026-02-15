import 'package:equatable/equatable.dart';

/// Clase base para errores en la capa de dominio.
///
/// Representa el resultado de una operación fallida en el patrón Either.
/// Todas las fallas deben extender esta clase.
///
/// **Uso en Repository:**
/// ```dart
/// Future<Either<Failure, List<Product>>> getProducts() async {
///   try {
///     final products = await remoteDataSource.getProducts();
///     return Right(products);
///   } on ServerException catch (e) {
///     return Left(ServerFailure(e.message));
///   }
/// }
/// ```
abstract class Failure extends Equatable {
  /// Mensaje descriptivo del error.
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Error cuando hay problemas con el servidor o API.
///
/// **Casos de uso:**
/// - Error HTTP (4xx, 5xx)
/// - Timeout de conexión al servidor
/// - Respuesta inválida del servidor
/// - Error de parsing
///
/// **Ejemplo:**
/// ```dart
/// on ServerException catch (e) {
///   return Left(ServerFailure(e.message'));
/// }
/// ``
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Error cuando hay problemas con el caché local.
///
/// **Casos de uso:**
/// - No hay datos en caché
/// - Error al leer/escribir en base de datos
/// - Datos corruptos
/// - Espacio insuficiente
///
/// **Ejemplo:**
/// ```dart
/// on CacheException catch (e) {
///   return Left(CacheFailure(
///     'No hay productos guardados'
///   ));
/// }
/// ```
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Error cuando hay problemas de conectividad.
///
/// **Casos de uso:**
/// - Sin conexión a internet
/// - WiFi/datos móviles desactivados
/// - Timeout de red
/// - DNS no disponible
///
/// **Ejemplo:**
/// ```dart
/// if (!await networkInfo.isConnected) {
///   return Left(NetworkFailure('Sin conexión a internet'));
/// }
/// ```
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Error cuando un recurso no se encuentra.
///
/// **Casos de uso:**
/// - Producto no existe (404)
/// - Recurso eliminado
///
/// **Ejemplo:**
/// ```dart
/// on NotFoundException catch (e) {
///   return Left(NotFoundFailure('Producto no encontrado'));
/// }
/// ```
class NoDataFailure extends Failure {
  const NoDataFailure(super.message);
}
