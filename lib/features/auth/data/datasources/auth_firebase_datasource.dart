import 'dart:io';

import 'package:evertec_technical_test/core/config/constants/environments.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Datasource que se encarga de la autenticación con Firebase, implementa la interfaz AuthDataSource
class AuthFirebaseDatasource extends AuthGoogleDataSource {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  final SecureStorageService secureStorage;

  AuthFirebaseDatasource(this.secureStorage);

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: Environments.firebaseClientId,
      );
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        throw Exception("Firebase returned null user");
      }

      secureStorage.write("token", user.getIdToken().toString());

      return AppUser(id: user.uid, email: user.email, name: user.displayName);
    } on GoogleSignInException {
      throw const SocketException("No internet connection");
    } on FirebaseException {
      throw Exception("Firebase authentication error");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseException {
      throw Exception("firebase error");
    }
  }
}
