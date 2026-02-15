import 'package:flutter/material.dart';

/// Widget personalizado que representa un elemento de lista configurable.
///
/// Este [CustomListTile] permite mostrar:
/// - Un icono circular con un color específico.
/// - Título principal.
/// - Subtítulo opcional.
/// - Texto de trailing opcional seguido de un icono de flecha.
/// - Acción al presionar mediante [onPressed].
///
/// Es útil para listas de configuración u opciones donde se requiera
/// un estilo consistente y adaptado al tema de la aplicación.
class CustomListTile extends StatelessWidget {
  /// Color principal para el icono y el fondo circular del mismo.
  final Color color;

  /// Icono a mostrar dentro del círculo.
  final IconData icon;

  /// Texto principal del tile.
  final String title;

  /// Subtítulo opcional, mostrado debajo del título.
  final String? subtitle;

  /// Texto opcional en la parte derecha (trailing).
  final String? trailingText;

  /// Callback que se ejecuta cuando el tile es presionado.
  final VoidCallback onPressed;

  const CustomListTile({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surfaceBright,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onPressed,
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 15),
        ),
        title: Text(title),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                  letterSpacing: 1.0,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText!,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
