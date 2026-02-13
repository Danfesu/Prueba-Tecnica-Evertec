import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/core/splash/splash_screen.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home_screen.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/settings_screem.dart';
import 'package:go_router/go_router.dart';

// Router de la aplicación con GoRouter
final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  // Rutas principales de la aplicación
  routes: [
    // Ruta de splash screen
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    // Ruta de login
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    // Ruta de home
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    // Ruta de detalle
    GoRoute(
      path: RoutePaths.detail,
      name: RouteNames.detail.name,
      builder: (context, state) => const DetailScreen(),
    ),
    // Ruta de configuración
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings.name,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
