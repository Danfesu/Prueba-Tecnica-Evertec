/// Paths (URLs) de las rutas de la aplicación.
///
/// Define las rutas como constantes para evitar strings mágicos y typos.
///
/// **Ventajas:**
/// - Centralizado en un solo lugar
/// - Autocompletado en el IDE
/// - Fácil de mantener y refactorizar
/// - Type-safe al usar constantes
///
/// **Uso:**
/// ```dart
/// // En GoRouter
/// GoRoute(
///   path: RoutePaths.home,
///   builder: (context, state) => const HomeScreen(),
/// )
/// ```
class RoutePaths {
  // ══════════════════════════════════════════════════════════════
  // RUTAS DE AUTENTICACIÓN
  // ══════════════════════════════════════════════════════════════

  /// Ruta del splash screen inicial.
  static const String splash = '/splash';

  /// Ruta de inicio de sesión.
  /// Permite autenticación con email/password o Google.
  static const String login = '/login';

  // ══════════════════════════════════════════════════════════════
  // RUTAS PRINCIPALES
  // ══════════════════════════════════════════════════════════════

  /// Ruta principal (home) con lista de productos.
  static const String home = '/home';

  /// Ruta de detalle de un producto específico.
  ///
  /// **Path parameter:**
  /// - `id`: ID del producto (requerido)
  ///
  /// **Ejemplo de uso:**
  /// ```dart
  /// context.pushNamed(
  ///   RouteNames.detail.name,
  ///   pathParameters: {'id': '123'},
  /// );
  /// ```
  static const String detail = '/detail/:id';

  /// Ruta de ajustes/configuración.
  static const String settings = '/settings';
}
