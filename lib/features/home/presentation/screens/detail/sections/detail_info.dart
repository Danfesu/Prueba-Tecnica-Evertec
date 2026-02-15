import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/shared/widgets/buttons/general_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget que representa la sección de información del producto
/// dentro de la pantalla de detalle.
///
/// Contiene:
/// - Título y precio formateado.
/// - Lista de etiquetas (tags).
/// - Descripción del producto.
/// - Dimensiones (ancho, alto y largo).
/// - Botón para añadir al carrito (no implementado).
class DetailInfo extends StatelessWidget {
  /// Entidad de dominio que contiene la información completa del producto.
  final Product product;

  const DetailInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SliverMainAxisGroup(
      slivers: [
        /// Sección principal con título, precio, tags y descripción
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Fila con título del producto y precio
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// Precio formateado en moneda colombiana
                    Text(
                      NumberFormat.currency(
                        locale: "es_CO",
                        symbol: '\$',
                      ).format(product.price),
                      style: textTheme.headlineMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                /// Chips dinámicos generados a partir de los tags del producto
                Wrap(
                  children: [
                    ...product.tags.map(
                      (item) => _buildCustomChip(item.name, colors.primary),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                /// Título de sección descripción
                Text(
                  "DESCRIPCIÓN",
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),

                SizedBox(height: 10),

                /// Texto descriptivo del producto
                Text(product.description, style: textTheme.bodyLarge),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),

        /// Grid con dimensiones del producto
        SliverGrid.count(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          children: [
            _buildProductDimension("ANCHO", product.width),
            _buildProductDimension("ALTO", product.height),
            _buildProductDimension("LARGO", product.depth),
          ],
        ),

        /// Botón de acción
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(bottom: 40),
            child: GeneralButton(
              text: "Añadir al carrito",
              onPressed: () {
                // Muestra un diálogo indicando que la funcionalidad
                // aún no está implementada.
                NoImplemented.showNotImplementedDialog(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Construye un widget que muestra una dimensión del producto.
  ///
  /// Parámetros:
  /// - [label]: Nombre de la dimensión (ej: ANCHO).
  /// - [value]: Valor numérico en centímetros.
  Widget _buildProductDimension(String label, int value) {
    return Builder(
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        final colors = Theme.of(context).colorScheme;

        return Column(
          children: [
            Text(
              "ANCHO",
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
            Text(
              "${value.toString()} cm",
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        );
      },
    );
  }

  /// Construye un chip personalizado para representar un tag del producto.
  ///
  /// Parámetros:
  /// - [label]: Texto del tag.
  /// - [color]: Color base del chip.
  Widget _buildCustomChip(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
