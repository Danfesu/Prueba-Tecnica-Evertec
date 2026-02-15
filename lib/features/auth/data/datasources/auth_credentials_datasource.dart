import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

/// Interface para DataSources de autenticación con credenciales.
///
/// Define el contrato para login y logout con email/password.
abstract class AuthCredentialsDataSource {
  /// Inicia sesión con email y contraseña.
  ///
  /// Retorna el usuario autenticado.
  /// Lanza excepción si las credenciales son inválidas.
  Future<AppUser> signInWithCredential(Email email, Password password);

  /// Cierra la sesión del usuario.
  Future<void> singOut();
}
