import 'package:evertec_technical_test/core/http/api_client.dart';
import 'package:evertec_technical_test/features/home/data/mappers/product_mapper.dart';
import 'package:evertec_technical_test/features/home/data/models/product_models.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';

abstract class ProductsRemoteDatasource {
  Future<List<Product>> getAllProducts();
  Future<Product?> getProductById(int id);
}

class ProductRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final ApiClient apiClient;

  ProductRemoteDatasourceImpl(this.apiClient);

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await apiClient.get('/products');
      final data = ProductModels.fromJson(response.data);
      return data.products
          .map((product) => ProductMapper.modelToDomain(product))
          .toList();
    } catch (e) {
      // Manejo de errores
      rethrow;
    }
  }

  @override
  Future<Product?> getProductById(int id) async {
    try {
      final response = await apiClient.get('/products/$id');
      final data = ProductModel.fromJson(response.data);
      return ProductMapper.modelToDomain(data);
    } catch (e) {
      // Manejo de errores
      rethrow;
    }
  }
}
