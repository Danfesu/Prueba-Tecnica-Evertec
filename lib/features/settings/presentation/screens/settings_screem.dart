import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_app_bar.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_avatar.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_options.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/sections/settings_theme.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla de configuración de la aplicación.
///
/// Contiene:
/// - AppBar personalizado.
/// - Avatar del usuario.
/// - Configuración de tema.
/// - Opciones adicionales.
/// - Botón de cierre de sesión.
/// - Información de versión.
///
/// Está construida con un [CustomScrollView] para permitir
/// una estructura basada en slivers.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          /// AppBar superior de configuración
          SettingsAppBar(),

          /// Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(width: double.infinity),

                  /// Avatar del usuario
                  SettingsAvatar(),

                  /// Selector de tema
                  SettingsTheme(),

                  SizedBox(height: 10),

                  /// Opciones adicionales
                  SettingsOptions(),

                  SizedBox(height: 20),

                  /// Botón de cerrar sesión
                  _buildLogoutButton(context),

                  SizedBox(height: 15),

                  /// Información de versión
                  Text(
                    "VERSION V1.0.0",
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.3),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el botón de cierre de sesión.
  ///
  /// - Limpia cualquier snackbar visible.
  /// - Ejecuta el método logout del [AuthCubit].
  Widget _buildLogoutButton(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        context.hideSnackBar(); // limpiar snackbars
        context.read<AuthCubit>().logout();
      },
      label: Text("Cerrar sesión"),
      icon: Icon(Icons.logout),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
        foregroundColor: Colors.redAccent,
        minimumSize: Size(double.infinity, 40),
        iconSize: 20,
      ),
    );
  }
}
