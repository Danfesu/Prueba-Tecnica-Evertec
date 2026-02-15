/// Entidad de usuario autenticado en la aplicación.
///
/// Representa al usuario en la capa de dominio (Clean Architecture).
/// Contiene solo los datos esenciales del usuario necesarios
/// para la lógica de negocio.
class AppUser {
  /// Identificador único del usuario.
  final String id;

  /// Email del usuario.
  final String email;

  /// Nombre completo del usuario.
  final String name;

  /// Crea una instancia de [AppUser].
  ///
  /// **Parámetros:**
  /// - [id]: Identificador único (requerido)
  /// - [email]: Email del usuario (opcional)
  /// - [name]: Nombre del usuario (opcional)
  AppUser({required this.id, required this.email, required this.name});
}
