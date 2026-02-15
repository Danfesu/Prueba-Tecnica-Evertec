import 'package:evertec_technical_test/core/services/storage/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementación de [KeyValueStorageService] usando SharedPreferences.
///
/// Almacena datos simples de forma persistente en el dispositivo.
///
/// **Tipos soportados:**
/// - String
/// - int
class KeyValueStorageServiceImpl extends KeyValueStorageService {
  /// Obtiene la instancia de SharedPreferences.
  ///
  /// Se llama en cada operación para asegurar que la instancia
  /// esté disponible y actualizada.
  Future getSharedPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  /// Elimina un valor almacenado por su clave.
  ///
  /// **Ejemplo:**
  /// ```dart
  /// await storage.delete('username');
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave del valor a eliminar
  @override
  Future<void> delete(String key) async {
    final prefs = await getSharedPreferencesInstance();
    await prefs.remove(key);
  }

  /// Lee un valor almacenado por su clave.
  ///
  /// Retorna el valor o `null` si no existe.
  ///
  /// **Tipos soportados:**
  /// - `String`: Cadenas de texto
  /// - `int`: Números enteros
  ///
  /// **Ejemplo:**
  /// ```dart
  /// final username = await storage.read<String>('username');
  /// if (username != null) {
  ///   print('Usuario: $username');
  /// }
  ///
  /// final userId = await storage.read<int>('user_id');
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave del valor a leer
  ///
  /// **Lanza:**
  /// - [Exception]: Si el tipo T no está soportado
  @override
  Future<T?> read<T>(String key) async {
    final prefs = await getSharedPreferencesInstance();

    // Verificar tipo y obtener valor correspondiente
    switch (T) {
      case const (String):
        return await prefs.getString(key);
      case const (int):
        return await prefs.getInt(key);
      default:
        throw Exception('Tipo de dato no soportado');
    }
  }

  /// Guarda un valor con una clave específica.
  ///
  /// Sobrescribe el valor si la clave ya existe.
  ///
  /// **Tipos soportados:**
  /// - `String`: Cadenas de texto
  /// - `int`: Números enteros
  ///
  /// **Ejemplo:**
  /// ```dart
  /// await storage.write('username', 'john_doe');
  /// await storage.write('user_id', 123);
  /// await storage.write('is_onboarding_complete', true);
  /// ```
  ///
  /// **Parámetros:**
  /// - [key]: Clave única para el valor
  /// - [value]: Valor a guardar
  ///
  /// **Lanza:**
  /// - [Exception]: Si el tipo T no está soportado
  @override
  Future<void> write<T>(String key, T value) async {
    final prefs = await getSharedPreferencesInstance();

    // Verificar tipo y guardar valor correspondiente
    switch (T) {
      case const (String):
        await prefs.setString(key, value as String);
        break;
      case const (int):
        await prefs.setInt(key, value as int);
        break;
      default:
        throw Exception('Tipo de dato no soportado');
    }
  }
}
