import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Tarjeta visual de producto utilizada en el carrusel.
///
/// Características:
/// - Diseño tipo glassmorphism con BackdropFilter.
/// - Imagen con caché usando CachedNetworkImage.
/// - Información básica del producto (categoría, título, precio).
/// - Botón para navegar al detalle.
/// - Recibe una función asíncrona para manejar la navegación.
class ProductCard extends StatelessWidget {
  /// Producto a mostrar en la tarjeta.
  final Product product;

  /// Callback asíncrono que se ejecuta al presionar
  /// el botón "Ver detalle".
  final Future<void> Function() onPressedDetail;

  const ProductCard({
    super.key,
    required this.product,
    required this.onPressedDetail,
  });

  @override
  Widget build(BuildContext context) {
    /// Acceso a colores y tipografías del tema actual.
    final colors = Theme.of(context).colorScheme;
    final textheme = Theme.of(context).textTheme;

    /// Tamaño de pantalla para calcular proporciones dinámicas.
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),

      /// Efecto de desenfoque tipo vidrio.
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: size.height * 0.45,

          /// Decoración visual tipo glassmorphism.
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),

          child: Column(
            children: [
              /// Imagen del producto
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.contain,

                  /// Placeholder vacío mientras carga.
                  placeholder: (context, url) => const SizedBox(),

                  /// Imagen local si falla la carga.
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_connection.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// Sección inferior con información
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Categoría del producto
                    Text(
                      product.category,
                      style: textheme.bodySmall?.copyWith(
                        color: colors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Título del producto
                    Text(
                      product.title,
                      style: textheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Precio formateado en moneda colombiana
                    Text(
                      NumberFormat.currency(
                        locale: "es_CO",
                        symbol: '\$',
                      ).format(product.price),
                      style: textheme.bodyMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Botón para navegar al detalle
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () async {
                          /// Ejecuta la navegación y espera
                          /// a que el usuario regrese.
                          await onPressedDetail();
                        },
                        label: const Text("Ver detalle"),
                        icon: const Icon(Icons.visibility),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
