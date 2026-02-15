import 'package:drift/drift.dart';

/// Tabla de productos en la base de datos local.
///
/// Almacena información de productos para caché offline.
///
/// **Campos:**
/// - `id`: Identificador único del producto
/// - `title`: Nombre del producto
/// - `category`: Categoría (ej: "electronics", "jewelery")
/// - `description`: Descripción detallada
/// - `price`: Precio en centavos (ej: 1999 = $19.99)
/// - `width`: Ancho en centímetros
/// - `height`: Alto en centímetros
/// - `depth`: Profundidad en centímetros
/// - `imageUrl`: URL de la imagen del producto
@DataClassName('ProductEntity')
class Products extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  IntColumn get price => integer()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();
  IntColumn get depth => integer()();
  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de tags/etiquetas de productos.
///
/// Relación uno-a-muchos entre productos y tags.
///
/// **Ejemplo:**
/// ```sql
/// INSERT INTO tags (product_id, name) VALUES (1, 'oferta');
/// INSERT INTO tags (product_id, name) VALUES (1, 'nuevo');
/// ```
@DataClassName('TagEntity')
class Tags extends Table {
  /// ID autoincremental del tag.
  IntColumn get id => integer().autoIncrement()();

  /// ID del producto asociado (foreign key).
  IntColumn get productId =>
      integer().customConstraint('REFERENCES products(id)')();

  /// Nombre del tag (ej: "oferta", "nuevo", "destacado").
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
