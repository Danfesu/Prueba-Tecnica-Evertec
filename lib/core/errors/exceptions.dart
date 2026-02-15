/// Excepción lanzada cuando hay errores en peticiones al servidor.
///
/// **Casos de uso:**
/// - Error HTTP (4xx, 5xx)
/// - Timeout de conexión
/// - Error de parsing de respuesta
/// - Credenciales inválidas
///
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

/// Excepción lanzada cuando hay errores con el caché local.
///
/// **Casos de uso:**
/// - Error al leer/escribir en la base de datos
/// - Datos corruptos en caché
/// - Espacio de almacenamiento insuficiente
/// - Error de serialización/deserialización
///
class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

/// Excepción lanzada cuando hay problemas de conectividad.
///
/// **Casos de uso:**
/// - Sin conexión a internet
/// - WiFi/datos móviles desactivados
/// - Timeout de red
/// - DNS no disponible
///
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
