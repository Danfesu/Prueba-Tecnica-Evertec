import 'package:evertec_technical_test/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget encargado de mostrar y gestionar la selección del tema
/// de la aplicación (Claro, Oscuro o Sistema).
///
/// Utiliza [BlocBuilder] para escuchar cambios en el [ThemeCubit]
/// y reconstruir la UI cuando el usuario cambia el modo de tema.
class SettingsTheme extends StatelessWidget {
  const SettingsTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        // state representa el ThemeMode actual (light, dark o system)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            /// Título de sección
            Text(
              "PREFERENCIAS",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),

            SizedBox(height: 20),

            /// Contenedor principal de opciones
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                spacing: 10,
                children: [
                  /// Tema Claro
                  _buildThemeOption(
                    Icons.light_mode,
                    "Claro",
                    state == ThemeMode.light,
                    ThemeMode.light,
                  ),

                  /// Tema Oscuro
                  _buildThemeOption(
                    Icons.dark_mode,
                    "Oscuro",
                    state == ThemeMode.dark,
                    ThemeMode.dark,
                  ),

                  /// Tema basado en configuración del sistema
                  _buildThemeOption(
                    Icons.wysiwyg,
                    "Sistema",
                    state == ThemeMode.system,
                    ThemeMode.system,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Construye una opción individual de tema.
  ///
  /// [icon] → Icono representativo del tema.
  /// [label] → Texto descriptivo.
  /// [isSelected] → Indica si esta opción está actualmente seleccionada.
  /// [themeMode] → Modo de tema que se aplicará al seleccionarlo.
  ///
  /// Al tocar la opción, se llama a `changeTheme()` del [ThemeCubit].
  Widget _buildThemeOption(
    IconData icon,
    String label,
    bool isSelected,
    ThemeMode themeMode,
  ) {
    return Builder(
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        final colors = Theme.of(context).colorScheme;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ThemeCubit>().changeTheme(themeMode);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Icono de la opción
                  Icon(icon, color: isSelected ? Colors.white : null),

                  /// Texto de la opción
                  Text(
                    label,
                    style: textTheme.bodyLarge?.copyWith(
                      color: isSelected ? Colors.white : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
