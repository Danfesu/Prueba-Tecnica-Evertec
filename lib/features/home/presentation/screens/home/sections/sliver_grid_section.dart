import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

/// Sección tipo Sliver que muestra los productos en formato grid tipo Masonry.
///
/// Se utiliza dentro del HomeScreen como parte del CustomScrollView.
/// Incluye:
/// - Título de sección.
/// - Grid dinámico de productos.
/// - Animaciones de entrada.
/// - Navegación al detalle del producto.
class SliverGridSection extends StatelessWidget {
  /// Lista de productos a mostrar en el grid.
  final List<Product> products;

  const SliverGridSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverMainAxisGroup(
      slivers: [
        /// Título de la sección
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Destacados", style: textTheme.headlineMedium),
          ),
        ),

        /// Grid tipo Masonry (estilo Pinterest)
        SliverMasonryGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childCount: products.length,

          /// Builder de cada item del grid
          itemBuilder: (context, index) {
            Product product = products[index];

            return Column(
              children: [
                /// Ajuste visual específico para el segundo elemento
                /// (genera efecto visual escalonado)
                if (index == 1) SizedBox(height: 20),

                /// Animación de entrada desde abajo con desplazamiento aleatorio
                FadeInUp(
                  from: Random().nextInt(100) + 80,
                  delay: Duration(microseconds: Random().nextInt(450) + 0),
                  child: GestureDetector(
                    /// Navega al detalle del producto al hacer tap
                    onTap: () {
                      context.pushNamed(
                        RouteNames.detail.name,
                        pathParameters: {"id": product.id.toString()},
                      );
                    },

                    /// Imagen del producto con bordes redondeados
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        height: 210,
                        fit: BoxFit.contain,

                        /// Placeholder mientras carga
                        placeholder: (context, url) => const SizedBox(),

                        /// Imagen de respaldo si ocurre error (ej: sin conexión)
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/no_connection.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                /// Nombre del producto
                Text(product.title, textAlign: TextAlign.center),
              ],
            );
          },
        ),
      ],
    );
  }
}
