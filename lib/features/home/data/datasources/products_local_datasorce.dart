import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/core/errors/exceptions.dart';
import 'package:evertec_technical_test/features/home/data/mappers/product_mapper.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

/// Define el contrato para el acceso a datos locales de productos.
///
/// Esta abstracción permite desacoplar la fuente de datos
/// del resto de la aplicación (principio de inversión de dependencias).
abstract class ProductLocalDataSource {
  /// Obtiene todos los productos almacenados en caché.
  ///
  /// Lanza [CacheException] si no existen datos o ocurre un error.
  Future<List<Product>> getCachedProducts();

  /// Obtiene un producto específico por su ID desde la caché.
  ///
  /// Retorna `null` si no se encuentra.
  /// Puede lanzar [CacheException] si ocurre un error.
  Future<Product?> getCachedProductById(int id);

  /// Guarda una lista de productos en la base de datos local.
  ///
  /// Reemplaza completamente los datos anteriores.
  /// Puede lanzar [CacheException] si ocurre un error.
  Future<void> cacheProducts(List<Product> products);

  /// Verifica si existen datos almacenados en caché.
  ///
  /// Retorna `true` si hay productos guardados.
  Future<bool> hasCachedData();

  /// Elimina todos los productos almacenados en la base de datos local.
  ///
  /// Puede lanzar [CacheException] si ocurre un error.
  Future<void> clearCache();
}

/// Implementación concreta de [ProductLocalDataSource].
///
/// Utiliza [AppDatabase] como mecanismo de persistencia local.
class ProductsLocalDataSourceImpl extends ProductLocalDataSource {
  /// Instancia de la base de datos local.
  final AppDatabase database;

  /// Clave identificadora del caché (no utilizada actualmente).
  static const String cacheKey = 'products_cache';

  /// Constructor que recibe la dependencia [AppDatabase].
  ProductsLocalDataSourceImpl(this.database);

  @override
  Future<List<Product>> getCachedProducts() async {
    try {
      // Obtener todas las entidades de productos desde la base de datos.
      final postEntities = await database.getAllProducts();

      // Si no hay datos, lanzar excepción de caché vacía.
      if (postEntities.isEmpty) {
        throw CacheException('No hay datos en caché');
      }

      // Convertir entidades a objetos de dominio.
      return postEntities
          .map((entity) => ProductMapper.entityToDomain(entity))
          .toList();
    } catch (e) {
      // Capturar cualquier error y encapsularlo como CacheException.
      throw CacheException('Error al obtener datos del caché: $e');
    }
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    try {
      // 1. Limpiar productos antiguos.
      await database.clearAllProducts();

      // 2. Convertir productos de dominio a companions de base de datos.
      final productsCompanions = products
          .map((product) => ProductMapper.domainToCompanion(product))
          .toList();

      // 3. Insertar nuevos productos.
      await database.insertProducts(productsCompanions);

      // 4. Insertar tags asociados a cada producto.
      for (final product in products) {
        if (product.tags.isNotEmpty) {
          await database.insertTags(
            product.id,
            product.tags.map((tag) => tag.name).toList(),
          );
        }
      }
    } catch (e) {
      throw CacheException('Error al guardar en caché: $e');
    }
  }

  @override
  Future<bool> hasCachedData() async {
    try {
      // Verificar si existen productos almacenados.
      return await database.hasCachedPosts();
    } catch (e) {
      // En caso de error, se retorna false para evitar romper el flujo.
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Eliminar todos los productos almacenados.
      await database.clearAllProducts();
    } catch (e) {
      throw CacheException('Error al limpiar caché: $e');
    }
  }

  @override
  Future<Product?> getCachedProductById(int id) async {
    try {
      // Obtener el producto por ID.
      final product = await database.getProductById(id);

      if (product == null) {
        throw CacheException('No hay datos en caché');
      }

      // Obtener los tags asociados al producto.
      final tags = await database.getTagsByProduct(product.id);

      // Convertir entidad a dominio.
      Product produstDomain = ProductMapper.entityToDomain(product);

      // Asignar los tags convertidos al objeto de dominio.
      produstDomain.tags = tags
          .map((tagEntity) => Tag(id: tagEntity.id, name: tagEntity.name))
          .toList();

      return produstDomain;
    } catch (e) {
      throw CacheException('Error al obtener datos del caché: $e');
    }
  }
}
