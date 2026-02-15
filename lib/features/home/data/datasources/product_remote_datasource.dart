import 'package:evertec_technical_test/core/http/api_client.dart';
import 'package:evertec_technical_test/features/home/data/mappers/product_mapper.dart';
import 'package:evertec_technical_test/features/home/data/models/product_models.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';

/// Define el contrato para obtener productos desde
/// una fuente de datos remota (API).
///
/// Esta abstracción permite desacoplar la capa de dominio
/// de la implementación concreta del consumo HTTP.
abstract class ProductsRemoteDatasource {
  /// Obtiene la lista completa de productos desde el servidor.
  ///
  /// Retorna una lista de entidades [Product] ya convertidas
  /// al modelo de dominio.
  ///
  /// Puede lanzar excepciones si ocurre un error en la petición.
  Future<List<Product>> getAllProducts();

  /// Obtiene el detalle de un producto específico por su [id].
  ///
  /// Retorna una entidad [Product] si existe,
  /// o `null` si no se encuentra.
  ///
  /// Puede lanzar excepciones si ocurre un error en la petición.
  Future<Product?> getProductById(int id);
}

/// Implementación concreta de [ProductsRemoteDatasource].
///
/// Utiliza [ApiClient] para realizar peticiones HTTP
/// y [ProductMapper] para transformar los modelos de datos
/// en entidades de dominio.
class ProductRemoteDatasourceImpl implements ProductsRemoteDatasource {
  /// Cliente HTTP utilizado para realizar las peticiones
  /// hacia la API remota.
  final ApiClient apiClient;

  /// Constructor que recibe el [ApiClient]
  /// mediante inyección de dependencias.
  ProductRemoteDatasourceImpl(this.apiClient);

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      /// Realiza petición GET al endpoint `/products`.
      final response = await apiClient.get('/products');

      /// Convierte la respuesta JSON a modelo de datos.
      final data = ProductModels.fromJson(response.data);

      /// Mapea los modelos a entidades de dominio.
      return data.products
          .map((product) => ProductMapper.modelToDomain(product))
          .toList();
    } catch (e) {
      /// Se relanza la excepción para que capas superiores
      /// (repository/usecase) gestionen el error.
      rethrow;
    }
  }

  @override
  Future<Product?> getProductById(int id) async {
    try {
      /// Realiza petición GET al endpoint `/products/{id}`.
      final response = await apiClient.get('/products/$id');

      /// Convierte la respuesta JSON a modelo de datos.
      final data = ProductModel.fromJson(response.data);

      /// Mapea el modelo a entidad de dominio.
      return ProductMapper.modelToDomain(data);
    } catch (e) {
      /// Se relanza la excepción para manejo en capas superiores.
      rethrow;
    }
  }
}
