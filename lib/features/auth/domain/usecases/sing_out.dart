import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';

// Caso de uso para cerrar sesión
class SingOut {
  final AuthRepository repository;

  SingOut(this.repository);

  Future<void> call() async {
    return repository.signOut();
  }
}
