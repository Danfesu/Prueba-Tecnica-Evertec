import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

/// Caso de uso encargado de realizar el inicio de sesión
/// utilizando credenciales (email y contraseña).
class SingInCredential {
  /// Repositorio de autenticación que abstrae la implementación
  final AuthRepository repository;

  /// Constructor que recibe el repositorio de autenticación
  /// mediante inyección de dependencias.
  SingInCredential(this.repository);

  /// Ejecuta el caso de uso de inicio de sesión.
  ///
  /// Recibe:
  /// - [email]: Value Object que encapsula y valida el correo electrónico.
  /// - [password]: Value Object que encapsula y valida la contraseña.
  ///
  /// Retorna:
  /// - Un [AppUser] con la información del usuario autenticado.
  ///
  /// Lanza una excepción si ocurre algún error durante la autenticación.
  Future<AppUser> call(Email email, Password password) async {
    return await repository.signInWithCredential(email, password);
  }
}
