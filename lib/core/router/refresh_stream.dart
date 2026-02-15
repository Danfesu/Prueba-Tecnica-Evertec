import 'dart:async';
import 'package:flutter/foundation.dart';

/// Adaptador que convierte un Stream en Listenable para GoRouter.
///
/// GoRouter requiere un [Listenable] para saber cuándo debe re-evaluar
/// las redirecciones. Esta clase permite usar cualquier Stream (como el
/// stream de un Cubit/Bloc) para trigger el refresh del router.
///
/// **Uso:**
/// ```dart
/// final appRouter = GoRouter(
///   refreshListenable: GoRouterRefreshStream(
///     authCubit.stream,
///   ),
///   redirect: (context, state) {
///     // Esta función se ejecutará cada vez que el stream emita
///     final authState = authCubit.state;
///     // ... lógica de redirección
///   },
/// );
/// ```
class GoRouterRefreshStream extends ChangeNotifier {
  /// Suscripción al stream.
  late final StreamSubscription _subscription;

  /// Crea un [GoRouterRefreshStream] que escucha un stream.
  ///
  /// Cada vez que el [stream] emite un valor, notifica a los listeners
  /// (incluyendo GoRouter) para que re-evalúen la navegación.
  ///
  /// **Ejemplo con AuthCubit:**
  /// ```dart
  /// GoRouterRefreshStream(authCubit.stream)
  /// ```
  ///
  /// **Ejemplo con múltiples streams:**
  /// ```dart
  /// GoRouterRefreshStream(
  ///   Rx.merge([authCubit.stream, themeCubit.stream]),
  /// )
  /// ```
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  /// Cancela la suscripción al stream.
  /// Llamado automáticamente por Flutter cuando el router se destruye.
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
