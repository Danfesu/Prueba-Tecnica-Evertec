import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

/// Entidad de dominio que representa un Producto dentro de la aplicación.
/// Representa la estructura principal utilizada por los casos de uso
/// y la capa de presentación.
class Product {
  /// Identificador único del producto.
  final int id;

  /// Nombre o título del producto.
  final String title;

  /// Descripción detallada del producto.
  final String description;

  /// Categoría a la que pertenece el producto.
  final String category;

  /// Precio del producto.
  final double price;

  /// Ancho del producto.
  final int width;

  /// Alto del producto.
  final int height;

  /// Profundidad del producto.
  final int depth;

  /// URL de la imagen o thumbnail del producto.
  final String imageUrl;

  /// Lista de etiquetas asociadas al producto.
  ///
  /// No es final porque puede ser enriquecida posteriormente,
  /// por ejemplo cuando se cargan desde la base de datos local.
  List<Tag> tags;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.width,
    required this.height,
    required this.depth,
    required this.tags,
  });
}
