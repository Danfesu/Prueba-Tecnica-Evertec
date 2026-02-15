import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Variables de entorno de la aplicación.
///
/// Carga valores desde el archivo `.env`:
/// ```
/// SERVER_FIREBASE_CLIENT_ID=tu_client_id
/// BASE_URL=https://api.ejemplo.com
/// ```
class Environments {
  Environments._();

  /// Client ID de Firebase.
  static String get firebaseClientId =>
      dotenv.env['SERVER_FIREBASE_CLIENT_ID'] ?? _defaultFirebaseClientId;

  /// URL base de la API.
  static String get baseUrl => dotenv.env['BASE_URL'] ?? _defaultBaseUrl;

  // Valores por defecto
  static const String _defaultFirebaseClientId = 'No configurado';
  static const String _defaultBaseUrl = 'https://fakestoreapi.com';

  /// Verifica si todas las variables están configuradas.
  static bool get isConfigured {
    return firebaseClientId != _defaultFirebaseClientId &&
        baseUrl != _defaultBaseUrl;
  }

  /// Valida que las variables estén configuradas.
  /// Lanza error si falta alguna.
  static void validate() {
    if (!isConfigured) {
      throw StateError('Variables de entorno no configuradas en .env');
    }
  }
}
