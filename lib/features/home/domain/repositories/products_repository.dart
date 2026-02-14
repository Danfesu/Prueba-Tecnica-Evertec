import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product?>> getProductById(int id);
  Future<Either<Failure, bool>> syncProducts();
  Future<Either<Failure, void>> clearCache();
}
