import 'dart:io';

import 'package:evertec_technical_test/core/config/constants/environments.dart';
import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_google_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// DataSource para autenticación con Google usando Firebase.
///
/// **Requisitos previos:**
/// - Firebase configurado en el proyecto
/// - Google Sign In habilitado en Firebase Console
/// - `SERVER_FIREBASE_CLIENT_ID` configurado en .env
/// - SHA-1 y SHA-256 registrados en Firebase (Android)
/// - OAuth Client ID configurado (iOS)
///
class AuthFirebaseDatasource extends AuthGoogleDataSource {
  /// Instancia de Firebase Authentication.
  ///
  /// Maneja la autenticación con Firebase después de obtener
  /// las credenciales de Google.
  final _auth = FirebaseAuth.instance;

  /// Instancia de Google Sign In.
  ///
  /// Maneja el flujo de autenticación con Google (selector de cuenta,
  /// permisos, obtención de tokens).
  final _googleSignIn = GoogleSignIn.instance;

  /// Servicio de almacenamiento seguro para guardar tokens.
  final SecureStorageService secureStorage;

  AuthFirebaseDatasource(this.secureStorage);

  /// Inicia sesión con Google usando Firebase Auth.
  ///
  /// **Flujo completo:**
  /// 1. Inicializa GoogleSignIn con serverClientId de Firebase
  /// 2. Muestra diálogo de Google para seleccionar cuenta
  /// 3. Usuario selecciona cuenta y otorga permisos
  /// 4. Google retorna tokens de autenticación
  /// 5. Tokens se intercambian por credenciales de Firebase
  /// 6. Firebase autentica al usuario con las credenciales
  /// 7. Token de Firebase se guarda en almacenamiento seguro
  /// 8. Se retorna el usuario autenticado
  ///
  /// **Retorna:**
  /// - [AppUser]: Usuario autenticado con id, email y nombre
  ///
  /// **Lanza:**
  /// - [SocketException]: Si no hay conexión a internet
  /// - [FirebaseException]: Si hay error en Firebase Auth
  /// - [Exception]: Si Firebase retorna usuario nulo o error general
  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      // Inicializa con serverClientId de Firebase
      // Este ID se obtiene de Firebase Console → Project Settings
      // → Web API Key (para Android) o OAuth Client ID (para iOS)
      await _googleSignIn.initialize(
        serverClientId: Environments.firebaseClientId,
      );

      // Muestra el diálogo de Google Sign In
      // Usuario selecciona cuenta y otorga permisos
      final googleUser = await _googleSignIn.authenticate();

      // Obtiene los tokens de autenticación de Google
      // (idToken y accessToken)
      final googleAuth = googleUser.authentication;

      // Crea credenciales de Firebase usando el idToken de Google
      // Firebase usará este token para verificar la autenticidad
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Autentica al usuario en Firebase con las credenciales
      final userCredential = await _auth.signInWithCredential(credential);

      // Obtiene el usuario autenticado de Firebase
      final user = userCredential.user;

      // Verificar que Firebase retornó un usuario válido
      if (user == null) {
        throw Exception("Firebase returned null user");
      }

      // Guardar el token de Firebase en almacenamiento seguro
      // Este token se usará para autenticar peticiones HTTP
      secureStorage.write("token", user.getIdToken().toString());

      // Crear y retornar la entidad de dominio AppUser
      return AppUser(
        id: user.uid,
        email: user.email ?? "no email",
        name: user.displayName ?? "no name",
      );
    } on GoogleSignInException {
      // GoogleSignInException generalmente indica problemas de red
      throw const SocketException("No internet connection");
    } on FirebaseException {
      // Errores de Firebase Auth (credenciales inválidas, usuario
      // deshabilitado, límite de rate excedido, etc.)
      throw Exception("Firebase authentication error");
    } catch (e) {
      // Relanzar excepción para ser manejada en capas superiores (Usuario canceló, errores inesperados)
      rethrow;
    }
  }

  /// Cierra la sesión del usuario.
  ///
  /// Cierra sesión tanto en Firebase como en Google Sign In
  /// y elimina el token del almacenamiento seguro.
  ///
  /// **Flujo:**
  /// 1. Cierra sesión en Firebase Auth
  /// 2. Cierra sesión en Google Sign In
  /// 3. Elimina token del almacenamiento seguro
  ///
  /// **Lanza:**
  /// - [Exception]: Si hay error en Firebase al cerrar sesión
  @override
  Future<void> signOut() async {
    try {
      // Cerrar sesión en Firebase
      await _auth.signOut();

      // Cerrar sesión en Google Sign In
      await _googleSignIn.signOut();

      // Eliminar token del almacenamiento seguro
      secureStorage.delete("token");
    } on FirebaseException {
      // Error al cerrar sesión en Firebase
      throw Exception("firebase error");
    }
  }
}
