import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthGoogleDataSource datasource;
  final AuthCredentialsDataSource credentialsDataSource;

  AuthRepositoryImpl(this.datasource, this.credentialsDataSource);

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      return await datasource.signInWithGoogle();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await datasource.signOut();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AppUser> signInWithCredential(Email email, Password password) async {
    try {
      return await credentialsDataSource.signInWithCredential(email, password);
    } catch (e) {
      throw Exception();
    }
  }
}
