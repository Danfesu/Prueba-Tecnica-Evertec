import 'package:flutter/material.dart';

/// Extensión sobre [BuildContext] para mostrar SnackBars de forma rápida y consistente.
///
/// Permite mostrar distintos tipos de mensajes visuales en pantalla: éxito, error, información, advertencia,
/// así como mensajes personalizados, offline o de conexión restablecida.
extension SnackbarX on BuildContext {
  /// Muestra un SnackBar de éxito con icono verde.
  void showSuccess(String msg) {
    _showSnack(msg, Colors.green.shade700, Icons.check_circle);
  }

  /// Muestra un SnackBar de error con icono rojo.
  void showError(String msg) {
    _showSnack(msg, Colors.red.shade700, Icons.error);
  }

  /// Muestra un SnackBar de información con icono azul.
  void showInfo(String msg) {
    _showSnack(msg, Colors.blue.shade700, Icons.info);
  }

  /// Muestra un SnackBar de advertencia con icono naranja.
  void showWarning(String msg) {
    _showSnack(msg, Colors.orange.shade700, Icons.warning);
  }

  /// Método privado base para mostrar SnackBars.
  ///
  /// Permite configurar:
  /// - [msg]: mensaje a mostrar.
  /// - [color]: color de fondo.
  /// - [icon]: icono al inicio del SnackBar.
  /// - [duration]: duración del SnackBar.
  /// - [action]: acción opcional (botón) dentro del SnackBar.
  void _showSnack(
    String msg,
    Color color,
    IconData icon, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: duration,
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(msg, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          action: action,
        ),
      );
  }

  /// Muestra un SnackBar indicando que el dispositivo está offline.
  ///
  /// Opcionalmente permite pasar un [onRetry] que se ejecuta al presionar el botón "Reintentar".
  void showOfflineSnackBar({VoidCallback? onRetry}) {
    _showSnack(
      'Sin conexión - Datos locales',
      Colors.orange.shade700,
      Icons.cloud_off,
      duration: const Duration(seconds: 4),
      action: onRetry != null
          ? SnackBarAction(
              label: 'Reintentar',
              textColor: Colors.white,
              onPressed: onRetry,
            )
          : null,
    );
  }

  /// Oculta cualquier SnackBar actualmente visible.
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  /// Muestra un SnackBar indicando que la conexión se ha restablecido.
  void showConnectedSnackBar() {
    _showSnack(
      'Conexión restablecida',
      Colors.green.shade700,
      Icons.wifi,
      duration: const Duration(seconds: 2),
    );
  }
}
