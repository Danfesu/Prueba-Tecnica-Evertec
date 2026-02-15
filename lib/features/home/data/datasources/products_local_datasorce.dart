import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/core/errors/exceptions.dart';
import 'package:evertec_technical_test/features/home/data/mappers/product_mapper.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<Product?> getCachedProductById(int id);
  Future<void> cacheProducts(List<Product> products);
  Future<bool> hasCachedData();
  Future<void> clearCache();
}

class ProductsLocalDataSourceImpl extends ProductLocalDataSource {
  final AppDatabase database;
  static const String cacheKey = 'products_cache';

  ProductsLocalDataSourceImpl(this.database);

  @override
  Future<List<Product>> getCachedProducts() async {
    try {
      final postEntities = await database.getAllProducts();

      if (postEntities.isEmpty) {
        throw CacheException('No hay datos en caché');
      }

      return postEntities
          .map((entity) => ProductMapper.entityToDomain(entity))
          .toList();
    } catch (e) {
      throw CacheException('Error al obtener datos del caché: $e');
    }
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    try {
      // Limpiar posts antiguos
      await database.clearAllProducts();

      // Insertar nuevos posts
      final productsCompanions = products
          .map((product) => ProductMapper.domainToCompanion(product))
          .toList();
      await database.insertProducts(productsCompanions);

      // 3. Insertar tags para cada producto
      for (final product in products) {
        if (product.tags.isNotEmpty) {
          await database.insertTags(
            product.id,
            product.tags.map((tag) => tag.name).toList(),
          );
        }
      }

      // Insertar
    } catch (e) {
      throw CacheException('Error al guardar en caché: $e');
    }
  }

  @override
  Future<bool> hasCachedData() async {
    try {
      return await database.hasCachedPosts();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await database.clearAllProducts();
    } catch (e) {
      throw CacheException('Error al limpiar caché: $e');
    }
  }

  @override
  Future<Product?> getCachedProductById(int id) async {
    try {
      final product = await database.getProductById(id);

      if (product == null) {
        throw CacheException('No hay datos en caché');
      }

      final tags = await database.getTagsByProduct(product.id);

      Product produstDomain = ProductMapper.entityToDomain(product);
      produstDomain.tags = tags
          .map((tagEntity) => Tag(id: tagEntity.id, name: tagEntity.name))
          .toList();

      return produstDomain;
    } catch (e) {
      throw CacheException('Error al obtener datos del caché: $e');
    }
  }
}
