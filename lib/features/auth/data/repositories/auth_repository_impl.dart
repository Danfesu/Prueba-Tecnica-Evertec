import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_datasource.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_google_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

/// Implementación del repositorio de autenticación.
///
/// Capa que abstrae la lógica de autenticación de los DataSources.
/// Coordina entre diferentes métodos de autenticación:
/// - Google Sign In (Firebase)
/// - Email y contraseña (Credenciales)
///
/// **Responsabilidades:**
/// - Orquestar llamadas a DataSources
/// - Manejar errores de las fuentes de datos
/// - Convertir excepciones en objetos de dominio (Failures)
/// - Mantener consistencia entre diferentes métodos de auth
///
class AuthRepositoryImpl extends AuthRepository {
  /// DataSource para autenticación con Google/Firebase.
  ///
  /// Maneja el flujo de Google Sign In y Firebase Auth.
  final AuthGoogleDataSource datasource;

  /// DataSource para autenticación con email/password.
  ///
  /// Maneja el flujo de login con credenciales (mock o API real).
  final AuthCredentialsDataSource credentialsDataSource;

  AuthRepositoryImpl(this.datasource, this.credentialsDataSource);

  /// Inicia sesión con Google.
  ///
  /// Delega al [AuthGoogleDataSource] para manejar el flujo completo
  /// de autenticación con Google y Firebase.
  ///
  /// **Retorna:**
  /// - [AppUser]: Usuario autenticado con datos de Google
  ///
  /// **Lanza:**
  /// - [Exception]: Si hay error en el proceso de autenticación
  ///   (sin conexión, usuario canceló, error de Firebase, etc.)
  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      // Delegar autenticación al DataSource de Google
      return await datasource.signInWithGoogle();
    } catch (e) {
      // Propagar excepción para ser manejada en capas superiores
      // (UseCases, Cubits)
      throw Exception();
    }
  }

  /// Cierra la sesión del usuario.
  ///
  /// Cierra sesión en **ambos** métodos de autenticación:
  /// - Google Sign In / Firebase
  /// - Credenciales locales
  ///
  /// Esto asegura que el usuario esté completamente deslogueado
  /// sin importar qué método usó para iniciar sesión.
  ///
  /// **Lanza:**
  /// - [Exception]: Si hay error al cerrar sesión en alguno
  ///   de los DataSources
  @override
  Future<void> signOut() async {
    try {
      // Cerrar sesión en Google/Firebase
      await datasource.signOut();
      // Cerrar sesión en sistema de credenciales
      await credentialsDataSource.singOut();
    } catch (e) {
      // Propagar excepción para ser manejada en capas superiores
      throw Exception();
    }
  }

  /// Inicia sesión con email y contraseña.
  ///
  /// Delega al [AuthCredentialsDataSource] para manejar el flujo
  /// de autenticación con credenciales.
  ///
  /// **Parámetros:**
  /// - [email]: Email del usuario (value object validado)
  /// - [password]: Contraseña del usuario (value object validado)
  ///
  /// **Retorna:**
  /// - [AppUser]: Usuario autenticado con datos del sistema
  ///
  /// **Lanza:**
  /// - [Exception]: Si las credenciales son inválidas o hay
  ///   error en el proceso de autenticación
  @override
  Future<AppUser> signInWithCredential(Email email, Password password) async {
    try {
      // Delegar autenticación al DataSource de credenciales
      return await credentialsDataSource.signInWithCredential(email, password);
    } catch (e) {
      // Propagar excepción para ser manejada en capas superiores
      throw Exception();
    }
  }
}
