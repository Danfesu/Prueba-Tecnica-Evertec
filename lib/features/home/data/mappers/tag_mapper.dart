import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

class TagMapper {
  // Convertir de Entity a Domain
  static Tag entityToDomain(TagEntity entity) {
    return Tag(id: entity.id, name: entity.name);
  }
}
