import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// SliverAppBar personalizado para la pantalla de detalle de producto.
///
/// - Muestra la imagen del producto ocupando el 50% del alto de la pantalla.
/// - Permite regresar a la pantalla anterior usando `context.pop()`.
/// - Usa `CachedNetworkImage` para manejo de caché de imágenes.
/// - Aplica animación `FadeIn` cuando la imagen termina de cargar.
/// - En caso de error (ej: sin conexión), muestra una imagen local de respaldo.
class DetailAppBar extends StatelessWidget {
  /// Entidad de dominio que contiene la información del producto
  /// (incluye `imageUrl`).
  final Product product;

  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Obtiene el tamaño actual de la pantalla
    final size = MediaQuery.of(context).size;

    // Obtiene el color de fondo definido en el tema del Scaffold
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      // Color de fondo basado en el tema actual
      backgroundColor: scaffoldBackgroundColor,

      // Botón de navegación hacia atrás
      leading: IconButton(
        onPressed: () {
          // Regresa a la pantalla anterior usando go_router
          context.pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),

      // Altura expandida equivalente al 50% de la pantalla
      expandedHeight: size.height * 0.5,

      // Color de iconos y texto basado en el colorScheme actual
      foregroundColor: Theme.of(context).colorScheme.onSurface,

      // Espacio reservado para posibles acciones futuras
      actions: [],

      flexibleSpace: FlexibleSpaceBar(
        // Elimina padding inferior por defecto del título
        titlePadding: const EdgeInsets.only(bottom: 0),

        // Fondo flexible que contiene la imagen del producto
        background: Stack(
          children: [
            SizedBox.expand(
              child: CachedNetworkImage(
                // URL de la imagen del producto
                imageUrl: product.imageUrl,

                // Ajusta la imagen sin recortarla
                fit: BoxFit.contain,

                // Widget que se muestra mientras la imagen carga
                placeholder: (context, url) => const SizedBox(),

                // Widget que se muestra si ocurre un error al cargar la imagen
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/no_connection.jpg',
                  fit: BoxFit.contain,
                ),

                // Builder que permite animar la imagen una vez cargada
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
