import 'dart:developer';

import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/core/router/refresh_stream.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/core/splash/splash_screen.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/login_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home_screen.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/settings_screem.dart';
import 'package:go_router/go_router.dart';

// Router de la aplicación con GoRouter
final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  refreshListenable: GoRouterRefreshStream(
    InjectorContainer.instance<AuthCubit>().stream,
  ),
  redirect: (context, state) {
    final instance = InjectorContainer.instance;

    final authState = instance<AuthCubit>().state;
    final isLogginIn = state.fullPath == RoutePaths.login;
    log(state.fullPath ?? '');

    final isAAuthUnauthenticated = authState.mapOrNull(
      unauthenticated: (_) => true,
      error: (_) => true,
    );

    if (isAAuthUnauthenticated == true) {
      return isLogginIn ? null : RoutePaths.login;
    }

    final isAuthAuthenticated = authState.mapOrNull(authenticated: (_) => true);

    if (isAuthAuthenticated == true && isLogginIn) {
      return RoutePaths.home;
    }

    return null;
  },
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
