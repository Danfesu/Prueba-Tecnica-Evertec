/// Nombres de las rutas de la aplicación.
///
/// Enum type-safe para referenciar rutas sin usar strings mágicos.
///
/// **Ventajas:**
/// - Autocompletado en el IDE
/// - Errores en tiempo de compilación si la ruta no existe
/// - Refactoring seguro (renombrar automáticamente)
///
/// **Uso:**
/// ```dart
/// // Navegar
/// context.goNamed(RouteNames.home.name);
/// context.pushNamed(RouteNames.detail.name);
///
/// // En GoRouter
/// GoRoute(
///   name: RouteNames.login.name,
///   path: RouteNames.login.path,
///   builder: (context, state) => const LoginScreen(),
/// )
/// ```
enum RouteNames {
  /// Pantalla de splash inicial.
  splash,

  /// Pantalla de login/autenticación.
  /// Permite al usuario iniciar sesión con email/password o Google.
  login,

  /// Pantalla principal (home) con lista de productos.
  /// Muestra carrusel y grid de productos disponibles.
  home,

  /// Pantalla de detalle de producto.
  ///
  /// Requiere `id` como path parameter.
  ///
  /// **Ejemplo:**
  /// ```dart
  /// context.pushNamed(
  ///   RouteNames.detail.name,
  ///   pathParameters: {'id': '123'},
  /// );
  /// ```
  detail,

  /// Pantalla de ajustes/configuración.
  /// Permite cambiar tema, idioma, gestionar cuenta, etc.
  settings,
}
