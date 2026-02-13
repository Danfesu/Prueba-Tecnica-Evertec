import 'package:flutter/material.dart';

// Widget para mostrar un divisor con un mensaje en el centro
class DividerWithMessage extends StatelessWidget {
  final String message;
  const DividerWithMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1, // Grosor de la línea
            endIndent: 10, // Espacio entre la línea y el texto
            color: colors.onSurface.withValues(alpha: 0.5),
          ),
        ),

        // Texto central
        Text(
          message,
          style: textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.5),
          ),
        ),

        // Línea derecha
        Expanded(
          child: Divider(
            thickness: 1,
            indent: 10, // Espacio entre el texto y la línea
            color: colors.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
