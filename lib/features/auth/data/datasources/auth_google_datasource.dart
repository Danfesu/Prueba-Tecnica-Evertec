import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';

/// Interface para DataSources de autenticación con Google.
///
/// Define el contrato para login y logout con Google Sign In.
abstract class AuthGoogleDataSource {
  /// Inicia sesión con Google.
  ///
  /// Retorna el usuario autenticado.
  /// Lanza excepción si hay error en el proceso.
  Future<AppUser> signInWithGoogle();

  /// Cierra la sesión del usuario.
  Future<void> signOut();
}
