import 'package:animate_do/animate_do.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/presentation/widget/carrusel.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';

/// Sección tipo Sliver que muestra un carrusel de productos destacados.
///
/// Se utiliza dentro del HomeScreen como parte del CustomScrollView.
/// Incluye:
/// - Título de sección.
/// - Botón para ver todos los productos.
/// - Carrusel animado con los productos.
class SliverCarruselSection extends StatelessWidget {
  /// Lista de productos que se mostrarán en el carrusel.
  final List<Product> products;

  const SliverCarruselSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: double.infinity,
        height: size.height * 0.65,

        /// Fondo decorativo con color primario muy suave
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.03),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            /// Encabezado de la sección
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  /// Título
                  Text("Exclusivos", style: textheme.headlineMedium),

                  const Spacer(),

                  /// Botón para ver todos los items
                  /// (Actualmente sin implementación)
                  TextButton(
                    onPressed: () {
                      NoImplemented.showNotImplementedDialog(context);
                    },
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

            /// Animación de entrada desde la derecha
            FadeInRight(
              // Key única para forzar reconstrucción cuando cambian los productos
              key: ValueKey('carrusel-${products.length}-${products.hashCode}'),
              child: Carrusel(
                // Key basada en la lista para asegurar refresco correcto
                key: ValueKey(
                  'carrusel-products-${products.length}-${products.hashCode}',
                ),
                products: products,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
