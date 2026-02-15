/// Value Object que representa una contraseña válida.
///
/// Encapsula la lógica de validación de seguridad y garantiza
/// que solo se puedan crear instancias con un formato correcto.
///
/// Forma parte de la capa de dominio siguiendo los principios
/// de Domain-Driven Design (DDD), asegurando que las reglas
/// del negocio se cumplan desde el momento de la creación.
class Password {
  /// Valor de la contraseña.
  /// Es inmutable y su validez se garantiza en el constructor.
  final String value;

  /// Constructor que recibe el valor de la contraseña y valida
  /// que cumpla con las reglas de seguridad definidas.
  /// Reglas:
  /// - Mínimo 8 caracteres.
  /// - Al menos una letra mayúscula.
  /// - Al menos una letra minúscula.
  /// - Al menos un número.
  /// - Al menos un carácter especial (@$!%*?&).
  ///
  /// Lanza una [FormatException] si la contraseña no cumple
  /// con los requisitos establecidos.
  Password(this.value) {
    if (!_isValidPassword(value)) {
      throw FormatException(
        'Invalid password format. Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number.',
      );
    }
  }

  /// Método privado que valida el formato de la contraseña
  /// utilizando una expresión regular.
  ///
  /// Retorna `true` si cumple con las reglas de seguridad,
  /// de lo contrario `false`.
  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
