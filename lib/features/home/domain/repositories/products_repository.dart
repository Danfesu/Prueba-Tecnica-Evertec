import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:fpdart/fpdart.dart';

/// Contrato del repositorio de productos.
///
/// Forma parte de la capa de dominio (Domain Layer) dentro
/// de la arquitectura limpia (Clean Architecture).
///
/// Define las operaciones disponibles relacionadas con productos,
/// sin importar si los datos provienen de:
/// - API remota
/// - Base de datos local
/// - Caché
/// - Cualquier otra fuente de datos
///
/// El uso de `Either<Failure, T>` permite manejar errores
/// de forma funcional, evitando el uso de excepciones en la capa
/// de dominio y forzando al consumidor a manejar explícitamente
/// los posibles fallos.
abstract class ProductsRepository {
  /// Obtiene la lista completa de productos.
  ///
  /// Retorna:
  /// - `Right(List<Product>)` si la operación es exitosa.
  /// - `Left(Failure)` si ocurre algún error
  ///   (red, servidor, caché, etc.).
  Future<Either<Failure, List<Product>>> getAllProducts();

  /// Obtiene el detalle de un producto por su identificador.
  ///
  /// [id] Identificador del producto.
  ///
  /// Retorna:
  /// - `Right(Product?)` si la operación es exitosa.
  ///   Puede ser `null` si el producto no existe.
  /// - `Left(Failure)` si ocurre un error.
  Future<Either<Failure, Product?>> getProductById(int id);

  /// Sincroniza los productos desde la fuente remota
  /// hacia el almacenamiento local.
  ///
  /// Retorna:
  /// - `Right(true)` si la sincronización fue exitosa.
  /// - `Left(Failure)` si ocurre un error de red o servidor.
  Future<Either<Failure, bool>> syncProducts();

  /// Limpia los datos almacenados en caché.
  ///
  /// Retorna:
  /// - `Right(null)` si se elimina correctamente.
  /// - `Left(Failure)` si ocurre un error en caché.
  Future<Either<Failure, void>> clearCache();
}
