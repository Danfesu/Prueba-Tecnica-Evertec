import 'package:flutter/material.dart';

extension SnackbarX on BuildContext {
  // Mensajes rápidos
  void showSuccess(String msg) {
    _showSnack(msg, Colors.green.shade700, Icons.check_circle);
  }

  void showError(String msg) {
    _showSnack(msg, Colors.red.shade700, Icons.error);
  }

  void showInfo(String msg) {
    _showSnack(msg, Colors.blue.shade700, Icons.info);
  }

  void showWarning(String msg) {
    _showSnack(msg, Colors.orange.shade700, Icons.warning);
  }

  // Método privado base
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

  // Offline específico
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

  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  // Conexión restablecida
  void showConnectedSnackBar() {
    _showSnack(
      'Conexión restablecida',
      Colors.green.shade700,
      Icons.wifi,
      duration: const Duration(seconds: 2),
    );
  }

  // SnackBar genérico con más control
  void showCustomSnackBar({
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: actionLabel != null && onAction != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }
}
