import 'package:drift/drift.dart';
import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/features/home/data/models/product_models.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

/// Mapper responsable de transformar objetos entre
/// las distintas capas de la aplicación:
///
/// - Data (Model)
/// - Domain (Entidad de negocio)
/// - Persistence (Entity / Companion de Drift)
///
/// Ayuda a mantener el desacoplamiento entre capas
/// siguiendo principios de Clean Architecture.
class ProductMapper {
  /// Convierte un [ProductModel] (capa de datos / API)
  /// a un [Product] (capa de dominio).
  static Product modelToDomain(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category.name,
      price: model.price.toDouble(),
      width: model.dimensions.width.toInt(),
      height: model.dimensions.height.toInt(),
      depth: model.dimensions.depth.toInt(),
      imageUrl: model.thumbnail,
      tags: model.tags.map((element) => Tag(name: element)).toList(),
    );
  }

  /// Convierte un [Product] (capa de dominio)
  /// en un [ProductsCompanion] (objeto requerido por Drift
  /// para inserciones o actualizaciones en base de datos).
  static ProductsCompanion domainToCompanion(Product product) {
    return ProductsCompanion(
      id: Value(product.id),
      title: Value(product.title),
      description: Value(product.description),
      category: Value(product.category),
      price: Value(product.price.toInt()),
      width: Value(product.width),
      height: Value(product.height),
      depth: Value(product.depth),
      imageUrl: Value(product.imageUrl),
    );
  }

  /// Convierte un [ProductEntity] (representación almacenada en base de datos)
  /// en un [Product] (capa de dominio).
  ///
  /// Nota:
  /// - Los tags no se asignan aquí.
  /// - Se inicializan como lista vacía porque normalmente
  ///   se obtienen en una consulta adicional.
  static Product entityToDomain(ProductEntity entity) {
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
}
