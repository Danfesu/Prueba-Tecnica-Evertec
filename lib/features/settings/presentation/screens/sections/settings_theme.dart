import 'package:evertec_technical_test/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTheme extends StatelessWidget {
  const SettingsTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        // Extraer el ThemeMode del estado
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "PREFERENCIAS",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 20),
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
                  _buildThemeOption(
                    Icons.light_mode,
                    "Claro",
                    state == ThemeMode.light,
                    ThemeMode.light,
                  ),
                  _buildThemeOption(
                    Icons.dark_mode,
                    "Oscuro",
                    state == ThemeMode.dark,
                    ThemeMode.dark,
                  ),
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
        return Builder(
          builder: (context) => Expanded(
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
                    Icon(icon, color: isSelected ? Colors.white : null),
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
          ),
        );
      },
    );
  }
}
