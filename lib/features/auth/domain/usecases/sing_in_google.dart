import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso encargado de realizar el inicio de sesión
/// mediante autenticación con Google.
class SingInGoogle {
  /// Repositorio de autenticación que abstrae la lógica
  /// de integración con el proveedor externo (Google).
  final AuthRepository repository;

  /// Constructor que recibe el repositorio mediante
  /// inyección de dependencias.
  SingInGoogle(this.repository);

  /// Ejecuta el proceso de autenticación con Google.
  ///
  /// Retorna:
  /// - Un [AppUser] con la información del usuario autenticado.
  ///
  /// Puede lanzar una excepción si el proceso de autenticación falla
  /// o es cancelado por el usuario.
  Future<AppUser> call() async {
    return await repository.signInWithGoogle();
  }
}
