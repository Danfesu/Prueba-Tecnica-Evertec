import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/core/errors/exceptions.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';

import 'package:drift/drift.dart';

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

      return postEntities.map((entity) => _fromEntity(entity)).toList();
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
      final companions = products
          .map((product) => _toCompanion(product))
          .toList();
      await database.insertProducts(companions);
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

  // Convertir de Entity a Model
  Product _fromEntity(ProductEntity entity) {
    return Product(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      category: entity.category,
      price: entity.price.toDouble(),
      width: entity.width,
      height: entity.height,
      depth: entity.depth,
      imageUrl: entity.imageUrl,
      tags: [],
    );
  }

  // Convertir de Model a Companion
  ProductsCompanion _toCompanion(Product model) {
    return ProductsCompanion(
      id: Value(model.id),
      title: Value(model.title),
      description: Value(model.description),
      category: Value(model.category),
      price: Value(model.price.toInt()),
      width: Value(model.width),
      height: Value(model.height),
      depth: Value(model.depth),
      imageUrl: Value(model.imageUrl),
    );
  }

  @override
  Future<Product?> getCachedProductById(int id) async {
    try {
      final product = await database.getProductById(id);

      if (product == null) {
        throw CacheException('No hay datos en caché');
      }

      return _fromEntity(product);
    } catch (e) {
      throw CacheException('Error al obtener datos del caché: $e');
    }
  }
}
