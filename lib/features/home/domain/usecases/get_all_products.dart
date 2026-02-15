import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Caso de uso para obtener la lista completa de productos.
/// Este caso de uso:
/// - No conoce si los datos provienen de API o caché.
/// - No maneja excepciones directamente.
/// - Devuelve un `Either<Failure, List<Product>>`
///   para obligar al consumidor a manejar éxito o error.
class GetAllProducts {
  /// Repositorio que provee acceso a los datos de productos.
  final ProductsRepository repository;

  /// Constructor que recibe la implementación del repositorio
  /// mediante inyección de dependencias.
  GetAllProducts(this.repository);

  /// Ejecuta el caso de uso.
  ///
  /// Retorna:
  /// - `Right(List<Product>)` si la operación es exitosa.
  /// - `Left(Failure)` si ocurre algún error (red, servidor, caché, etc.).
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}
