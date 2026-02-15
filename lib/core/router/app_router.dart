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
  // ══════════════════════════════════════════════════════════════
  // CONFIGURACIÓN INICIAL
  // ══════════════════════════════════════════════════════════════

  /// Ruta inicial al abrir la app.
  initialLocation: RoutePaths.splash,
  // ══════════════════════════════════════════════════════════════
  // REFRESH AUTOMÁTICO
  // ══════════════════════════════════════════════════════════════

  /// Escucha cambios en el estado de autenticación.
  ///
  /// Cuando cambia (login/logout), ejecuta el redirect automáticamente.
  refreshListenable: GoRouterRefreshStream(
    InjectorContainer.instance<AuthCubit>().stream,
  ),
  // ══════════════════════════════════════════════════════════════
  // REDIRECCIÓN GLOBAL (Auth Guard)
  // ══════════════════════════════════════════════════════════════

  /// Maneja la lógica de redirección según estado de autenticación.
  ///
  /// **Casos:**
  /// 1. Usuario no autenticado → Redirigir a login
  /// 2. Usuario autenticado en login → Redirigir a home
  /// 3. Usuario autenticado en otras rutas → Permitir acceso
  redirect: (context, state) {
    final authCubit = InjectorContainer.instance<AuthCubit>();
    final authState = authCubit.state;

    final currentPath = state.matchedLocation;
    final isOnLoginPage = currentPath == RoutePaths.login;
    final isOnSplashPage = currentPath == RoutePaths.splash;

    // Verificar si el usuario NO está autenticado
    final isUnauthenticated = authState.maybeWhen(
      unauthenticated: () => true,
      error: (_) => true,
      orElse: () => false,
    );

    // Usuario no autenticado → Login
    if (isUnauthenticated && !isOnLoginPage && !isOnSplashPage) {
      return RoutePaths.login;
    }

    // Usuario autenticado → Redirigir desde login a home
    final isAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    if (isAuthenticated && isOnLoginPage) {
      return RoutePaths.home;
    }

    // Permitir navegación a splash siempre
    if (isOnSplashPage) {
      return null;
    }

    // Sin redirección necesaria
    return null;
  },
  // ══════════════════════════════════════════════════════════════
  // RUTAS
  // ══════════════════════════════════════════════════════════════
  routes: [
    // ══════════════════════════════════════════════════════════
    // SPLASH SCREEN
    // ══════════════════════════════════════════════════════════
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    // ══════════════════════════════════════════════════════════
    // AUTH - LOGIN
    // ══════════════════════════════════════════════════════════
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    // ══════════════════════════════════════════════════════════
    // MAIN LAYOUT (Shell Route con Bottom Navigation)
    // ══════════════════════════════════════════════════════════
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => InjectorContainer.instance<LayoutCubit>()..load(),
          child: MainLayout(child: child),
        );
      },
      routes: [
        // ══════════════════════════════════════════════════════
        // HOME
        // ══════════════════════════════════════════════════════
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
    // ══════════════════════════════════════════════════════
    // SETTINGS (dentro del Shell)
    // ══════════════════════════════════════════════════════
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings.name,
      builder: (context, state) => SettingsScreen(),
    ),
    // ══════════════════════════════════════════════════════════
    // PRODUCT DETAIL (Fuera del Shell - Full Screen)
    // ══════════════════════════════════════════════════════════
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
