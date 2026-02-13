import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Pantalla de splash screen con animación Lottie (primera pantalla que se muestra al iniciar la aplicación)
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      centered: true,
      duration: 2000,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      splash: Lottie.asset("assets/animations/splash_animation.json"),
      nextScreen: const LoginScreen(),
    );
  }
}
