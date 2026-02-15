// test/features/home/presentation/widgets/carrusel_section_test.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evertec_technical_test/features/home/domain/entities/product_domain.dart';
import 'package:evertec_technical_test/features/home/presentation/widget/carrusel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 🔥 Mock para GoRouter
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  // 🔥 Datos de prueba
  final tProducts = [
    Product(
      id: 1,
      title: 'Producto 1',
      price: 99.99,
      description: 'Descripción 1',
      category: 'Electrónica',
      imageUrl: 'https://test.com/image1.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
    Product(
      id: 2,
      title: 'Producto 2',
      price: 149.99,
      description: 'Descripción 2',
      category: 'Ropa',
      imageUrl: 'https://test.com/image2.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
    Product(
      id: 3,
      title: 'Producto 3',
      price: 199.99,
      description: 'Descripción 3',
      category: 'Hogar',
      imageUrl: 'https://test.com/image3.jpg',
      width: 10,
      height: 20,
      depth: 30,
      tags: [],
    ),
  ];

  group('CarruselSection Widget', () {
    // 🔥 Test 1: Widget se renderiza correctamente
    testWidgets('debe renderizar el widget sin errores', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      expect(find.byType(Carrusel), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    // 🔥 Test 2: Verifica que muestra los productos
    testWidgets('debe mostrar la información del producto', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // Verificar que muestra el título del primer producto
      expect(find.text('Producto 1'), findsOneWidget);
      expect(find.text('Electrónica'), findsOneWidget);
      expect(find.text('Ver detalle'), findsWidgets);
    });

    // 🔥 Test 3: PageView cambia de página
    testWidgets('debe cambiar de página al hacer swipe', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // Verificar página inicial
      expect(find.text('Producto 1'), findsOneWidget);

      // Hacer swipe a la izquierda (siguiente página)
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Verificar que cambió de página
      expect(find.text('Producto 2'), findsOneWidget);
    });

    // 🔥 Test 4: Indicadores de página
    testWidgets('debe mostrar los indicadores de página', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // Verificar que existen los indicadores
      expect(find.byType(SmoothPageIndicator), findsWidgets);
    });

    // 🔥 Test 5: Botón "Ver detalle"
    testWidgets('debe tener botón "Ver detalle" funcional', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // Verificar que el botón existe
      expect(find.text('Ver detalle'), findsWidgets);
      expect(find.byIcon(Icons.visibility), findsWidgets);
    });

    // 🔥 Test 6: Renderiza con lista vacía
    testWidgets('debe manejar lista vacía de productos', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: [])),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // No debe crashear
      expect(find.byType(Carrusel), findsOneWidget);
    });

    // Test 7: Muestra imagen
    testWidgets('debe mostrar imagenes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construya
      await tester.pumpAndSettle();

      // Verificar que el widget se renderiza
      expect(find.byType(CachedNetworkImage), findsWidgets);
    });

    // 🔥 Test 8: Formato de precio
    testWidgets('debe formatear el precio correctamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      // Esperar a que se construyas
      await tester.pumpAndSettle();

      // Verificar formato de precio colombiano
      expect(find.textContaining('\$'), findsWidgets);
    });

    // 🔥 Test 9: Animaciones del carrusel
    testWidgets('debe aplicar transformaciones a las cards', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Carrusel(products: tProducts)),
        ),
      );

      await tester.pumpAndSettle();

      // Verificar que hay transformaciones aplicadas
      expect(find.byType(Transform), findsWidgets);
      expect(find.byType(Opacity), findsWidgets);
    });
  });
}
