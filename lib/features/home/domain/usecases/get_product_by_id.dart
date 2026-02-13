import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProductById {
  final ProductsRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product?>> call(int id) async {
    return await repository.getProductById(id);
  }
}
