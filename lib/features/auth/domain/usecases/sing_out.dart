import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso encargado de cerrar la sesión del usuario autenticado.
class SingOut {
  /// Repositorio de autenticación que abstrae la implementación
  final AuthRepository repository;

  /// Constructor que recibe el repositorio mediante
  /// inyección de dependencias.
  SingOut(this.repository);

  /// Ejecuta el proceso de cierre de sesión.
  ///
  /// Retorna un [Future<void>] que se completa cuando la sesión
  /// ha sido cerrada correctamente.
  ///
  /// Puede lanzar una excepción si ocurre un error durante
  /// el proceso de cierre de sesión.
  Future<void> call() async {
    return repository.signOut();
  }
}
