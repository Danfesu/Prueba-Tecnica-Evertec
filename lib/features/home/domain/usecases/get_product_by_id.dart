import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Caso de uso para obtener el detalle de un producto por su identificador.
/// Este caso de uso:
/// - No sabe si los datos provienen de API o almacenamiento local.
/// - No maneja excepciones directamente.
/// - Retorna un `Either<Failure, Product?>` para forzar el manejo
///   explícito de errores en la capa de presentación.
class GetProductById {
  /// Repositorio encargado de proveer acceso a los datos de productos.
  final ProductsRepository repository;

  /// Constructor que recibe el repositorio mediante inyección de dependencias.
  GetProductById(this.repository);

  /// Ejecuta el caso de uso para obtener un producto por su [id].
  ///
  /// Retorna:
  /// - `Right(Product?)` si la operación es exitosa.
  ///   Puede ser `null` si el producto no existe.
  /// - `Left(Failure)` si ocurre un error (red, servidor, caché, etc.).
  Future<Either<Failure, Product?>> call(int id) async {
    return await repository.getProductById(id);
  }
}
