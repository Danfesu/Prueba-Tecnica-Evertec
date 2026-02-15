import 'package:flutter/material.dart';

/// Sección superior de la pantalla de inicio de sesión.
///
/// Esta clase se encarga de mostrar:
/// - Un ícono representativo.
/// - Un mensaje de bienvenida.
/// - Una breve descripción de la funcionalidad.
///
/// Utiliza estilos dinámicos basados en el tema actual
/// para mantener coherencia visual en la aplicación.
class LoginTopSection extends StatelessWidget {
  const LoginTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        /// Contenedor decorativo que envuelve el ícono principal.
        ///
        /// Incluye:
        /// - Fondo con opacidad.
        /// - Borde sólido.
        /// - Sombra exterior.
        /// - Bordes redondeados.
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),

            // Borde sólido del contenedor
            border: Border.all(color: colors.primary, width: 0.5),

            // Sombra exterior decorativa
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.5),
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset.zero,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),

          /// Ícono representativo de la aplicación.
          child: Icon(Icons.terminal_outlined, color: colors.primary, size: 30),
        ),

        SizedBox(height: size.height * 0.02),

        /// Título principal de bienvenida.
        Text(
          "Bienvenido",
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: size.height * 0.01),

        /// Descripción secundaria que indica
        /// el propósito del inicio de sesión.
        Text(
          "Inicia sesión para gestionar tu catalogo de productos",
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
