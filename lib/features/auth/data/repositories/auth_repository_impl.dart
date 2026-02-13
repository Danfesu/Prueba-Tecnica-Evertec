import 'package:evertec_technical_test/core/errors/server_exception.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthGoogleDataSource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      return await datasource.signInWithGoogle();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await datasource.signOut();
    } catch (e) {
      throw ServerException();
    }
  }
}
