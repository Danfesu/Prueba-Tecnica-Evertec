import 'package:evertec_technical_test/core/router/route_paths.dart';
import 'package:evertec_technical_test/features/main_layout/data/datasources/main_layout_datasource.dart';
import 'package:evertec_technical_test/features/main_layout/domain/entities/item_page.dart';
import 'package:flutter/material.dart';

class MainLayoutLocalDatasource implements MainLayoutDatasource {
  @override
  Future<List<ItemPage>> getPages() async {
    await Future.delayed(Duration(milliseconds: 50));

    List<ItemPage> pages = [];

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
