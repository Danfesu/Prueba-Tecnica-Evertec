/// Value Object que representa un correo electrónico válido.
///
/// Encapsula la lógica de validación del email y garantiza
/// que solo se puedan crear instancias con un formato correcto.
///
/// Forma parte de la capa de dominio siguiendo los principios
/// de Domain-Driven Design (DDD).
class Email {
  /// Valor del correo electrónico.
  /// Es inmutable y se garantiza que cumple con el formato válido
  /// al momento de crear la instancia.
  final String value;

  /// Constructor que recibe el valor del email y valida su formato.
  /// Lanza una [FormatException] si el formato del correo no es válido.
  Email(this.value) {
    if (!_isValidEmail(value)) {
      throw FormatException('Invalid email format');
    }
  }

  /// Método privado que valida el formato del correo electrónico
  /// utilizando una expresión regular.
  /// Retorna `true` si el formato es válido, de lo contrario `false`.
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
