import 'package:evertec_technical_test/features/settings/presentation/widgets/list_tile/custom_list_tile.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';

/// Widget que muestra las opciones de configuración de la aplicación.
///
/// Contiene varias opciones representadas con [CustomListTile]:
/// - Editar Perfil
/// - Notificaciones
/// - Privacidad
/// - Idioma de la aplicación
///
/// Actualmente todas las opciones muestran un diálogo de "No implementado"
/// mediante [NoImplemented.showNotImplementedDialog].
class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CustomListTile(
            color: colors.primary,
            icon: Icons.person_outline,
            title: "Editar Perfil",
            onPressed: () {
              NoImplemented.showNotImplementedDialog(context);
            },
          ),
          Divider(color: colors.onSurface.withValues(alpha: 0.3)),
          CustomListTile(
            color: colors.primary,
            icon: Icons.notifications_outlined,
            title: "Notificaciones",
            onPressed: () {
              NoImplemented.showNotImplementedDialog(context);
            },
          ),
          Divider(color: colors.onSurface.withValues(alpha: 0.3)),
          CustomListTile(
            color: colors.primary,
            icon: Icons.lock_open,
            title: "Privacidad",
            onPressed: () {
              NoImplemented.showNotImplementedDialog(context);
            },
          ),
          Divider(color: colors.onSurface.withValues(alpha: 0.3)),
          CustomListTile(
            color: colors.primary,
            icon: Icons.language,
            title: "Idioma de la aplicación",
            onPressed: () {
              NoImplemented.showNotImplementedDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
