import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'tables/products_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [Products, Tags])
/// Base de datos local de la aplicación usando Drift.
///
/// Gestiona el almacenamiento offline de productos y tags.
///
/// **Tablas:**
/// - [Products]: Productos cacheados
/// - [Tags]: Etiquetas de productos
///
/// **Ubicación:** `<Documents>/app_database.sqlite`
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Versión actual del schema de la base de datos.
  ///
  /// Incrementar cuando se modifique la estructura de las tablas.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migraciones futuras irán aquí
        // Ejemplo:
        // if (from < 2) {
        //   await m.addColumn(products, products.newColumn);
        // }
      },
    );
  }

  // ══════════════════════════════════════════════════════════════
  // QUERIES DE PRODUCTOS
  // ══════════════════════════════════════════════════════════════

  /// Obtiene todos los productos almacenados en caché.
  ///
  /// Retorna lista vacía si no hay productos.
  Future<List<ProductEntity>> getAllProducts() async {
    return await select(products).get();
  }

  /// Obtiene un producto por su ID.
  ///
  /// Retorna `null` si no existe.
  Future<ProductEntity?> getProductById(int id) {
    return (select(
      products,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Inserta o actualiza múltiples productos.
  ///
  /// Si el producto ya existe (mismo ID), se actualiza.
  ///
  /// ```dart
  /// await db.insertProducts([
  ///   ProductsCompanion.insert(
  ///     id: Value(1),
  ///     title: 'iPhone',
  ///     // ...
  ///   ),
  /// ]);
  /// ```
  Future<void> insertProducts(List<ProductsCompanion> productsList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(products, productsList);
    });
  }

  /// Elimina todos los productos del caché.
  Future<void> clearAllProducts() async {
    await delete(products).go();
  }

  /// Verifica si hay productos en caché.
  ///
  /// Retorna `true` si hay al menos un producto almacenado.
  Future<bool> hasCachedPosts() async {
    final count = await (select(products)..limit(1)).get();
    return count.isNotEmpty;
  }

  // ══════════════════════════════════════════════════════════════
  // QUERIES DE TAGS
  // ══════════════════════════════════════════════════════════════

  /// Inserta tags para un producto.
  ///
  /// ```dart
  /// await db.insertTags(1, ['nuevo', 'oferta', 'destacado']);
  /// ```
  Future<void> insertTags(int productId, List<String> tagNames) async {
    await batch((batch) {
      batch.insertAll(
        tags,
        tagNames
            .map(
              (name) => TagsCompanion.insert(productId: productId, name: name),
            )
            .toList(),
      );
    });
  }

  /// Obtiene todos los tags de un producto.
  ///
  /// ```dart
  /// final productTags = await db.getTagsByProduct(1);
  /// // ['nuevo', 'oferta']
  /// ```
  Future<List<TagEntity>> getTagsByProduct(int productId) {
    return (select(
      tags,
    )..where((tbl) => tbl.productId.equals(productId))).get();
  }

  // ══════════════════════════════════════════════════════════════
  // QUERIES COMBINADAS (JOINS)
  // ══════════════════════════════════════════════════════════════

  /// Obtiene productos con sus tags.
  ///
  /// Retorna un mapa: `{ProductEntity: List<TagEntity>}`
  Future<Map<ProductEntity, List<TagEntity>>> getProductsWithTags() async {
    final query = select(
      products,
    ).join([leftOuterJoin(tags, tags.productId.equalsExp(products.id))]);

    final results = await query.get();
    final map = <ProductEntity, List<TagEntity>>{};

    for (final row in results) {
      final product = row.readTable(products);
      final tag = row.readTableOrNull(tags);

      if (!map.containsKey(product)) {
        map[product] = [];
      }

      if (tag != null) {
        map[product]!.add(tag);
      }
    }

    return map;
  }

  /// Abre la conexión a la base de datos SQLite.
  ///
  /// Ubicación: `<Documents>/app_database.sqlite`
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
