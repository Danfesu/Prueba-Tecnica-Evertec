import 'package:evertec_technical_test/core/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

// Definición de los temas de la aplicación
class AppTheme {
  // Método privado para construir el tema a partir de un esquema de colores
  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.baseTextTheme(colorScheme),
    );
  }

  // Temas claros de la aplicación utilizando el método de construcción
  static final ThemeData lightTheme = _buildTheme(
    const ColorScheme.light(
      primary: Color(0xFF3F51B5),
      secondary: Color(0xFF00897B),
      surface: Colors.white,
      error: Color(0xFFB00020),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1C1B1F),
      tertiary: Colors.green,
      onTertiary: Colors.grey,
    ),
  );

  // Temas oscuros de la aplicación utilizando el método de construcción
  static final ThemeData darkTheme = _buildTheme(
    const ColorScheme.dark(
      primary: Color(0xFFC5CAE9),
      secondary: Color(0xFF80CBC4),
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFCF6679),
      onPrimary: Color(0xFF121212),
      onSecondary: Color(0xFF121212),
      onSurface: Color(0xFFE6E1E5),
      tertiary: Colors.green,
      onTertiary: Colors.grey,
    ),
  );
}
