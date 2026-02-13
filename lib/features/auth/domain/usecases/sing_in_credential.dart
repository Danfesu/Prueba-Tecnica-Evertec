import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

class SingInCredential {
  final AuthRepository repository;

  SingInCredential(this.repository);

  Future<AppUser> call(Email email, Password password) async {
    return await repository.signInWithCredential(email, password);
  }
}
