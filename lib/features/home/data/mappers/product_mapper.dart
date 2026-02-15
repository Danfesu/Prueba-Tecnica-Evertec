import 'package:drift/drift.dart';
import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/features/home/data/models/product_models.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

class ProductMapper {
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

  // Convertir de Entity a Model
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
