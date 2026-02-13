import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'tables/posts_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [Products, Tags])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Aquí irían las migraciones futuras
      },
    );
  }

  // ============ POSTS QUERIES ============

  // Obtener todos los posts
  Future<List<ProductEntity>> getAllProducts() async {
    return await select(products).get();
  }

  // Insertar múltiples posts
  Future<void> insertProducts(List<ProductsCompanion> productsList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(products, productsList);
    });
  }

  // Limpiar todos los posts
  Future<void> clearAllProducts() async {
    await delete(products).go();
  }

  // Verificar si hay posts en cache
  Future<bool> hasCachedPosts() async {
    final count = await (select(products)..limit(1)).get();
    return count.isNotEmpty;
  }

  // Obtener producto por id
  Future<ProductEntity?> getProductById(int id) {
    return (select(
      products,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
