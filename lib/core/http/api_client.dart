import 'package:dio/dio.dart';
import 'package:evertec_technical_test/core/config/constants/environments.dart';

/// Cliente HTTP centralizado para peticiones a la API.
///
/// Wrapper de Dio con configuración pre-establecida:
/// - Base URL desde variables de entorno
/// - Timeouts configurados
/// - Interceptores para logging y manejo de errores
/// - Headers por defecto
///
/// **Uso:**
/// ```dart
/// final apiClient = InjectorContainer.instance<ApiClient>();
/// final response = await apiClient.get('/products');
/// ```
class ApiClient {
  final Dio dio;

  ApiClient()
    : dio = Dio(
        BaseOptions(
          // URL base desde variables de entorno
          baseUrl: Environments.baseUrl,
          // Timeout para establecer conexión (5 segundos)
          connectTimeout: Duration(seconds: 5),
          // Timeout para recibir datos (5 segundos)
          receiveTimeout: Duration(seconds: 5),
          // Timeout para enviar datos (5 segundos)
          sendTimeout: const Duration(seconds: 5),
          // Headers por defecto
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          // Tipo de respuesta esperado
          responseType: ResponseType.json,
        ),
      );

  // ══════════════════════════════════════════════════════════════
  // MÉTODOS HTTP
  // ══════════════════════════════════════════════════════════════

  /// Realiza una petición GET.
  ///
  /// ```dart
  /// final response = await apiClient.get('/products');
  /// final products = response.data as List;
  /// ```
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get<T>(path, queryParameters: queryParameters);
  }

  /// Realiza una petición POST.
  ///
  /// ```dart
  /// final response = await apiClient.post(
  ///   '/products',
  ///   data: {'name': 'iPhone', 'price': 999},
  /// );
  /// ```
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.post<T>(path, data: data, queryParameters: queryParameters);
  }

  /// Realiza una petición PUT.
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.put<T>(path, data: data, queryParameters: queryParameters);
  }

  /// Realiza una petición DELETE.
  ///
  /// ```dart
  /// await apiClient.delete('/products/123');
  /// ```
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.delete<T>(path, data: data, queryParameters: queryParameters);
  }

  // ══════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DINÁMICA
  // ══════════════════════════════════════════════════════════════

  /// Actualiza el token de autenticación.
  ///
  /// ```dart
  /// apiClient.setAuthToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
  /// ```
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Elimina el token de autenticación.
  void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }
}
