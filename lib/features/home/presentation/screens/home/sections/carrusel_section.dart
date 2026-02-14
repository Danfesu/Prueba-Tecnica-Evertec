import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarruselSection extends StatefulWidget {
  final List<Product> products;
  final bool isOffline;
  final bool isFromCache;

  const CarruselSection({
    super.key,
    required this.products,
    required this.isOffline,
    required this.isFromCache,
  });

  @override
  State<CarruselSection> createState() => _CarruselSectionState();
}

class _CarruselSectionState extends State<CarruselSection> {
  late PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75, // Para mostrar un poco del siguiente card
    );
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: PageView.builder(
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double page = 0;

                  if (_pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    page =
                        _pageController.page ??
                        _pageController.initialPage.toDouble();
                  }

                  final diff = page - index;
                  final absDiff = diff.abs();

                  // escala
                  final scale = (1 - (absDiff * 0.1)).clamp(0.4, 1.0);

                  // rotación hacia arriba
                  final rotation = absDiff * (-0.8);

                  // opacidad
                  final opacity = (1 - (absDiff * 0.5)).clamp(0.3, 1.0);

                  // blur - 🔥 Solución: usar ImageFilter en lugar del valor
                  final blur = (absDiff * 5).clamp(0.0, 6.0);

                  return Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // perspectiva
                        ..translateByDouble(
                          0.0,
                          absDiff * 20,
                          -absDiff * 300, // profundidad
                          1.0,
                        )
                        ..rotateX(rotation),
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // ImageFiltered para
                            child: blur > 0
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: blur,
                                      sigmaY: blur,
                                      tileMode: TileMode.decal,
                                    ),
                                    child: child!,
                                  )
                                : child!,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildProductCard(widget.products[index]),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        _buildPageIndicators(),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    final colors = Theme.of(context).colorScheme;
    final textheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        // 1. El filtro de desenfoque
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: size.height * 0.45,
          decoration: BoxDecoration(
            // 2. Color blanco con baja opacidad
            color: colors.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            // 3. Un borde sutil para definir el cristal
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_connection.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: textheme.bodySmall?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                    Text(
                      product.title,
                      style: textheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          _pageController.jumpToPage(_currentPage);
                          context.goNamed(
                            RouteNames.detail.name,
                            pathParameters: {"id": product.id.toString()},
                          );
                        },
                        label: Text("Ver detalle"),
                        icon: Icon(Icons.visibility),
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

  Widget _buildPageIndicators() {
    return Center(
      child: SmoothPageIndicator(
        controller: _pageController,
        count: widget.products.length,
        effect: const ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: Colors.blue,
          dotColor: Colors.grey,
          spacing: 8,
        ),
      ),
    );
  }
}
