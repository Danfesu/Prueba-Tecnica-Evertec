/// Entidad de dominio que representa una etiqueta (Tag)
/// asociada a un producto.
/// Las etiquetas permiten clasificar o categorizar
/// productos mediante palabras clave.
class Tag {
  /// Identificador único de la etiqueta.
  ///
  /// Es opcional porque:
  /// - Puede no existir cuando se crea desde la API.
  /// - Puede generarse al persistirse en base de datos local.
  final int? id;

  /// Nombre descriptivo de la etiqueta.
  final String name;

  Tag({this.id, required this.name});
}
