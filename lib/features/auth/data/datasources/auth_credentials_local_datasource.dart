import 'package:evertec_technical_test/core/services/storage/secure_storage_service.dart';
import 'package:evertec_technical_test/features/auth/data/datasources/auth_credentials_datasource.dart';
import 'package:evertec_technical_test/features/auth/domain/entities/app_user.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';

// Servicio dummy para simular la autenticación con credenciales, utilizando un almacenamiento seguro para guardar el token
class AuthCredentialsLocalDatasource extends AuthCredentialsDataSource {
  final SecureStorageService secureStorage;

  AuthCredentialsLocalDatasource(this.secureStorage);

  final Map<String, String> _userAdmin = {
    "id": "1",
    "email": "admin@evertec.com",
    "password": "Admin123*",
    "name": "Admin User",
    "token": "fake_token_1234567890",
  };

  @override
  Future<AppUser> signInWithCredential(Email email, Password password) async {
    await Future.delayed(
      const Duration(seconds: 1), // Simula una llamada a la API
    );
    if (_userAdmin["email"] == email.value &&
        _userAdmin["password"] == password.value) {
      // Guarda el token en el almacenamiento seguro
      secureStorage.write("token", _userAdmin["token"]!);

      // Retorna un usuario simulado
      return AppUser(
        id: _userAdmin["id"]!,
        email: _userAdmin["email"]!,
        name: _userAdmin["name"]!,
      );
    }
    throw Exception("Invalid credentials");
  }

  @override
  Future<void> singOut() async {
    await Future.delayed(
      const Duration(seconds: 1), // Simula una llamada a la API
    );
    secureStorage.delete("token");
  }
}
