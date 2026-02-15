import 'package:evertec_technical_test/core/di/injector_container.dart';
import 'package:evertec_technical_test/core/router/refresh_stream.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/core/splash/splash_screen.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:evertec_technical_test/features/auth/presentation/screens/login/login_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/detail_screen.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/home_screen.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/cubits/layout_cubit.dart';
import 'package:evertec_technical_test/features/main_layout/presentation/screens/main_layout.dart';
import 'package:evertec_technical_test/features/settings/presentation/screens/settings_screem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Router principal de la aplicación configurado con [GoRouter].
///
/// Responsabilidades:
/// - Definir las rutas principales.
/// - Gestionar redirecciones según el estado de autenticación.
/// - Escuchar cambios del [AuthCubit] para refrescar navegación.
/// - Inyectar dependencias mediante [InjectorContainer].
final appRouter = GoRouter(
  /// Ruta inicial de la aplicación.
  initialLocation: RoutePaths.splash,

  /// Escucha los cambios del AuthCubit para
  /// recalcular automáticamente las redirecciones.
  refreshListenable: GoRouterRefreshStream(
    InjectorContainer.instance<AuthCubit>().stream,
  ),

  /// Lógica de redirección global basada en el estado de autenticación.
  redirect: (context, state) {
    final instance = InjectorContainer.instance;

    final authState = instance<AuthCubit>().state;
    final isLogginIn = state.fullPath == RoutePaths.login;
    final isSplash = state.fullPath == RoutePaths.splash;

    /// Determina si el usuario NO está autenticado.
    final isAAuthUnauthenticated = authState.maybeWhen(
      unauthenticated: () => true,
      initial: () => true,
      error: (_) => true,
      orElse: () => false,
    );

    /// Si el usuario no está autenticado e intenta acceder
    /// a una ruta protegida, se redirige al login.
    if (isAAuthUnauthenticated && !isLogginIn && !isSplash) {
      return RoutePaths.login;
    }

    /// Determina si el usuario está autenticado.
    final isAuthAuthenticated = authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );

    /// Si el usuario ya está autenticado y está en login,
    /// se redirige automáticamente al home.
    if (isAuthAuthenticated && isLogginIn) {
      return RoutePaths.home;
    }

    return null;
  },

  /// Definición de rutas principales.
  routes: [
    /// Ruta de Splash Screen.
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),

    /// Ruta de Login.
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login.name,
      builder: (context, state) => const LoginScreen(),
    ),

    /// ShellRoute que envuelve las rutas principales
    /// con un layout común (ej: navegación inferior).
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => InjectorContainer.instance<LayoutCubit>()..load(),
          child: MainLayout(child: child),
        );
      },
      routes: [
        /// Ruta Home protegida.
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

    /// Ruta de configuración.
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings.name,
      builder: (context, state) => SettingsScreen(),
    ),

    /// Ruta de detalle de producto.
    ///
    /// Recibe el parámetro dinámico `id`
    /// y carga la información del producto correspondiente.
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
