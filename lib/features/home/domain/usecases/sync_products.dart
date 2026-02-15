import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Caso de uso para sincronizar los productos desde la fuente remota.
///
/// Pertenece a la capa de dominio (Domain Layer) y encapsula
/// la operación de sincronización de datos entre:
/// - La API remota
/// - El almacenamiento local (caché)
///
/// Este caso de uso:
/// - Verifica la conexión (a través del repositorio).
/// - Obtiene los datos más recientes.
/// - Actualiza el almacenamiento local.
/// - Devuelve un resultado funcional usando `Either`.
///
/// No contiene lógica de infraestructura, solo delega
/// la responsabilidad al [ProductsRepository].
class SyncProducts {
  /// Repositorio encargado de manejar la obtención
  /// y almacenamiento de productos.
  final ProductsRepository repository;

  /// Constructor con inyección de dependencias.
  SyncProducts(this.repository);

  /// Ejecuta la sincronización.
  ///
  /// Retorna:
  /// - `Right(true)` si la sincronización fue exitosa.
  /// - `Left(Failure)` si ocurre un error de red,
  ///   servidor o almacenamiento.
  Future<Either<Failure, bool>> call() async {
    return await repository.syncProducts();
  }
}
