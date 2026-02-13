import 'package:evertec_technical_test/features/home/data/models/product_models.dart';
import 'package:evertec_technical_test/features/home/domain/entities/Tag.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product.dart';

class ProductMapper {
  static Product fromModel(ProductModel model) {
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
}
