import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/shared/extesions/snackbar_extensions.dart';
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

class _CarruselSectionState extends State<CarruselSection>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  int _currentPage = 0;

  // 🔥 Variable para trackear si necesitamos resetear
  bool _needsReset = false;

  @override
  bool get wantKeepAlive => true; // Mantener el estado vivo

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: 0,
      keepPage: false,
    );
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    if (!mounted) return;
    if (!_pageController.hasClients) return;
    if (!_pageController.position.haveDimensions) return;

    final page = _pageController.page?.round();
    if (page != null && _currentPage != page) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void didUpdateWidget(CarruselSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 🔥 Detectar si son productos nuevos (reintento)
    if (oldWidget.products.isEmpty && widget.products.isNotEmpty) {
      _needsReset = true;
    }

    // 🔥 Resetear si detectamos cambio
    if (_needsReset) {
      _pageController.removeListener(_onPageChanged);
      _pageController.dispose();
      _currentPage = 0;
      _initController();
      _needsReset = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return Column(
      key: const PageStorageKey('carrusel_section'), // Key para mantener estado
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: PageView.builder(
            key: const PageStorageKey('product_pageview'),
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double page = _currentPage.toDouble();

                  if (_pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    page = _pageController.page ?? _currentPage.toDouble();
                  }

                  final diff = page - index;
                  final absDiff = diff.abs();

                  final scale = (1 - (absDiff * 0.1)).clamp(0.4, 1.0);
                  final rotation = absDiff * (-0.8);
                  final opacity = (1 - (absDiff * 0.5)).clamp(0.3, 1.0);
                  final blur = (absDiff * 5).clamp(0.0, 6.0);

                  return Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translateByDouble(
                          0.0,
                          absDiff * 20,
                          -absDiff * 80, // profundidad
                          0.9,
                        )
                        ..rotateX(rotation),
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
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
        const SizedBox(height: 16),
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
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: size.height * 0.45,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.title,
                      style: textheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                        onPressed: () async {
                          // 🔥 Esperar a que regrese de la navegación
                          await context.pushNamed(
                            RouteNames.detail.name,
                            pathParameters: {"id": product.id.toString()},
                          );

                          // 🔥 Cuando regrese, ajustar si es necesario
                          if (mounted && _pageController.hasClients) {
                            // Esperar un frame para que el widget se reconstruya
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted && _pageController.hasClients) {
                                _pageController.jumpToPage(_currentPage);
                              }
                            });
                          }
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
