import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_credential.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_in_google.dart';
import 'package:evertec_technical_test/features/auth/domain/usecases/sing_out.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/email_vo.dart';
import 'package:evertec_technical_test/features/auth/domain/valueobjects/password.dart';
import 'package:evertec_technical_test/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit encargado de gestionar el estado de autenticación
/// dentro de la capa de presentación.
///
/// Se comunica con la capa de dominio a través de los casos de uso:
/// - [SingInGoogle]
/// - [SingInCredential]
/// - [SingOut]
///
/// Emite diferentes estados representados por [AuthState]
/// según el resultado de las operaciones de autenticación.
class AuthCubit extends Cubit<AuthState> {
  /// Caso de uso para iniciar sesión con Google.
  final SingInGoogle _singInGoogle;

  /// Caso de uso para cerrar sesión.
  final SingOut _singOut;

  /// Caso de uso para iniciar sesión con credenciales.
  final SingInCredential _singInCredential;

  /// Constructor que recibe los casos de uso mediante
  /// inyección de dependencias.
  ///
  /// Inicializa el estado en [AuthState.initial].
  AuthCubit(this._singInGoogle, this._singOut, this._singInCredential)
    : super(AuthState.initial());

  /// Inicia el proceso de autenticación con Google.
  ///
  /// Flujo:
  /// 1. Emite estado de carga.
  /// 2. Ejecuta el caso de uso correspondiente.
  /// 3. Si es exitoso, emite estado autenticado.
  /// 4. Si falla, emite estado de error.
  void loginWithGoogle(BuildContext context) async {
    emit(AuthState.loading());

    try {
      final user = await _singInGoogle();
      emit(AuthState.authenticated(user: user));
    } catch (e) {
      emit(AuthState.error(message: "Inicio de sesión fallido"));
    }
  }

  /// Inicia el proceso de autenticación utilizando
  /// correo electrónico y contraseña.
  ///
  /// Flujo:
  /// 1. Emite estado de carga.
  /// 2. Crea los Value Objects [Email] y [Password].
  /// 3. Ejecuta el caso de uso correspondiente.
  /// 4. Maneja errores de validación o credenciales inválidas.
  void loginWithCredentials(String email, String password) async {
    emit(AuthState.loading());

    try {
      final user = await _singInCredential(Email(email), Password(password));
      emit(AuthState.authenticated(user: user));
    } on FormatException {
      emit(
        AuthState.error(message: "Formato de correo o contraseña incorrecto"),
      );
      return;
    } catch (e) {
      emit(AuthState.error(message: "Credenciales invalidas"));
      return;
    }
  }

  /// Cierra la sesión del usuario autenticado.
  ///
  /// Flujo:
  /// 1. Emite estado de carga.
  /// 2. Ejecuta el caso de uso de cierre de sesión.
  /// 3. Si es exitoso, emite estado no autenticado.
  /// 4. Si ocurre un error, emite estado de error.
  void logout() async {
    emit(AuthState.loading());
    try {
      await _singOut();
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: "Error al cerrar sesión"));
      return;
    }
  }

  /// Método pensado para validar el estado actual de autenticación.
  ///
  /// Puede utilizarse para:
  /// - Verificar si existe una sesión activa.
  void validateAuthStatus() {
    // Aquí podrías verificar el estado de autenticación del usuario
    // Por ejemplo, podrías consultar un repositorio o servicio de autenticación
    // y emitir el estado correspondiente (autenticado, no autenticado, etc.)
  }
}
