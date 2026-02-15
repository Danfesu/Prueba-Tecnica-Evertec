import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

abstract class AuthCredentialsDataSource {
  Future<AppUser> signInWithCredential(Email email, Password password);
  Future<void> singOut();
}
