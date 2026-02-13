import 'package:flutter/material.dart';

// Widget de botón general, con estilo personalizado y que recibe el texto y la función a ejecutar al presionar el botón
class GeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GeneralButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(text, style: textTheme.labelLarge),
    );
  }
}
