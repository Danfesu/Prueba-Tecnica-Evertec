import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_state.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/sections/error_section.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/sections/sliver_carrusel_section.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/sections/sliver_grid_section.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla principal de la aplicación.
///
/// Se encarga de:
/// - Escuchar cambios en el estado de [ProductsCubit].
/// - Construir la UI según el estado actual.
/// - Mostrar SnackBars informativos dependiendo de la conectividad.
/// - Manejar estados como loading, error, sincronización y datos cargados.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsCubit, ProductsState>(
        /// Listener para efectos secundarios (SnackBars, mensajes, etc.)
        listener: (context, state) {
          state.maybeWhen(
            loaded: (products, isOffline, isFromCache) {
              // Si está offline y NO viene del caché, mostrar opción de reintento
              if (isOffline && !isFromCache) {
                context.showOfflineSnackBar(
                  onRetry: () => context.read<ProductsCubit>().retry(),
                );
              }
              // Si está offline pero viene del caché, permitir sincronizar
              else if (isOffline && isFromCache) {
                context.showOfflineSnackBar(
                  onRetry: () =>
                      context.read<ProductsCubit>().synchronizeProducts(),
                );
              }
              // Si vuelve a estar online, ocultar SnackBar
              else if (!isOffline) {
                context.hideSnackBar();
              }
            },
            // Mostrar mensaje de error cuando el estado es error
            error: (message, isOffline) {
              context.showError(message);
            },
            orElse: () {},
          );
        },

        /// Builder para renderizar la UI según el estado
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products, isOffline, isFromCache) =>
                _buildLoadedState(products, isOffline, isFromCache),
            syncing: (products) => _buildSyncingState(products),
            error: (error, isOffline) =>
                ErrorSection(isOffline: isOffline, message: error),
          );
        },
      ),
    );
  }

  /// Construye la vista principal cuando los productos han sido cargados.
  ///
  /// Usa un [CustomScrollView] con:
  /// - Carrusel superior.
  /// - Grid de productos.
  /// - Espacio inferior adicional.
  ///
  /// Se agregan `ValueKey` para forzar reconstrucción cuando cambia
  /// la cantidad de productos.
  Widget _buildLoadedState(
    List<Product> products,
    bool isOffline,
    bool isFromCache,
  ) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          // Key dinámica basada en la cantidad de productos
          key: ValueKey('products-${products.length}'),
          slivers: [
            SliverCarruselSection(products: products),
            // Grid de productos
            SliverGridSection(
              key: ValueKey('grid-${products.length}'),
              products: products,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        );
      },
    );
  }

  /// Construye el estado visual cuando se está sincronizando
  /// con el servidor después de recuperar conexión.
  ///
  /// Muestra un overlay oscuro con un indicador de progreso.
  Widget _buildSyncingState(List<Product> currentProducts) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withValues(alpha: 0.3),
          child: const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Conectando...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
