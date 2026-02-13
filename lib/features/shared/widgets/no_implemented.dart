import 'package:flutter/material.dart';

class NoImplemented {
  static void showNotImplementedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Funcionalidad en construcción',
            textAlign: TextAlign.center,
          ),
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ),
          ],
        );
      },
    );
  }
}
