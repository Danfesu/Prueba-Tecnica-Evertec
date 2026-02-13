import 'package:evertec_technical_test/features/home/domain/entities/product.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';

class GetProductById {
  final ProductsRepository repository;

  GetProductById(this.repository);

  Future<Product?> call(int id) async {
    return await repository.getProductById(id);
  }
}
