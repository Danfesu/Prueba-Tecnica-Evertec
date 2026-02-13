import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';

// Interfaz del datasource de autenticación que define los métodos para iniciar sesión y cerrar sesión
abstract class AuthGoogleDataSource {
  Future<AppUser> signInWithGoogle();
  Future<void> signOut();
}
