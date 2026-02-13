import 'dart:io';

import 'package:evertec_technical_test/core/errors/network_exception.dart';
import 'package:evertec_technical_test/core/errors/server_exception.dart';
import 'package:evertec_technical_test/core/logger/app_logger.dart';
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
    } on SocketException {
      throw NetworkException();
    } catch (e, s) {
      AppLogger.error(
        "AuthRepository.signInWithGoogle failed",
        error: e,
        stackTrace: s,
      );
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await datasource.signOut();
    } on SocketException {
      throw NetworkException();
    } catch (e, s) {
      AppLogger.error("AuthRepository.signOut failed", error: e, stackTrace: s);
      throw ServerException();
    }
  }
}
