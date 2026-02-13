import 'package:evertec_technical_test/features/home/domain/entities/Tag.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final int width;
  final int height;
  final int depth;
  final String imageUrl;
  final List<Tag> tags;

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
