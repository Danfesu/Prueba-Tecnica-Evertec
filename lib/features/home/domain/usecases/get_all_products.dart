import 'package:evertec_technical_test/features/home/domain/entities/product.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';

class GetAllProducts {
  final ProductsRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}
