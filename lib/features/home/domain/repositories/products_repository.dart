import 'package:evertec_technical_test/features/home/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();
  Future<Product?> getProductById(int id);
}
