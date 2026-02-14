import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailAppBar extends StatelessWidget {
  final Product product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: () {
          context.goNamed(RouteNames.home.name);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      expandedHeight: size.height * 0.5,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      actions: [],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        background: Stack(
          children: [
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/no_connection.jpg',
                  fit: BoxFit.contain,
                ),
                imageBuilder: (context, imageProvider) {
                  return FadeIn(
                    child: Image(image: imageProvider, fit: BoxFit.contain),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
