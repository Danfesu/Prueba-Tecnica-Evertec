import 'package:animate_do/animate_do.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/products/products_state.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/sections/carrusel_section.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/home/sections/sliver_grid_section.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (products, isOffline, isFromCache) {
              if (isOffline && !isFromCache) {
                context.showOfflineSnackBar(
                  onRetry: () => context.read<ProductsCubit>().retry(),
                );
              } else if (isOffline && isFromCache) {
                context.showOfflineSnackBar(
                  onRetry: () =>
                      context.read<ProductsCubit>().synchronizeProducts(),
                );
              } else if (!isOffline) {
                context.hideSnackBar();
              }
            },
            error: (message, isOffline) {
              context.showError(message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final colors = Theme.of(context).colorScheme;
          final textheme = Theme.of(context).textTheme;
          final size = MediaQuery.of(context).size;

          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products, isOffline, isFromCache) => CustomScrollView(
              // 🔥 Agregar key al CustomScrollView
              key: ValueKey('products-${products.length}'),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: size.height * 0.65,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.03),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Exclusivos",
                                style: textheme.headlineMedium,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "VER ${products.length} ITEMS",
                                  style: textheme.bodyLarge?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FadeInRight(
                          // 🔥 Agregar key única para forzar reconstrucción
                          key: ValueKey(
                            'carrusel-${products.length}-${products.hashCode}',
                          ),
                          child: CarruselSection(
                            // 🔥 Agregar key basada en los productos
                            key: ValueKey(
                              'carrusel-products-${products.length}-${products.hashCode}',
                            ),
                            products: products,
                            isOffline: isOffline,
                            isFromCache: isFromCache,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Grid Section
                SliverGridSection(
                  key: ValueKey(
                    'grid-${products.length}',
                  ), // 🔥 Key también aquí
                  products: products,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
            syncing: (products) => _buildSyncingState(products),
            error: (error, isOffline) => _buildErrorState(
              isOffline,
              error,
              () => context.read<ProductsCubit>().retry(),
              context,
            ),
          );
        },
      ),
    );
  }

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

  Widget _buildErrorState(
    bool isOffline,
    String message,
    VoidCallback onRetry,
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isOffline ? Icons.cloud_off_rounded : Icons.error_outline_rounded,
              size: 100,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              isOffline ? 'Sin Conexión' : 'Error',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'No hay datos almacenados',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
