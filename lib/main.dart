import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/core/router/app_router.dart';
import 'package:evertec_technical_test/core/themes/app_theme.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/settings/presentation/cubits/theme_cubit.dart';
import 'package:evertec_technical_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Punto de entrada principal de la aplicación.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno desde el archivo ".env"
  await dotenv.load(fileName: ".env");

  // Inicializar el contenedor de inyección de dependencias
  await InjectorContainer.init();

  // Inicializar Firebase con la configuración correspondiente a la plataforma actual
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Forzar la orientación de la app a vertical (portrait)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Ejecutar la app con proveedores globales de BLoC
    runApp(
      MultiBlocProvider(
        providers: [
          // Proveedor del cubit de autenticación
          BlocProvider(create: (_) => InjectorContainer.instance<AuthCubit>()),

          // Proveedor del cubit de tema y carga inicial del estado
          BlocProvider(
            create: (_) => InjectorContainer.instance<ThemeCubit>()..load(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  });
}

/// Widget raíz de la aplicación.
///
/// Configura:
/// - Títulos y temas de MaterialApp.
/// - BLoC para el control del tema (ThemeCubit).
/// - Enrutamiento con `appRouter`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Reconstruye la app cuando cambia el ThemeMode
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false, // Oculta el banner de debug
          title: "Evertec Prueba Técnica",
          theme: AppTheme.lightTheme, // Tema claro
          darkTheme: AppTheme.darkTheme, // Tema oscuro
          themeMode: state, // Aplicar el tema según el estado de ThemeCubit
          routerConfig: appRouter, // Configuración del router
        );
      },
    );
  }
}
