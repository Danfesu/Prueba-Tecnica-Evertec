import 'package:evertec_technical_test/core/databases/app_database.dart';
import 'package:evertec_technical_test/features/home/domain/entities/tag_domain.dart';

/// Mapper encargado de convertir objetos relacionados con Tags
/// entre la capa de persistencia (Entity) y la capa de dominio.
///
/// Su propósito es mantener desacopladas las entidades de base
/// de datos de las entidades de negocio siguiendo Clean Architecture.
class TagMapper {
  /// Convierte un [TagEntity] (modelo de base de datos)
  /// en un [Tag] (entidad de dominio).
  ///
  /// Se utiliza normalmente después de realizar consultas
  /// a la base de datos para transformar los datos almacenados
  /// en objetos que la lógica de negocio pueda utilizar.
  static Tag entityToDomain(TagEntity entity) {
    return Tag(id: entity.id, name: entity.name);
  }
}
