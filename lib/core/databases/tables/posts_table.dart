import 'package:drift/drift.dart';

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

// Tabla para metadata del cache
@DataClassName('CacheMetadataEntity')
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId =>
      integer().customConstraint('REFERENCES products(id)')();
  TextColumn get name => text()();
}
