import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// AppBar personalizado para la pantalla de configuración.
///
/// Este AppBar se muestra como un [SliverAppBar] y permite:
/// - Navegar hacia atrás con el botón de flecha.
/// - Mostrar el título "Configuración".
/// - Mostrar un icono de ayuda con un [Tooltip] que explica la funcionalidad de la pantalla.
class SettingsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  /// Altura preferida del AppBar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  /// Key para controlar la visibilidad del [Tooltip].
  final key = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          // Regresa a la pantalla anterior en la navegación
          context.pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text("Configuración"),
      actions: [
        Tooltip(
          key: key,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.45,
          ),
          padding: EdgeInsets.all(15.0),
          message: "Aqui podra configurar las preferencias de su aplicación.",
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              // Muestra el Tooltip cuando se presiona el botón de ayuda
              key.currentState?.ensureTooltipVisible();
            },
            icon: Icon(Icons.help_rounded),
          ),
        ),
      ],
    );
  }
}
