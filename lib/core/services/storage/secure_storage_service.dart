/// Interface para almacenamiento seguro y encriptado.
///
/// Define el contrato para guardar, leer y eliminar datos sensibles
/// de forma segura.
abstract class SecureStorageService {
  /// Lee un valor almacenado de forma segura.
  ///
  /// Retorna el valor o `null` si no existe.
  Future<String?> read(String key);

  /// Guarda un valor de forma segura.
  ///
  /// El valor se encripta automáticamente.
  Future<void> write(String key, String value);

  /// Elimina un valor almacenado.
  Future<void> delete(String key);
}
