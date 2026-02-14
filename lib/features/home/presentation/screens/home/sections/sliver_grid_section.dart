import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class SliverGridSection extends StatelessWidget {
  final List<Product> products;
  const SliverGridSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Destacados", style: textTheme.headlineMedium),
          ),
        ),
        SliverMasonryGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];

            return Column(
              children: [
                if (index == 1) SizedBox(height: 20),
                FadeInUp(
                  from: Random().nextInt(100) + 80,
                  delay: Duration(microseconds: Random().nextInt(450) + 0),
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(
                        RouteNames.detail.name,
                        pathParameters: {"id": product.id.toString()},
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        height: 210,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/no_connection.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(product.title, textAlign: TextAlign.center),
              ],
            );
          },
        ),
      ],
    );
  }
}
