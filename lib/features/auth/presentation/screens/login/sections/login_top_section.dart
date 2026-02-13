import 'package:flutter/material.dart';

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(width: double.infinity),
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
            // Creamos borde solido
            border: Border.all(
              color: colors.primary,
              width: 0.5, // Ajusta el grosor del borde
            ),
            // Agregamos sombra al contenedor
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.5),
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset.zero, // Sin desplazamiento
                blurStyle: BlurStyle.outer, // Sombra exterior
              ),
            ],
          ),
          child: Icon(Icons.terminal_outlined, color: colors.primary, size: 30),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          "Bienvenido",
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          "Inicia sesión para gestionar tu catalogo de productos",
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
