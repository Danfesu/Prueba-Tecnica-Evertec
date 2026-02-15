import 'package:flutter/material.dart';

/// Widget reutilizable que representa un ítem dentro del NavigationDrawer.
///
/// Permite:
/// - Mostrar un ícono y un texto.
/// - Indicar visualmente si el item está seleccionado.
/// - Ejecutar una acción al hacer tap.
class DrawerItem extends StatelessWidget {
  /// Ícono que se muestra a la izquierda.
  final IconData icon;

  /// Texto descriptivo del item.
  final String label;

  /// Indica si el item está actualmente seleccionado.
  /// Si es true, se aplica un estilo visual destacado.
  final bool selected;

  /// Callback que se ejecuta al presionar el item.
  final VoidCallback? onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),

      // Si el item está seleccionado, se aplica un fondo con gradiente
      // y un borde izquierdo resaltado.
      decoration: selected
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: [0.0, 0.9, 1.0],
              ),
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 5,
                ),
              ),
            )
          : null,

      // ListTile que construye el contenido visual del item.
      child: ListTile(
        leading: Icon(
          icon,
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
