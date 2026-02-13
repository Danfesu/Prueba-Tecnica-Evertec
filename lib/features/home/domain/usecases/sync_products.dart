import 'package:evertec_technical_test/core/errors/failures.dart';
import 'package:evertec_technical_test/features/home/domain/repositories/products_repository.dart';
import 'package:fpdart/fpdart.dart';

class SyncProducts {
  final ProductsRepository repository;

  SyncProducts(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.syncProducts();
  }
}
