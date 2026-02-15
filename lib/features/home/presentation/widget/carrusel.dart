import 'dart:ui';

import 'package:evertec_technical_test/core/router/route_names.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Widget tipo carrusel con animaciones 3D personalizadas.
///
/// Características:
/// - Mantiene estado con AutomaticKeepAliveClientMixin.
/// - Usa PageView con transformaciones 3D.
/// - Aplica efectos dinámicos (escala, rotación, blur, opacidad).
/// - Controla reinicialización cuando cambian los productos.
/// - Mantiene la página actual al volver desde navegación.
class Carrusel extends StatefulWidget {
  /// Lista de productos a mostrar.
  final List<Product> products;

  const Carrusel({super.key, required this.products});

  @override
  State<Carrusel> createState() => _CarruselState();
}

class _CarruselState extends State<Carrusel>
    with AutomaticKeepAliveClientMixin {
  /// Controlador del PageView.
  late PageController _pageController;

  /// Página actualmente visible.
  int _currentPage = 0;

  /// Indica si el carrusel necesita reiniciarse
  /// (por ejemplo, cuando los productos cambian tras un reintento).
  bool _needsReset = false;

  /// Mantiene el estado del widget vivo dentro de un ScrollView.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  /// Inicializa el PageController y su listener.
  void _initController() {
    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: 0,
      keepPage: false,
    );
    _pageController.addListener(_onPageChanged);
  }

  /// Listener para actualizar la página actual.
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

  /// Detecta cambios en la lista de productos
  /// para reiniciar correctamente el controlador.
  @override
  void didUpdateWidget(Carrusel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si antes estaba vacío y ahora tiene datos, marcar reinicio
    if (oldWidget.products.isEmpty && widget.products.isNotEmpty) {
      _needsReset = true;
    }

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

  /// Limpieza del controlador al destruir el widget.
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
      key: const PageStorageKey('carrusel_section'),
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: PageView.builder(
            key: const PageStorageKey('product_pageview'),
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.products.length,

            /// Construcción dinámica de cada página.
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  /// Página actual con fallback
                  double page = _currentPage.toDouble();

                  if (_pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    page = _pageController.page ?? _currentPage.toDouble();
                  }

                  /// Diferencia entre página actual y el índice
                  final diff = page - index;
                  final absDiff = diff.abs();

                  /// Efectos dinámicos
                  final scale = (1 - (absDiff * 0.1)).clamp(0.4, 1.0);
                  final rotation = absDiff * (-0.8);
                  final opacity = (1 - (absDiff * 0.5)).clamp(0.3, 1.0);
                  final blur = (absDiff * 5).clamp(0.0, 6.0);

                  return Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // perspectiva
                        ..translateByDouble(
                          0.0,
                          absDiff * 20,
                          -absDiff * 80,
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

                /// Tarjeta del producto
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProductCard(
                    product: widget.products[index],

                    /// Navega al detalle y al regresar
                    /// mantiene la página actual.
                    onPressedDetail: () async {
                      await context.pushNamed(
                        RouteNames.detail.name,
                        pathParameters: {
                          "id": widget.products[index].id.toString(),
                        },
                      );

                      if (mounted && _pageController.hasClients) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted && _pageController.hasClients) {
                            _pageController.jumpToPage(_currentPage);
                          }
                        });
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        /// Indicadores de página
        _buildPageIndicators(),
      ],
    );
  }

  /// Construye los indicadores inferiores del carrusel.
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
