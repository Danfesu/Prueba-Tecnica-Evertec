import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/shared/widgets/buttons/general_button.dart';
import 'package:evertec_technical_test/features/shared/widgets/no_implemented.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailInfo extends StatelessWidget {
  final Product product;

  const DetailInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Wrap(
                  children: [
                    ...product.tags.map(
                      (item) => _buildCustomChip(item.name, colors.primary),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "DESCRIPCIÓN",
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 10),
                Text(product.description, style: textTheme.bodyLarge),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          children: [
            _buildProductDimension("ANCHO", product.width),
            _buildProductDimension("ALTO", product.height),
            _buildProductDimension("LARGO", product.depth),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(bottom: 40),
            child: GeneralButton(
              text: "Añadir al carrito",
              onPressed: () {
                NoImplemented.showNotImplementedDialog(context);
              },
            ),
          ),
        ),
      ],
    );
  }

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
