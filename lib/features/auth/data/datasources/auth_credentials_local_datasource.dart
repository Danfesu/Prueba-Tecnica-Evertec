import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

/// DataSource local para autenticación con credenciales (mock).
///
/// Simula un servicio de autenticación sin hacer llamadas reales a API.
/// Usa datos hardcodeados para testing y desarrollo.
///
/// **⚠️ SOLO PARA DESARROLLO/TESTING:**
/// - No usar en producción
/// - Reemplazar con [AuthCredentialsRemoteDataSource] en producción
/// - Credenciales hardcodeadas son un riesgo de seguridad
///
/// **Credenciales de prueba:**
/// - Email: `admin@evertec.com`
/// - Password: `Admin123*`
///
/// **Flujo de autenticación:**
/// 1. Recibe email y password
/// 2. Verifica contra credenciales hardcodeadas
/// 3. Simula delay de red (1 segundo)
/// 4. Guarda token fake en SecureStorage
/// 5. Retorna usuario mock
///
/// // Login
/// final user = await datasource.signInWithCredential(
///   Email('admin@evertec.com'),
///   Password('Admin123*'),
/// );
///
/// // Logout
/// await datasource.singOut();
/// ```
class AuthCredentialsLocalDatasource extends AuthCredentialsDataSource {
  /// Servicio de almacenamiento seguro para guardar tokens.
  final SecureStorageService secureStorage;

  AuthCredentialsLocalDatasource(this.secureStorage);

  /// Credenciales y datos del usuario administrador mock.
  ///
  /// **Campos:**
  /// - `id`: ID único del usuario
  /// - `email`: Email de login
  /// - `password`: Contraseña
  /// - `name`: Nombre completo del usuario
  /// - `token`: Token JWT fake para simular autenticación
  ///
  /// **⚠️ IMPORTANTE:**
  /// Estas credenciales son solo para desarrollo.
  /// En producción, las credenciales se verifican en el backend.
  final Map<String, String> _userAdmin = {
    "id": "1",
    "email": "admin@evertec.com",
    "password": "Admin123*",
    "name": "Admin User",
    "token": "fake_token_1234567890",
  };

  /// Inicia sesión con email y contraseña.
  ///
  /// Simula una llamada a API con delay de 1 segundo.
  ///
  /// **Flujo:**
  /// 1. Espera 1 segundo (simula latencia de red)
  /// 2. Verifica email y password contra datos mock
  /// 3. Si coinciden:
  ///    - Guarda token en SecureStorage
  ///    - Retorna usuario
  /// 4. Si no coinciden:
  ///    - Lanza excepción
  ///
  /// **Parámetros:**
  /// - [email]: Email del usuario (value object validado)
  /// - [password]: Contraseña del usuario (value object validado)
  ///
  /// **Retorna:**
  /// - [AppUser]: Usuario autenticado con id, email y nombre
  ///
  /// **Lanza:**
  /// - [Exception]: Si las credenciales no coinciden
  @override
  Future<AppUser> signInWithCredential(Email email, Password password) async {
    // Simula latencia de red (1 segundo)
    await Future.delayed(const Duration(seconds: 1));

    // Verificar credenciales contra datos mock
    if (_userAdmin["email"] == email.value &&
        _userAdmin["password"] == password.value) {
      // Guardar token en almacenamiento seguro
      // Este token se usará en peticiones HTTP subsiguientes
      secureStorage.write("token", _userAdmin["token"]!);

      // Retornar usuario simulado
      return AppUser(
        id: _userAdmin["id"]!,
        email: _userAdmin["email"]!,
        name: _userAdmin["name"]!,
      );
    }
    // Lanzar excepción (será manejada en el Repository)
    throw Exception("Invalid credentials");
  }

  /// Cierra la sesión del usuario.
  ///
  /// Simula una llamada a API con delay de 1 segundo.
  ///
  /// **Flujo:**
  /// 1. Espera 1 segundo (simula latencia de red)
  /// 2. Elimina token del SecureStorage
  ///
  /// **Nota:**
  /// En producción, también debería:
  /// - Invalidar token en el backend
  /// - Limpiar caché local
  /// - Notificar al servidor del logout
  @override
  Future<void> singOut() async {
    // Simula latencia de red (1 segundo)
    await Future.delayed(const Duration(seconds: 1));

    // Eliminar token del almacenamiento seguro
    secureStorage.delete("token");
  }
}
