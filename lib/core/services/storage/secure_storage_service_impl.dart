import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Implementación de [SecureStorageService] usando FlutterSecureStorage.
///
/// Almacena datos sensibles de forma segura y encriptada:
/// - **iOS**: Keychain
/// - **Android**: EncryptedSharedPreferences con KeyStore
///
/// **Datos que deben almacenarse aquí:**
/// - Tokens de autenticación (JWT, OAuth)
/// - API keys
/// - Datos sensibles del usuario
///
/// **NO usar para:**
/// - Preferencias simples (usar KeyValueStorageService)
/// - Grandes cantidades de datos (usar base de datos)
/// - Datos públicos o no sensibles
///
/// **Uso:**
/// ```dart
/// final storage = InjectorContainer.instance<SecureStorageService>();
///
/// // Guardar token
/// await storage.write('auth_token', 'eyJhbGciOiJIUzI1NiIsInR...');
///
/// // Leer token
/// final token = await storage.read('auth_token');
///
/// // Eliminar token (logout)
/// await storage.delete('auth_token');
/// ```
class SecureStorageServiceImpl extends SecureStorageService {
  /// Instancia de FlutterSecureStorage para encriptación.
  final FlutterSecureStorage secureStorage;

  SecureStorageServiceImpl(this.secureStorage);

  /// Elimina un valor almacenado de forma segura.
  ///
  /// Se usa típicamente en logout para eliminar tokens.
  ///
  /// **Ejemplo:**
  /// ```dart
  /// // En logout
  /// await storage.delete('auth_token');
  /// await storage.delete('refresh_token');
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave del valor a eliminar
  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  /// Lee un valor almacenado de forma segura.
  ///
  /// Retorna el valor o `null` si no existe.
  ///
  /// **Ejemplo:**
  /// ```dart
  /// final token = await storage.read('auth_token');
  /// if (token != null) {
  ///   // Usuario autenticado
  ///   apiClient.setAuthToken(token);
  /// } else {
  ///   // Usuario no autenticado
  ///   context.goNamed(RouteNames.login.name);
  /// }
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave del valor a leer
  ///
  /// **Retorna:**
  /// - El valor almacenado o `null` si no existe
  @override
  Future<String?> read(String key) async {
    return await secureStorage.read(key: key);
  }

  /// Guarda un valor de forma segura y encriptada.
  ///
  /// Sobrescribe el valor si la clave ya existe.
  ///
  /// **Ejemplo:**
  /// ```dart
  /// // Después de login exitoso
  /// final response = await apiClient.post('/auth/login', data: {...});
  /// final token = response.data['token'];
  ///
  /// // Guardar token de forma segura
  /// await storage.write('auth_token', token);
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave única para el valor
  /// - [value]: Valor a guardar (será encriptado automáticamente)
  @override
  Future<void> write(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
}
