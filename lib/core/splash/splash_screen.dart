import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

/// Pantalla de splash inicial de la aplicación.
///
/// Primera pantalla que se muestra al abrir la app.
///
/// **Características:**
/// - Animación Lottie de 2 segundos
/// - Transición con fade
///
/// **Flujo:**
/// 1. Muestra animación durante 2 segundos
/// 2. Ejecuta logout (limpia sesión)
///
/// **Nota:**
/// Actualmente siempre hace logout. Para persistir sesión
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      // 1. Cambiamos a withScreenFunction
      centered: true,
      duration: 2000,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      splash: Lottie.asset(
        "assets/animations/splash_animation.json",
        repeat: true,
      ),

      // 2. Esta función se ejecuta cuando termina la animación
      screenFunction: () async {
        // Forzamos la espera de 10 segundos manualmente
        await Future.delayed(const Duration(seconds: 2));

        // Aquí es donde GoRouter toma el control real de la URL/Ruta
        if (context.mounted) {
          context.goNamed(RouteNames.login.name);
        }
        // Devolvemos un widget vacío porque la función lo requiere,
        // pero context.go ya habrá cambiado la ruta.
        return const SizedBox.shrink();
      },
    );
  }
}
