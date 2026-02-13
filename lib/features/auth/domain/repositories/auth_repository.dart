import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';

// Repositorio de autenticación que define los métodos para iniciar sesión y cerrar sesión
abstract class AuthRepository {
  Future<AppUser> signInWithGoogle();
  Future<void> signOut();
}
