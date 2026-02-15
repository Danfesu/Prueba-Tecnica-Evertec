import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

/// Repositorio de autenticación.
///
/// Define el contrato para operaciones de autenticación
/// en la capa de dominio.
abstract class AuthRepository {
  /// Inicia sesión con Google.
  Future<AppUser> signInWithGoogle();

  /// Inicia sesión con email y contraseña.
  Future<AppUser> signInWithCredential(Email email, Password password);

  /// Cierra la sesión del usuario.
  Future<void> signOut();
}
