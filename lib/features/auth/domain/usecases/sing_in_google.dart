import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';

// Caso de uso para iniciar sesión con Google
class SingInGoogle {
  final AuthRepository repository;

  SingInGoogle(this.repository);

  Future<AppUser> call() async {
    return await repository.signInWithGoogle();
  }
}
