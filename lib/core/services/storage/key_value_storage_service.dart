/// Interface para almacenamiento simple de clave-valor.
///
/// Define el contrato para guardar, leer y eliminar datos simples
/// de forma persistente.
abstract class KeyValueStorageService {
  /// Lee un valor almacenado.
  ///
  /// Retorna el valor o `null` si no existe.
  Future<T?> read<T>(String key);

  /// Guarda un valor.
  ///
  /// Sobrescribe si la clave ya existe.
  Future<void> write<T>(String key, T value);

  /// Elimina un valor.
  Future<void> delete(String key);
}
