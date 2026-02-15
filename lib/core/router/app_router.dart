import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:go_router/go_router.dart';

// Core
import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/core/router/refresh_stream.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/core/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Features - Auth
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/login_screen.dart';

// Features - Home
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/detail_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/home_screen.dart';

// Features - Layout
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_cubit.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/screens/main_layout.dart';

// Features - Settings
import 'package:evertec_technical_test/features/settings/presentation/screens/settings_screem.dart';

/// Router principal de la aplicación.
///
/// Gestiona la navegación entre pantallas usando GoRouter.
///
/// **Características:**
/// - Redirección automática según estado de autenticación
/// - Refresh automático cuando cambia el estado de auth
/// - Shell routes para mantener layout persistente
/// - Rutas tipadas con enums
///
/// **Flujo de navegación:**
/// 1. Splash → Login/Home (según autenticación)
/// 2. Login → Home (después de login exitoso)
/// 3. Home → Detail → Home (navegación de productos)
/// 4. Home → Settings → Home (configuración)
/// Router de la aplicación con GoRouter
final appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  refreshListenable: GoRouterRefreshStream(
    InjectorContainer.instance<AuthCubit>().stream,
  ),
  redirect: (context, state) {
    final instance = InjectorContainer.instance;

    final authState = instance<AuthCubit>().state;
    final isLogginIn = state.fullPath == RoutePaths.login;

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
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => InjectorContainer.instance<LayoutCubit>()..load(),
          child: MainLayout(child: child),
        );
      },
      routes: [
        // Ruta de home
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home.name,
          builder: (context, state) => BlocProvider(
            create: (_) => InjectorContainer.instance<ProductsCubit>(),
            child: const HomeScreen(),
          ),
        ),
      ],
    ),
    // Ruta de configuración
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings.name,
      builder: (context, state) => SettingsScreen(),
    ),
    // Ruta de detalle
    GoRoute(
      path: RoutePaths.detail,
      name: RouteNames.detail.name,
      builder: (context, state) {
        final productId = state.pathParameters['id'] ?? "no-id";
        return BlocProvider(
          create: (_) =>
              InjectorContainer.instance<DetailProductCubit>()..load(productId),
          child: DetailScreen(),
        );
      },
    ),
  ],
);
