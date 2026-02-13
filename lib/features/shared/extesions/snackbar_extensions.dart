import 'package:flutter/material.dart';

extension SnackbarX on BuildContext {
  void showSuccess(String msg) {
    _showSnack(msg, Colors.green, Icons.check_circle);
  }

  void showError(String msg) {
    _showSnack(msg, Colors.red, Icons.error);
  }

  void _showSnack(String msg, Color color, IconData icon) {
    final topOffset = MediaQuery.of(this).padding.top;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: topOffset, left: 16, right: 16),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(msg, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
