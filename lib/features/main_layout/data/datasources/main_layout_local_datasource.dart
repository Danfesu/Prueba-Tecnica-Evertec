import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:flutter/material.dart';

/// Implementación local del datasource para el layout principal.
///
/// Esta clase provee las páginas que se mostrarán en la navegación
/// principal de la aplicación. En este caso, los datos son simulados
/// localmente (no provienen de una API ni base de datos).
class MainLayoutLocalDatasource implements MainLayoutDatasource {
  /// Obtiene la lista de páginas disponibles en el layout principal.
  ///
  /// Simula una pequeña latencia con [Future.delayed] para representar
  /// un posible acceso a datos (como una llamada remota o base de datos).
  ///
  /// Retorna una lista de [ItemPage] que contiene:
  /// - Icono a mostrar en la navegación.
  /// - Etiqueta descriptiva.
  /// - Ruta asociada para navegación.
  @override
  Future<List<ItemPage>> getPages() async {
    // Simulación de latencia
    await Future.delayed(Duration(milliseconds: 50));

    // Lista de páginas disponibles
    List<ItemPage> pages = [];

    // Página principal de productos
    pages.add(
      ItemPage(
        icon: Icons.add_shopping_cart_outlined,
        label: "Productos",
        route: RoutePaths.home,
      ),
    );

    return pages;
  }
}
